/**
 * Eval tests for snap-macro.
 *
 * These tests make real function calls and should be run independently from CI.
 *
 * Prerequisites:
 *   1. supabase start
 *   2. supabase functions serve --env-file supabase/.env --no-verify-jwt
 *   3. Add local image fixtures under eval/inputs/snap-macro/images/
 *
 * Run with:
 *   deno test --no-check --allow-write --allow-read --allow-net --allow-env eval/test/snap-macro.ts
 */

import { assertEquals } from "https://deno.land/std/assert/mod.ts";
import {
  encodeBase64,
  FUNCTION_URL,
  getAuthToken,
  PUBLISHABLE_KEY,
  saveTestOutput,
} from "./_helpers.ts";

type Fixture = {
  description: string;
  locale?: string;
  input: {
    imagePath: string;
    mimeType: string;
  };
  expectations:
    | {
      success: true;
      requireFields: Array<
        "name" | "calories" | "carbs" | "proteins" | "fats" | "fiber"
      >;
      allowNote?: boolean;
      toleranceProfile: "meal_photo" | "nutrition_label";
      real: Partial<
        Record<
          "calories" | "carbs" | "proteins" | "fats" | "fiber",
          number
        >
      >;
    }
    | {
      success: false;
      reasonMinLength?: number;
    };
};

type ApiMeal = {
  name: string;
  calories: number;
  carbs: number;
  proteins: number;
  fats: number;
  fiber: number;
  note?: string;
};

type ApiResponse = {
  success: boolean;
  reason: string;
  response: ApiMeal | null;
};

const FEATURE = "snap-macro";
const CAN_RUN_EVALS = Boolean(PUBLISHABLE_KEY);
const METRIC_FIELDS = [
  "calories",
  "carbs",
  "proteins",
  "fats",
  "fiber",
] as const;
type MetricField = typeof METRIC_FIELDS[number];

const TOLERANCE_PROFILES: Record<
  "meal_photo" | "nutrition_label",
  {
    relative: Partial<Record<MetricField, number>>;
    absolute: Partial<Record<MetricField, number>>;
  }
> = {
  meal_photo: {
    relative: {
      calories: 0.2,
      carbs: 0.25,
      proteins: 0.25,
      fats: 0.25,
    },
    absolute: {
      fiber: 3,
      proteins: 2,
      carbs: 4,
      fats: 3,
      calories: 40,
    },
  },
  nutrition_label: {
    relative: {
      calories: 0.08,
      carbs: 0.08,
      proteins: 0.1,
      fats: 0.1,
    },
    absolute: {
      fiber: 1,
      proteins: 1,
      fats: 1,
      carbs: 2,
      calories: 10,
    },
  },
};

async function loadFixture(name: string): Promise<Fixture> {
  const text = await Deno.readTextFile(`eval/inputs/snap-macro/${name}.json`);
  return JSON.parse(text);
}

async function listFixtureNames(): Promise<string[]> {
  const names: string[] = [];
  for await (const entry of Deno.readDir("eval/inputs/snap-macro")) {
    if (!entry.isFile || !entry.name.endsWith(".json")) continue;
    names.push(entry.name.replace(/\.json$/, ""));
  }
  names.sort();
  return names;
}

async function callSnapMacro(input: Fixture["input"]): Promise<Response> {
  const bytes = await Deno.readFile(input.imagePath);
  const imageBase64 = encodeBase64(bytes);
  const token = await getAuthToken();

  return fetch(`${FUNCTION_URL}/snap-macro`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({
      imageBase64,
      mimeType: input.mimeType,
    }),
  });
}

