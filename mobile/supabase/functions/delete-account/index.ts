import { createClient } from "@supabase/supabase-js";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

const REVENUECAT_BASE_URL = "https://api.revenuecat.com/v1";

async function cancelRevenueCatSubscriptions(userId: string) {
  const apiKey = Deno.env.get("REVENUECAT_SECRET_API_KEY");
  if (!apiKey) {
    throw new Error("Missing REVENUECAT_SECRET_API_KEY");
  }

  const headers = {
    Authorization: `Bearer ${apiKey}`,
    "Content-Type": "application/json",
  };

  const subscriberResponse = await fetch(
    `${REVENUECAT_BASE_URL}/subscribers/${userId}`,
    { headers },
  );

  if (!subscriberResponse.ok) {
    const text = await subscriberResponse.text();
    throw new Error(`RevenueCat fetch failed: ${text}`);
  }

  const data = await subscriberResponse.json();
  const subscriptions = (data?.subscriber?.subscriptions ?? {}) as Record<string, unknown>;
  const productIds = Object.keys(subscriptions);
  const warnings: string[] = [];

  for (const productId of productIds) {
    const cancelResponse = await fetch(
      `${REVENUECAT_BASE_URL}/subscribers/${userId}/subscriptions/${productId}/cancel`,
      {
        method: "POST",
        headers,
      },
    );

    if (!cancelResponse.ok) {
      const text = await cancelResponse.text();
      warnings.push(`RevenueCat cancel failed for ${productId}: ${text}`);
    }
  }

  return warnings;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL")?.trim() ?? "";
    const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY")?.trim() ?? "";
    const serviceRoleKey =
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")?.trim() ?? "";
    const supabaseSecretKey =
      Deno.env.get("SUPABASE_SECRET_KEY")?.trim() ?? "";
    const plainSecretKey = Deno.env.get("SECRET_KEY")?.trim() ?? "";
    const secretKey = supabaseSecretKey || plainSecretKey;
    const adminKey = secretKey || serviceRoleKey;
    const adminKeySource = secretKey ? "SUPABASE_SECRET_KEY" : "SUPABASE_SERVICE_ROLE_KEY";
    const revenueCatSecretKey =
      Deno.env.get("REVENUECAT_SECRET_API_KEY")?.trim() ?? "";
    const authHeader = req.headers.get("Authorization");

    if (
      !supabaseUrl ||
      !supabaseAnonKey ||
      !adminKey ||
      !revenueCatSecretKey ||
      !authHeader
    ) {
      return new Response(
        JSON.stringify({
          error:
            "Missing function configuration. Check SUPABASE_URL, SUPABASE_ANON_KEY, SUPABASE_SECRET_KEY or SUPABASE_SERVICE_ROLE_KEY, REVENUECAT_SECRET_API_KEY, and Authorization.",
        }),
        {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        },
      );
    }

    const userClient = createClient(supabaseUrl, supabaseAnonKey, {
      global: {
        headers: {
          Authorization: authHeader,
        },
      },
    });

    const {
      data: { user },
      error: userError,
    } = await userClient.auth.getUser();

    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: "Unauthorized." }),
        {
          status: 401,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        },
      );
    }

    const adminClient = createClient(supabaseUrl, adminKey);
    const warnings = await cancelRevenueCatSubscriptions(user.id);
    const { error: deleteError } = await adminClient.auth.admin.deleteUser(
      user.id,
    );

    if (deleteError) {
      console.error("delete-account auth delete failed", {
        userId: user.id,
        adminKeySource,
        message: deleteError.message,
        status: deleteError.status ?? null,
        code: "code" in deleteError ? deleteError.code : null,
        warnings,
      });
      return new Response(
        JSON.stringify({ error: deleteError.message }),
        {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        },
      );
    }

    return new Response(JSON.stringify({ success: true, warnings }), {
      status: 200,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (error) {
    console.error("delete-account error:", error);
    return new Response(
      JSON.stringify({
        error: error instanceof Error ? error.message : "Unknown error",
      }),
      {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  }
});
