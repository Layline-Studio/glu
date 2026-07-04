import { getAuthContext } from "../_shared/auth.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { errorResponse, jsonResponse } from "../_shared/response.ts";
import { getServiceClient } from "../_shared/supabase.ts";
import { createPendingAiRequest, finalizeAiRequest } from "../_shared/usage.ts";
import {
  analyzeMealFromAudio,
  analyzeMealFromImage,
  analyzeMealFromText,
  type CheckPortion,
  snapMacroStorageBucket,
  normalizeLocaleCode,
  toSnapMacroApiResponse,
  validateSnapMacroRequestInput,
} from "./core.ts";

declare const EdgeRuntime: {
  waitUntil(promise: Promise<unknown>): void;
};

type SnapMacroRow = {
  id: string;
  user_id: string;
  request: {
    imagePath?: string;
    text?: string;
    audioBase64?: string;
    mimeType?: string;
    checkPortion?: CheckPortion;
  } | null;
  response: Record<string, unknown> | null;
  status: string;
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { status: 200, headers: corsHeaders });
  }

  try {
    if (req.method === "POST") {
      return await handlePostSnapMacro(req);
    }
    if (req.method === "GET") {
      return await handleGetSnapMacro(req);
    }
    return errorResponse("Method not allowed", 405);
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    const status = message == "Unauthorized"
      ? 401
      : message.startsWith("Missing ") || message.startsWith("Unsupported ") ||
          message.startsWith("Invalid ")
      ? 400
      : message === "Not found"
      ? 404
      : 500;
    return errorResponse(message, status);
  }
});

async function handlePostSnapMacro(req: Request) {
  const { userId } = await getAuthContext(req);
  const body = await req.json().catch(() => ({}));
  const input = validateSnapMacroRequestInput(body);
  const client = getServiceClient();
  const requestId = await createPendingAiRequest(client, {
    userId,
    featureName: "snap-macro",
    request: input,
  });

  EdgeRuntime.waitUntil(processSnapMacroRequest(requestId));

  return jsonResponse({ id: requestId }, { status: 202 });
}

async function handleGetSnapMacro(req: Request) {
  const { userId } = await getAuthContext(req);
  const url = new URL(req.url);
  const id = url.searchParams.get("id")?.trim() ?? "";

  if (!id) {
    throw new Error("Missing id");
  }

  const client = getServiceClient();
  const request = await getSnapMacroRequest(client, id, userId);

  return jsonResponse({
    status: request.status,
    response: request.response,
  });
}

async function processSnapMacroRequest(requestId: string): Promise<void> {
  const client = getServiceClient();
  const request = await getSnapMacroRequest(client, requestId);
  const imagePath = typeof request.request?.imagePath === "string"
    ? request.request.imagePath.trim()
    : "";
  const text = typeof request.request?.text === "string"
    ? request.request.text.trim()
    : "";
  const audioBase64 = typeof request.request?.audioBase64 === "string"
    ? request.request.audioBase64.trim()
    : "";
  const mimeType = typeof request.request?.mimeType === "string"
    ? request.request.mimeType.trim().toLowerCase()
    : "";
  const checkPortion = request.request?.checkPortion ?? undefined;
  const userLocale = await getUserLocale(client, request.user_id);

  try {
    if (text) {
      const result = await analyzeMealFromText(
        text,
        checkPortion,
        userLocale,
      );
      await finalizeAiRequest(client, {
        requestId,
        status: "completed",
        response: toSnapMacroApiResponse(result) as Record<string, unknown>,
        ...(result.usage == null ? {} : {
          model: result.usage.model,
          inputTokens: result.usage.inputTokens,
          outputTokens: result.usage.outputTokens,
        }),
      });
      return;
    }

    if (audioBase64) {
      if (!mimeType) {
        throw new Error("Invalid request mimeType");
      }
      const result = await analyzeMealFromAudio(
        { audioBase64, mimeType },
        checkPortion,
        userLocale,
      );
      await finalizeAiRequest(client, {
        requestId,
        status: "completed",
        response: toSnapMacroApiResponse(result) as Record<string, unknown>,
        ...(result.usage == null ? {} : {
          model: result.usage.model,
          inputTokens: result.usage.inputTokens,
          outputTokens: result.usage.outputTokens,
        }),
      });
      return;
    }

    if (!imagePath) {
      throw new Error("Invalid request imagePath");
    }
    if (!mimeType) {
      throw new Error("Invalid request mimeType");
    }

    const downloadResult = await client.storage.from(snapMacroStorageBucket)
      .download(
        imagePath,
      );
    if (downloadResult.error || !downloadResult.data) {
      throw new Error(
        downloadResult.error?.message ?? "Could not download image.",
      );
    }

    const bytes = new Uint8Array(await downloadResult.data.arrayBuffer());
    const result = await analyzeMealFromImage(
      { imageBase64: encodeImageBase64(bytes), mimeType },
      checkPortion,
      userLocale,
    );

    await finalizeAiRequest(client, {
      requestId,
      status: "completed",
      response: toSnapMacroApiResponse(result) as Record<string, unknown>,
      ...(result.usage == null ? {} : {
        model: result.usage.model,
        inputTokens: result.usage.inputTokens,
        outputTokens: result.usage.outputTokens,
      }),
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    await finalizeAiRequest(client, {
      requestId,
      status: "failed",
      response: {
        success: false,
        reason: message,
        response: null,
      },
    });
  }
}

async function getUserLocale(
  client: ReturnType<typeof getServiceClient>,
  userId: string,
): Promise<string | null> {
  const { data, error } = await client.from("profiles").select("settings")
    .eq("id", userId)
    .maybeSingle();

  if (error || !data) {
    return null;
  }

  const settings = data.settings;
  const rawLocale = settings && typeof settings === "object" &&
      !Array.isArray(settings)
    ? (settings as Record<string, unknown>).app_locale
    : null;
  const localeCode = typeof rawLocale === "string" ? rawLocale : null;
  return normalizeLocaleCode(localeCode);
}

async function getSnapMacroRequest(
  client: ReturnType<typeof getServiceClient>,
  requestId: string,
  userId?: string,
): Promise<SnapMacroRow> {
  let query = client.from("ai_requests").select(
    "id, user_id, request, response, status",
  ).eq("id", requestId).eq("feature_name", "snap-macro");

  if (userId) {
    query = query.eq("user_id", userId);
  }

  const { data, error } = await query.maybeSingle();

  if (error) {
    throw new Error(error.message);
  }

  if (!data) {
    throw new Error("Not found");
  }

  return data as SnapMacroRow;
}

function encodeImageBase64(bytes: Uint8Array): string {
  let binary = "";
  const chunkSize = 0x8000;

  for (let index = 0; index < bytes.length; index += chunkSize) {
    const chunk = bytes.subarray(index, index + chunkSize);
    binary += String.fromCharCode(...chunk);
  }

  return btoa(binary);
}
