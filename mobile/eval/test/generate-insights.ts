/**
 * Eval tests for generate-insights.
 *
 * These tests make real function calls and should be run against a local
 * Supabase stack with the edge function served locally.
 *
 * Prerequisites:
 *   1. supabase start
 *   2. supabase db reset
 *   3. supabase functions serve --env-file supabase/.env --no-verify-jwt
 *
 * Run with:
 *   deno test --no-check --allow-read --allow-write --allow-net --allow-env eval/test/generate-insights.ts
 */

import {
  assert,
  assertEquals,
  assertMatch,
} from "https://deno.land/std/assert/mod.ts";
import {
  FUNCTION_URL,
  PUBLISHABLE_KEY,
  getAuthToken,
  saveTestOutput,
} from "./_helpers.ts";

type RecordEntry = Record<string, unknown>;

type Fixture = {
  name: string;
  description: string;
  currentTimestamp: string;
  profile: Record<string, unknown>;
  records: Record<string, RecordEntry[]>;
  assertions: {
    minSummaryLength?: number;
    maxSummaryLength?: number;
    includeAny?: string[];
    includeAll?: string[];
    excludeAny?: string[];
    preferBullets?: boolean;
    expectedLocale?: "en" | "pt";
  };
};

type ApiResponse = {
  success: boolean;
  reason: string;
  response: { summary: string } | null;
};

const FEATURE = "generate-insights";
const FIXTURE_DIR = "eval/inputs/generate-insights";

async function loadFixture(name: string): Promise<Fixture> {
  const text = await Deno.readTextFile(`${FIXTURE_DIR}/${name}.json`);
  return JSON.parse(text) as Fixture;
}

async function listFixtureNames(): Promise<string[]> {
  const names: string[] = [];
  for await (const entry of Deno.readDir(FIXTURE_DIR)) {
    if (!entry.isFile || !entry.name.endsWith(".json")) continue;
    names.push(entry.name.replace(/\.json$/, ""));
  }
  names.sort();
  return names;
}

function decodeJwtSub(token: string): string {
  const payload = token.split(".")[1];
  if (!payload) {
    throw new Error("Invalid auth token.");
  }
  const base64 = payload.replaceAll("-", "+").replaceAll("_", "/");
  const padded = base64.padEnd(base64.length + ((4 - (base64.length % 4)) % 4), "=");
  const json = atob(padded);
  const data = JSON.parse(json) as { sub?: string };
  if (!data.sub) {
    throw new Error("Auth token is missing a subject.");
  }
  return data.sub;
}

function restHeaders(token: string): HeadersInit {
  return {
    "Content-Type": "application/json",
    apikey: PUBLISHABLE_KEY,
    Authorization: `Bearer ${token}`,
  };
}

async function upsertRow(
  table: "profiles" | "records",
  row: Record<string, unknown>,
  token: string,
): Promise<void> {
  const onConflict = table === "profiles" ? "id" : "user_id";
  const response = await fetch(
    `${Deno.env.get("SUPABASE_URL") ?? "http://127.0.0.1:54321"}/rest/v1/${table}?on_conflict=${onConflict}`,
    {
      method: "POST",
      headers: {
        ...restHeaders(token),
        Prefer: "resolution=merge-duplicates,return=minimal",
      },
      body: JSON.stringify(row),
    },
  );

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Failed to upsert ${table}: ${response.status} ${text}`);
  }
}

async function cleanupScenarioArtifacts(userId: string, token: string) {
  if (!SERVICE_ROLE_KEY) {
    return;
  }

  const url = `${Deno.env.get("SUPABASE_URL") ?? "http://127.0.0.1:54321"}/rest/v1/ai_requests?user_id=eq.${userId}&feature_name=eq.${FEATURE}`;
  const response = await fetch(url, {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json",
      apikey: SERVICE_ROLE_KEY,
      Authorization: `Bearer ${SERVICE_ROLE_KEY}`,
    },
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Failed to clean ai_requests: ${response.status} ${text}`);
  }
}

