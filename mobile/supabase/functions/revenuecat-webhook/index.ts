import { corsHeaders } from "../_shared/cors.ts";
import { errorResponse, jsonResponse } from "../_shared/response.ts";

type RevenueCatWebhookEvent = {
  id?: string;
  type?: string;
  app_user_id?: string;
  original_app_user_id?: string;
  product_id?: string | null;
  entitlement_id?: string | null;
  entitlement_ids?: string[] | null;
  environment?: string;
  store?: string;
};

type RevenueCatWebhookPayload = {
  api_version?: string;
  event?: RevenueCatWebhookEvent | null;
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { status: 200, headers: corsHeaders });
  }

  if (req.method !== "POST") {
    return errorResponse("Method not allowed", 405);
  }

  try {
    if (!isAuthorized(req)) {
      return errorResponse("Unauthorized", 401);
    }

    const payload = await req.json() as RevenueCatWebhookPayload;
    const event = payload.event;

    if (!event?.id || !event.type) {
      return errorResponse("Missing RevenueCat event data", 400);
    }

    console.log("revenuecat-webhook received", {
      apiVersion: payload.api_version ?? "unknown",
      id: event.id,
      type: event.type,
      appUserId: event.app_user_id ?? null,
      originalAppUserId: event.original_app_user_id ?? null,
      productId: event.product_id ?? null,
      entitlementId: event.entitlement_id ?? null,
      entitlementIds: event.entitlement_ids ?? [],
      environment: event.environment ?? null,
      store: event.store ?? null,
    });

    return jsonResponse({
      received: true,
      event_id: event.id,
      event_type: event.type,
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    console.error("revenuecat-webhook error", { message });
    return errorResponse(message, 500);
  }
});

function isAuthorized(req: Request): boolean {
  const configuredSecret = Deno.env.get("REVENUECAT_WEBHOOK_SECRET")?.trim() ??
    "";

  // If no secret is configured yet, accept the webhook so the endpoint works
  // immediately after deployment. Once REVENUECAT_WEBHOOK_SECRET is set,
  // RevenueCat must send it as `Authorization: Bearer <secret>`.
  if (!configuredSecret) {
    return true;
  }

  const authHeader = req.headers.get("Authorization")?.trim() ?? "";
  return authHeader === `Bearer ${configuredSecret}`;
}
