/**
 * Eval tests for create-report.
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
 *   deno test --no-check --allow-read --allow-write --allow-net --allow-env eval/test/create-report.ts
 */

import { assert, assertEquals } from "https://deno.land/std/assert/mod.ts";
import { PDFDocument } from "https://esm.sh/pdf-lib@1.17.1";
import {
  FUNCTION_URL,
  PUBLISHABLE_KEY,
  RUN_TIMESTAMP,
  getAuthToken,
  saveTestOutput,
} from "./_helpers.ts";

const FEATURE = "create-report";
const SUPABASE_URL = Deno.env.get("SUPABASE_URL") ?? "http://127.0.0.1:54321";
const SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ??
  Deno.env.get("SUPABASE_SECRET_KEY") ?? "";

const DAY_MS = 24 * 60 * 60 * 1000;

function iso(daysAgo: number, hour = 12): string {
  const date = new Date(Date.now() - daysAgo * DAY_MS);
  date.setUTCHours(hour, 0, 0, 0);
  return date.toISOString();
}

function buildFixture(): {
  profile: Record<string, unknown>;
  records: Record<string, unknown>;
} {
  return {
    profile: {
      timezone: "America/New_York",
      settings: {
        preferred_name: "Eval Patient",
        age: 38,
        gender: "female",
        height: { unit: "metric", primary: "168", secondary: null },
        weight: { primary: "88", unit: "kg" },
        medication_name: "Ozempic ®",
        current_dose_mg: "0.5",
        medication_method: "injection",
        medication_frequency: "weekly",
        medication_frequency_days_between_doses: 7,
        medication_started_at: iso(60),
        medication_start_weight: { primary: "92", unit: "kg" },
        app_locale: "en",
        has_completed_onboarding: true,
      },
      goals: {
        weight: {
          enabled: true,
          history: [
            {
              created_at: "2026-01-01",
              timeframe: "weekly",
              target_kg: 80,
              target_unit: "kg",
            },
          ],
        },
        water: {
          enabled: true,
          history: [
            { created_at: "2026-01-01", timeframe: "daily", target_ml: 2000 },
          ],
        },
      },
    },
    records: {
      weight: Array.from({ length: 30 }, (_, i) => ({
        id: crypto.randomUUID(),
        logged_at: iso(59 - i * 2, 8),
        quantity: Number((92 - i * 0.15).toFixed(1)),
        unit: "kg",
      })),
      doses: Array.from({ length: 8 }, (_, i) => ({
        id: crypto.randomUUID(),
        logged_at: iso(56 - i * 7, 9),
        created_at: iso(56 - i * 7, 9),
        method: "injection",
        medication: "Ozempic ®",
        dose: "0.5",
        injection_site: ["abdomen_upper_left", "thigh_upper_right"][i % 2],
        notes: i === 3 ? "Mild soreness" : null,
      })),
      water: Array.from({ length: 60 }, (_, i) => ({
        id: crypto.randomUUID(),
        logged_at: iso(Math.floor(i / 2), 10 + (i % 2) * 6),
        quantity: 400,
        unit: "ml",
      })),
      symptoms: Array.from({ length: 8 }, (_, i) => ({
        id: crypto.randomUUID(),
        logged_at: iso(i * 6, 15),
        symptoms: i % 2 === 0 ? ["nausea"] : ["fatigue", "headache"],
        severity: ["mild", "moderate", "severe"][i % 3],
        notes: i === 0 ? "Passed within a few hours" : null,
      })),
      mood: [],
      meals: [],
      exercise: [],
    },
  };
}

function decodeJwtSub(token: string): string {
  const payload = token.split(".")[1];
  if (!payload) throw new Error("Invalid auth token.");
  const base64 = payload.replaceAll("-", "+").replaceAll("_", "/");
  const padded = base64.padEnd(
    base64.length + ((4 - (base64.length % 4)) % 4),
    "=",
  );
  const data = JSON.parse(atob(padded)) as { sub?: string };
  if (!data.sub) throw new Error("Auth token is missing a subject.");
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
    `${SUPABASE_URL}/rest/v1/${table}?on_conflict=${onConflict}`,
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

async function cleanupPriorRequests(userId: string): Promise<void> {
  if (!SERVICE_ROLE_KEY) return;
  const url =
    `${SUPABASE_URL}/rest/v1/ai_requests?user_id=eq.${userId}&feature_name=eq.${FEATURE}`;
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

async function pollUntilComplete(
  requestId: string,
  token: string,
): Promise<{ status: string; response: { path?: string; reason?: string } }> {
  const deadline = Date.now() + 60_000;
  while (Date.now() < deadline) {
    const response = await fetch(
      `${FUNCTION_URL}/${FEATURE}?id=${requestId}`,
      { headers: restHeaders(token) },
    );
    if (!response.ok) {
      const text = await response.text();
      throw new Error(`Poll failed: ${response.status} ${text}`);
    }
    const payload = await response.json() as {
      status: string;
      response: { path?: string; reason?: string } | null;
    };
    if (payload.status !== "pending") {
      return { status: payload.status, response: payload.response ?? {} };
    }
    await new Promise((resolve) => setTimeout(resolve, 1000));
  }
  throw new Error("Timed out waiting for report generation.");
}

async function downloadReport(path: string, token: string): Promise<Uint8Array> {
  const response = await fetch(
    `${SUPABASE_URL}/storage/v1/object/authenticated/assets/${path}`,
    { headers: restHeaders(token) },
  );
  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Failed to download report: ${response.status} ${text}`);
  }
  return new Uint8Array(await response.arrayBuffer());
}

Deno.test("create-report generates a multi-page PDF end-to-end", async () => {
  const token = await getAuthToken();
  const userId = decodeJwtSub(token);
  const fixture = buildFixture();

  await cleanupPriorRequests(userId);
  await upsertRow("profiles", { id: userId, ...fixture.profile }, token);
  await upsertRow("records", { user_id: userId, ...fixture.records }, token);

  const post = await fetch(`${FUNCTION_URL}/${FEATURE}`, {
    method: "POST",
    headers: restHeaders(token),
  });
  assert(post.ok, `POST failed: ${post.status} ${await post.text()}`);
  const { id: requestId } = await post.json() as { id: string };
  assert(requestId, "POST did not return a request id");

  const result = await pollUntilComplete(requestId, token);
  assertEquals(result.status, "completed", result.response.reason);
  assert(result.response.path, "completed report has no storage path");

  const bytes = await downloadReport(result.response.path!, token);
  // PDF magic bytes.
  assertEquals(new TextDecoder().decode(bytes.slice(0, 5)), "%PDF-");

  const pdf = await PDFDocument.load(bytes);
  // Summary + weight + medication + symptoms + hydration (mood/meals/exercise empty).
  assertEquals(pdf.getPageCount(), 5);

  const outPath = `eval/outputs/${RUN_TIMESTAMP}/${FEATURE}/report.pdf`;
  await Deno.mkdir(outPath.substring(0, outPath.lastIndexOf("/")), {
    recursive: true,
  });
  await Deno.writeFile(outPath, bytes);
  await saveTestOutput(FEATURE, "e2e-report", {
    response: {
      requestId,
      path: result.response.path,
      pageCount: pdf.getPageCount(),
      bytes: bytes.length,
    },
    status: "pass",
    error: null,
  });
});
