import { getAuthContext } from "../_shared/auth.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { errorResponse, jsonResponse } from "../_shared/response.ts";
import { getServiceClient } from "../_shared/supabase.ts";
import { createPendingAiRequest, finalizeAiRequest } from "../_shared/usage.ts";
import {
  generateInsightsFromData,
  toGenerateInsightsApiResponse,
  validateGenerateInsightsRequestInput,
} from "./core.ts";

declare const EdgeRuntime: {
  waitUntil(promise: Promise<unknown>): void;
};

type GenerateInsightsRow = {
  id: string;
  user_id: string;
  request: {
    currentTimestamp?: string;
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
      return await handlePostGenerateInsights(req);
    }
    if (req.method === "GET") {
      return await handleGetGenerateInsights(req);
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

async function handlePostGenerateInsights(req: Request) {
  const { userId } = await getAuthContext(req);
  const body = await req.json().catch(() => ({}));
  const input = validateGenerateInsightsRequestInput(body);
  const client = getServiceClient();
  const requestId = await createPendingAiRequest(client, {
    userId,
    featureName: "generate-insights",
    request: input as Record<string, unknown>,
  });

  EdgeRuntime.waitUntil(processGenerateInsightsRequest(requestId));

  return jsonResponse({ id: requestId }, { status: 202 });
}

async function handleGetGenerateInsights(req: Request) {
  const { userId } = await getAuthContext(req);
  const url = new URL(req.url);
  const id = url.searchParams.get("id")?.trim() ?? "";

  if (!id) {
    throw new Error("Missing id");
  }

  const client = getServiceClient();
  const request = await getGenerateInsightsRequest(client, id, userId);

  return jsonResponse({
    status: request.status,
    response: request.response,
  });
}

async function processGenerateInsightsRequest(
  requestId: string,
): Promise<void> {
  const client = getServiceClient();
  const request = await getGenerateInsightsRequest(client, requestId);
  const input = validateGenerateInsightsRequestInput(request.request ?? {});

  try {
    const [profileResult, recordsResult] = await Promise.all([
      client.from("profiles")
        .select("id, subscription_tier, timezone, settings, goals, created_at, updated_at")
        .eq("id", request.user_id)
        .maybeSingle(),
      client.from("records")
        .select("water, exercise, weight, meals, symptoms, mood, glowup, supplements, doses")
        .eq("user_id", request.user_id)
        .maybeSingle(),
    ]);

    if (profileResult.error) {
      throw new Error(profileResult.error.message);
    }
    if (recordsResult.error) {
      throw new Error(recordsResult.error.message);
    }

    if (!profileResult.data) {
      throw new Error("Profile not found.");
    }

    const result = await generateInsightsFromData(
      input,
      profileResult.data as Record<string, unknown>,
      (recordsResult.data as Record<string, unknown> | null) ?? {},
    );

    await finalizeAiRequest(client, {
      requestId,
      status: "completed",
      response: toGenerateInsightsApiResponse(result) as Record<string, unknown>,
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

async function getGenerateInsightsRequest(
  client: ReturnType<typeof getServiceClient>,
  requestId: string,
  userId?: string,
): Promise<GenerateInsightsRow> {
  let query = client.from("ai_requests").select(
    "id, user_id, request, response, status",
  ).eq("id", requestId).eq("feature_name", "generate-insights");

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

  return data as GenerateInsightsRow;
}