async function seedProfileLocale(locale: string, token: string): Promise<void> {
  const response = await fetch(`${Deno.env.get("SUPABASE_URL") ?? "http://127.0.0.1:54321"}/rest/v1/profiles?on_conflict=id`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      apikey: PUBLISHABLE_KEY,
      Authorization: `Bearer ${token}`,
      Prefer: "resolution=merge-duplicates,return=minimal",
    },
    body: JSON.stringify({
      settings: { app_locale: locale },
    }),
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Failed to seed profile locale ${locale}: ${response.status} ${text}`);
  }
}

function assertSuccessResponse(
  fixtureName: string,
  data: ApiResponse,
  expectations: Extract<Fixture["expectations"], { success: true }>,
) {
  assertEquals(data.success, true, `${fixtureName}: expected success=true`);
  if (data.response == null) {
    throw new Error(`${fixtureName}: expected response object`);
  }

  for (const field of expectations.requireFields) {
    const value = data.response[field];
    if (typeof value === "string") {
      if (!value.trim()) {
        throw new Error(`${fixtureName}: field ${field} is empty`);
      }
      continue;
    }
    if (typeof value !== "number" || !Number.isFinite(value) || value < 0) {
      throw new Error(`${fixtureName}: field ${field} is invalid`);
    }
  }

  for (const field of METRIC_FIELDS) {
    const real = expectations.real[field];
    if (real == null) continue;
    const value = data.response[field];
    if (typeof value !== "number" || !Number.isFinite(value)) {
      throw new Error(`${fixtureName}: field ${field} is not numeric`);
    }
    const { min, max } = computeAllowedRange(
      expectations.toleranceProfile,
      field,
      real,
    );
    if (value < min || value > max) {
      throw new Error(
        `${fixtureName}: ${field} ${value} outside expected range ${min}-${max} around real=${real} using profile=${expectations.toleranceProfile}`,
      );
    }
  }
}

function assertFailureResponse(
  fixtureName: string,
  data: ApiResponse,
  expectations: Extract<Fixture["expectations"], { success: false }>,
) {
  assertEquals(data.success, false, `${fixtureName}: expected success=false`);
  assertEquals(data.response, null, `${fixtureName}: expected response=null`);

  const minReasonLength = expectations.reasonMinLength ?? 1;
  if ((data.reason ?? "").trim().length < minReasonLength) {
    throw new Error(
      `${fixtureName}: reason length is below ${minReasonLength}`,
    );
  }
}

async function runFixture(fixtureName: string): Promise<void> {
  const fixture = await loadFixture(fixtureName);
  let responseBody: unknown | null = null;
  let error: string | null = null;
  let status: "pass" | "fail" = "pass";
  const token = await getAuthToken();

  await seedProfileLocale(fixture.locale ?? "en", token);

  try {
    const response = await callSnapMacro(fixture.input);
    const text = await response.text();
    responseBody = text ? JSON.parse(text) : null;

    if (!response.ok) {
      throw new Error(
        `${fixtureName}: HTTP ${response.status} ${response.statusText}\n${text}`,
      );
    }

    const data = responseBody as ApiResponse;
    if (typeof data.success !== "boolean") {
      throw new Error(`${fixtureName}: missing boolean success`);
    }
    if (typeof data.reason !== "string") {
      throw new Error(`${fixtureName}: missing string reason`);
    }

    if (fixture.expectations.success) {
      assertSuccessResponse(fixtureName, data, fixture.expectations);
    } else {
      assertFailureResponse(fixtureName, data, fixture.expectations);
    }
  } catch (err) {
    status = "fail";
    error = err instanceof Error ? err.message : String(err);
  }

  await saveTestOutput(FEATURE, fixtureName, {
    response: responseBody,
    status,
    error,
  });

  if (error) {
    throw new Error(error);
  }
}

const fixtureNames = await listFixtureNames();

for (const fixtureName of fixtureNames) {
  Deno.test({
    name: `snap-macro: ${fixtureName}`,
    ignore: !CAN_RUN_EVALS,
    async fn() {
      await runFixture(fixtureName);
    },
  });
}

function computeAllowedRange(
  profileName: "meal_photo" | "nutrition_label",
  field: MetricField,
  real: number,
) {
  const profile = TOLERANCE_PROFILES[profileName];
  const relativeTolerance = profile.relative[field] ?? 0;
  const absoluteTolerance = profile.absolute[field] ?? 0;
  const relativeDelta = Math.round(real * relativeTolerance);
  const delta = Math.max(relativeDelta, absoluteTolerance);

  return {
    min: Math.max(0, real - delta),
    max: real + delta,
  };
}