async function seedFixture(fixture: Fixture, token: string) {
  const userId = decodeJwtSub(token);
  await cleanupScenarioArtifacts(userId, token);
  await upsertRow(
    "profiles",
    {
      id: userId,
      ...fixture.profile,
    },
    token,
  );
  await upsertRow(
    "records",
    {
      user_id: userId,
      ...fixture.records,
    },
    token,
  );
}

async function callGenerateInsights(
  currentTimestamp: string,
  token: string,
): Promise<Response> {
  return fetch(`${FUNCTION_URL}/generate-insights`, {
    method: "POST",
    headers: restHeaders(token),
    body: JSON.stringify({
      currentTimestamp,
    }),
  });
}

function assertLanguage(summary: string, expectedLocale: "en" | "pt") {
  const lower = summary.toLowerCase();
  if (expectedLocale === "pt") {
    assertMatch(lower, /(você|seu|sua|seus|suas|hoje|ajuda|entender)/);
    assertEquals(/^\s*(you|your|pay attention)/i.test(summary), false);
    return;
  }

  assertMatch(lower, /(you|your|pay attention|worth noticing|one small next step)/);
}

function assertBullets(summary: string) {
  assertMatch(summary, /(?:^|\n)\s*[-*•]\s+/);
}

function assertFixtureSummary(fixture: Fixture, summary: string) {
  const assertions = fixture.assertions;
  assert(summary.trim().length > 0, `${fixture.name}: expected a summary`);
  assert(
    summary.length >= (assertions.minSummaryLength ?? 10),
    `${fixture.name}: summary is too short`,
  );
  assert(
    summary.length <= (assertions.maxSummaryLength ?? 1000),
    `${fixture.name}: summary is too long`,
  );

  for (const term of assertions.includeAll ?? []) {
    assertMatch(summary.toLowerCase(), new RegExp(term, "i"));
  }
  if ((assertions.includeAny ?? []).length > 0) {
    const hasAny = assertions.includeAny!.some((term) =>
      new RegExp(term, "i").test(summary)
    );
    assert(hasAny, `${fixture.name}: expected one of ${assertions.includeAny!.join(", ")}`);
  }
  for (const term of assertions.excludeAny ?? []) {
    assertEquals(new RegExp(term, "i").test(summary), false);
  }
  if (assertions.preferBullets) {
    assertBullets(summary);
  }
  if (assertions.expectedLocale) {
    assertLanguage(summary, assertions.expectedLocale);
  }
}

async function runFixture(fixtureName: string): Promise<void> {
  const fixture = await loadFixture(fixtureName);
  const token = await getAuthToken();
  const userId = decodeJwtSub(token);
  await seedFixture(fixture, token);

  let responseText = "";
  try {
    const response = await callGenerateInsights(
      fixture.currentTimestamp,
      token,
    );
    responseText = await response.text();

    if (!response.ok) {
      throw new Error(
        `${fixture.name}: HTTP ${response.status} ${response.statusText}\n${responseText}`,
      );
    }

    const data = JSON.parse(responseText) as ApiResponse;
    assertEquals(data.success, true, `${fixture.name}: expected success=true`);
    assert(
      data.response != null && typeof data.response.summary === "string",
      `${fixture.name}: expected summary payload`,
    );

    assertFixtureSummary(fixture, data.response!.summary);

    await saveTestOutput(FEATURE, fixture.name, {
      response: data,
      status: "pass",
      error: null,
    });
  } catch (error) {
    await saveTestOutput(FEATURE, fixture.name, {
      response: responseText ? safeJsonParse(responseText) : null,
      status: "fail",
      error: error instanceof Error ? error.message : String(error),
    });
    throw error;
  } finally {
    await cleanupScenarioArtifacts(userId, token);
  }
}

function safeJsonParse(value: string): unknown | null {
  try {
    return JSON.parse(value);
  } catch {
    return null;
  }
}

const fixtureNames = PUBLISHABLE_KEY ? await listFixtureNames() : [];

for (const fixtureName of fixtureNames) {
  Deno.test({
    name: `generate-insights: ${fixtureName}`,
    ignore: !PUBLISHABLE_KEY,
    fn: async () => {
      await runFixture(fixtureName);
    },
  });
}
