import type { SupabaseClient } from "https://esm.sh/@supabase/supabase-js@2.47.10";

const MODEL_PRICING: Record<
  string,
  {
    input: number;
    output: number;
  }
> = {
  "gemini-2.5-flash-lite": {
    input: 0.1 / 1_000_000,
    output: 0.4 / 1_000_000,
  },
};

export function calculateCost(
  model: string,
  inputTokens: number,
  outputTokens: number,
) {
  const pricing = MODEL_PRICING[model];
  if (!pricing) {
    throw new Error(`Unknown model: ${model}`);
  }

  return inputTokens * pricing.input + outputTokens * pricing.output;
}

export async function logAiRequest(
  client: SupabaseClient,
  params: {
    userId: string;
    featureName: string;
    model: string;
    inputTokens: number;
    outputTokens: number;
  },
): Promise<void> {
  const costUsd = calculateCost(
    params.model,
    params.inputTokens,
    params.outputTokens,
  );

  const { error } = await client.from("ai_requests").insert({
    user_id: params.userId,
    feature_name: params.featureName,
    model: params.model,
    input_tokens: params.inputTokens,
    output_tokens: params.outputTokens,
    cost_usd: costUsd,
  });

  if (error) {
    throw new Error(error.message);
  }
}

export async function createPendingAiRequest(
  client: SupabaseClient,
  params: {
    userId: string;
    featureName: string;
    request: Record<string, unknown>;
  },
): Promise<string> {
  const { data, error } = await client.from("ai_requests").insert({
    user_id: params.userId,
    feature_name: params.featureName,
    status: "pending",
    request: params.request,
  }).select("id").single();

  if (error) {
    throw new Error(error.message);
  }

  const id = typeof data?.id === "string" ? data.id.trim() : "";
  if (!id) {
    throw new Error("Failed to create ai_requests row.");
  }

  return id;
}

export async function finalizeAiRequest(
  client: SupabaseClient,
  params: {
    requestId: string;
    status: "completed" | "failed";
    response: Record<string, unknown>;
    model?: string;
    inputTokens?: number;
    outputTokens?: number;
  },
): Promise<void> {
  const updates: Record<string, unknown> = {
    status: params.status,
    response: params.response,
    completed_at: new Date().toISOString(),
  };

  if (
    typeof params.model === "string" &&
    typeof params.inputTokens === "number" &&
    typeof params.outputTokens === "number"
  ) {
    updates.model = params.model;
    updates.input_tokens = params.inputTokens;
    updates.output_tokens = params.outputTokens;
    updates.cost_usd = calculateCost(
      params.model,
      params.inputTokens,
      params.outputTokens,
    );
  }

  const { error } = await client.from("ai_requests").update(updates).eq(
    "id",
    params.requestId,
  );

  if (error) {
    throw new Error(error.message);
  }
}
