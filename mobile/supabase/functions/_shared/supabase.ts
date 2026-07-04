import { createClient } from "https://esm.sh/@supabase/supabase-js@2.47.10";

export function getServiceClient() {
  const supabaseUrl = Deno.env.get("SUPABASE_URL")?.trim() ?? "";
  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")?.trim() ??
    "";
  const secretKey = Deno.env.get("SUPABASE_SECRET_KEY")?.trim() ?? "";
  const adminKey = secretKey || serviceRoleKey;

  if (!supabaseUrl || !adminKey) {
    throw new Error(
      "Missing SUPABASE_URL and SUPABASE_SECRET_KEY or SUPABASE_SERVICE_ROLE_KEY.",
    );
  }

  return createClient(supabaseUrl, adminKey);
}
