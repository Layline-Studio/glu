import { getAuthContext } from "../_shared/auth.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { errorResponse, jsonResponse } from "../_shared/response.ts";
import { getServiceClient } from "../_shared/supabase.ts";
import { createPendingAiRequest, finalizeAiRequest } from "../_shared/usage.ts";
import { generateReportPdf } from "./core.ts";

declare const EdgeRuntime: {
  waitUntil(promise: Promise<unknown>): void;
};

const FEATURE_NAME = "create-report";

type CreateReportRow = {
  id: string;
  user_id: string;
  response: Record<string, unknown> | null;
  status: string;
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { status: 200, headers: corsHeaders });
  }

  try {
    if (req.method === "POST") {
      return await handlePost(req);
    }
    if (req.method === "GET") {
      return await handleGet(req);
    }
    return errorResponse("Method not allowed", 405);
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    const status = message === "Unauthorized"
      ? 401
      : message === "Not found"
      ? 404
      : message.startsWith("Missing ")
      ? 400
      : 500;
    return errorResponse(message, status);
  }
});

async function handlePost(req: Request) {
  const { userId } = await getAuthContext(req);
  const client = getServiceClient();

  const now = new Date();
  const startOfToday = new Date(now.getFullYear(), now.getMonth(), now.getDate()).toISOString();
  const startOfTomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1).toISOString();

  const { data: existing } = await client
    .from("ai_requests")
    .select("id, status")
    .eq("user_id", userId)
    .eq("feature_name", FEATURE_NAME)
    .gte("created_at", startOfToday)
    .lt("created_at", startOfTomorrow)
    .in("status", ["pending", "completed"])
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  if (existing) {
    const httpStatus = existing.status === "completed" ? 200 : 202;
    return jsonResponse({ id: existing.id }, { status: httpStatus });
  }

  const requestId = await createPendingAiRequest(client, {
    userId,
    featureName: FEATURE_NAME,
    request: {},
  });

  EdgeRuntime.waitUntil(processReport(requestId, userId));

  return jsonResponse({ id: requestId }, { status: 202 });
}

async function handleGet(req: Request) {
  const { userId } = await getAuthContext(req);
  const url = new URL(req.url);
  const id = url.searchParams.get("id")?.trim() ?? "";

  if (!id) {
    throw new Error("Missing id");
  }

  const client = getServiceClient();
  const row = await getReportRow(client, id, userId);

  return jsonResponse({ status: row.status, response: row.response });
}

async function processReport(requestId: string, userId: string): Promise<void> {
  const client = getServiceClient();

  try {
    const [profileResult, recordsResult] = await Promise.all([
      client
        .from("profiles")
        .select("settings, goals")
        .eq("id", userId)
        .maybeSingle(),
      client
        .from("records")
        .select("weight, doses")
        .eq("user_id", userId)
        .maybeSingle(),
    ]);

    if (profileResult.error) throw new Error(profileResult.error.message);
    if (recordsResult.error) throw new Error(recordsResult.error.message);
    if (!profileResult.data) throw new Error("Profile not found.");

    const profile = profileResult.data as {
      settings: Record<string, unknown>;
      goals: Record<string, unknown> | null;
    };
    const records = (recordsResult.data ?? {}) as {
      weight: Array<Record<string, unknown>> | null;
      doses: Array<Record<string, unknown>> | null;
    };

    const pdfBytes = await generateReportPdf(profile, records);

    const now = new Date();
    const yyyymmdd = `${now.getFullYear()}${String(now.getMonth() + 1).padStart(2, "0")}${String(now.getDate()).padStart(2, "0")}`;
    const storagePath = `${userId}/reports/${yyyymmdd}/${requestId}.pdf`;

    const { error: uploadError } = await client.storage
      .from("assets")
      .upload(storagePath, pdfBytes, {
        contentType: "application/pdf",
        upsert: false,
      });

    if (uploadError) throw new Error(uploadError.message);

    await finalizeAiRequest(client, {
      requestId,
      status: "completed",
      response: {
        path: storagePath,
      },
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    await finalizeAiRequest(client, {
      requestId,
      status: "failed",
      response: { reason: message },
    });
  }
}

async function getReportRow(
  client: ReturnType<typeof getServiceClient>,
  requestId: string,
  userId?: string,
): Promise<CreateReportRow> {
  let query = client
    .from("ai_requests")
    .select("id, user_id, response, status")
    .eq("id", requestId)
    .eq("feature_name", FEATURE_NAME);

  if (userId) {
    query = query.eq("user_id", userId);
  }

  const { data, error } = await query.maybeSingle();

  if (error) throw new Error(error.message);
  if (!data) throw new Error("Not found");

  return data as CreateReportRow;
}
