function loadSupabaseEnvIfPresent(): void {
  const path = "supabase/.env";
  let text = "";
  try {
    text = Deno.readTextFileSync(path);
  } catch {
    return;
  }

  for (const rawLine of text.split("\n")) {
    const line = rawLine.trim();
    if (!line || line.startsWith("#")) continue;
    const eq = line.indexOf("=");
    if (eq <= 0) continue;
    const key = line.slice(0, eq).trim();
    if (!key) continue;
    if (Deno.env.get(key) != null) continue;
    let value = line.slice(eq + 1).trim();
    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }
    Deno.env.set(key, value);
  }
}

loadSupabaseEnvIfPresent();

function formatTimestamp(date: Date): string {
  const pad = (n: number, len = 2) => String(n).padStart(len, "0");
  return (
    `${date.getFullYear()}${pad(date.getMonth() + 1)}${pad(date.getDate())}` +
    `${pad(date.getHours())}${pad(date.getMinutes())}${pad(date.getSeconds())}`
  );
}

export const RUN_TIMESTAMP = formatTimestamp(new Date());
export const SUPABASE_URL = Deno.env.get("SUPABASE_URL") ||
  "http://127.0.0.1:54321";
export const FUNCTION_URL = Deno.env.get("FUNCTION_URL") ||
  `${SUPABASE_URL}/functions/v1`;
export const PUBLISHABLE_KEY = getPublishableKey();

export interface TestOutput {
  response: unknown | null;
  status: "pass" | "fail" | "skip";
  error: string | null;
}

function getPublishableKey(): string {
  const fromEnv = Deno.env.get("SUPABASE_PUBLISHABLE_KEY") ||
    Deno.env.get("SUPABASE_ANON_KEY");
  if (fromEnv) return fromEnv;
  try {
    const envFile = Deno.readTextFileSync("supabase/.env");
    const match = envFile.match(/^SUPABASE_ANON_KEY=(.+)$/m);
    if (match) return match[1].trim();
  } catch {
    // ignore
  }
  return "";
}

let _cachedToken: string | null = null;

export async function getAuthToken(): Promise<string> {
  if (_cachedToken) return _cachedToken;
  if (!PUBLISHABLE_KEY) {
    throw new Error(
      "No publishable/anon key found. Set SUPABASE_PUBLISHABLE_KEY or ensure supabase/.env exists.",
    );
  }

  const email = "eval-test@localhost.test";
  const password = "eval-test-password-123";
  const authUrl = `${SUPABASE_URL}/auth/v1`;
  const headers = {
    "Content-Type": "application/json",
    apikey: PUBLISHABLE_KEY,
  };

  const signIn = await fetch(`${authUrl}/token?grant_type=password`, {
    method: "POST",
    headers,
    body: JSON.stringify({ email, password }),
  });

  if (signIn.ok) {
    const data = await signIn.json();
    _cachedToken = data.access_token;
    return _cachedToken!;
  }
  await signIn.text();

  const signUp = await fetch(`${authUrl}/signup`, {
    method: "POST",
    headers,
    body: JSON.stringify({ email, password }),
  });

  if (!signUp.ok) {
    const body = await signUp.text();
    throw new Error(
      `Failed to create eval test user: ${signUp.status} ${body}`,
    );
  }

  const data = await signUp.json();
  _cachedToken = data.access_token;
  return _cachedToken!;
}

export async function saveTestOutput(
  feature: string,
  testCase: string,
  output: TestOutput,
): Promise<void> {
  const filePath = `eval/outputs/${RUN_TIMESTAMP}/${feature}/${testCase}.json`;
  const fileDir = filePath.substring(0, filePath.lastIndexOf("/"));
  await Deno.mkdir(fileDir, { recursive: true });
  await Deno.writeTextFile(filePath, JSON.stringify(output, null, 2) + "\n");
}

export function encodeBase64(bytes: Uint8Array): string {
  let binary = "";
  for (let i = 0; i < bytes.byteLength; i++) {
    binary += String.fromCharCode(bytes[i]);
  }
  return btoa(binary);
}
