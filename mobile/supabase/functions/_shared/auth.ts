import { createClient } from "https://esm.sh/@supabase/supabase-js@2.47.10";

export async function getAuthContext(
  req: Request,
): Promise<{ userId: string }> {
  const supabaseUrl = Deno.env.get("SUPABASE_URL")?.trim() ?? "";
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY")?.trim() ?? "";
  const authHeader = req.headers.get("Authorization")?.trim() ?? "";

  if (!supabaseUrl || !anonKey || !authHeader) {
    throw new Error("Unauthorized");
  }

  const client = createClient(supabaseUrl, anonKey, {
    global: {
      headers: {
        Authorization: authHeader,
      },
    },
  });

  const {
    data: { user },
    error,
  } = await client.auth.getUser();

  if (error || !user) {
    throw new Error("Unauthorized");
  }

  return { userId: user.id };
}
