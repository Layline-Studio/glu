import {
  assertEquals,
  assertObjectMatch,
} from "https://deno.land/std/assert/mod.ts";
import {
  collectSnapMacroValidationErrors,
  buildLocaleInstruction,
  formatProviderWarning,
  mapSnapMacroModelResponse,
  validateSnapMacroInput,
  validateSnapMacroRequestInput,
  normalizeLocaleCode,
} from "../../functions/snap-macro/core.ts";

Deno.test("validateSnapMacroInput accepts supported image payload", () => {
  const result = validateSnapMacroInput({
    imageBase64: "abc123",
    mimeType: "image/jpeg",
  });

  assertEquals(result.imageBase64, "abc123");
  assertEquals(result.mimeType, "image/jpeg");
});

Deno.test("validateSnapMacroInput rejects unsupported mime type", () => {
  let message = "";

  try {
    validateSnapMacroInput({
      imageBase64: "abc123",
      mimeType: "application/pdf",
    });
  } catch (error) {
    message = error instanceof Error ? error.message : String(error);
  }

  assertEquals(message, "Unsupported mimeType: application/pdf");
});

Deno.test("validateSnapMacroRequestInput accepts stored image payload", () => {
  const result = validateSnapMacroRequestInput({
    imagePath: "user-id/example.jpg",
    mimeType: "image/jpeg",
  });

  assertEquals("imagePath" in result, true);
  assertEquals(
    "imagePath" in result ? result.imagePath : "",
    "user-id/example.jpg",
  );
  assertEquals(result.mimeType, "image/jpeg");
});

Deno.test("validateSnapMacroRequestInput accepts text payload", () => {
  const result = validateSnapMacroRequestInput({
    text: "Chicken salad and sparkling water",
    mimeType: "text/plain",
  });

  assertEquals("text" in result, true);
  assertEquals(
    "text" in result ? result.text : "",
    "Chicken salad and sparkling water",
  );
  assertEquals(result.mimeType, "text/plain");
});

Deno.test("validateSnapMacroRequestInput rejects oversized text payload", () => {
  let message = "";

  try {
    validateSnapMacroRequestInput({
      text: "a".repeat(501),
      mimeType: "text/plain",
    });
  } catch (error) {
    message = error instanceof Error ? error.message : String(error);
  }

  assertEquals(message, "Text input exceeds 500 characters");
});

Deno.test("validateSnapMacroRequestInput accepts audio payload", () => {
  const result = validateSnapMacroRequestInput({
    base64: "abc123",
    mimeType: "audio/m4a",
  });

  assertEquals("audioBase64" in result, true);
  assertEquals("audioBase64" in result ? result.audioBase64 : "", "abc123");
  assertEquals(result.mimeType, "audio/m4a");
});

Deno.test("validateSnapMacroRequestInput requires image path", () => {
  let message = "";

  try {
    validateSnapMacroRequestInput({
      mimeType: "image/jpeg",
    });
  } catch (error) {
    message = error instanceof Error ? error.message : String(error);
  }

  assertEquals(message, "Missing imagePath");
});

Deno.test("validateSnapMacroRequestInput rejects unsupported audio mime type", () => {
  let message = "";

  try {
    validateSnapMacroRequestInput({
      base64: "abc123",
      mimeType: "audio/flac",
    });
  } catch (error) {
    message = error instanceof Error ? error.message : String(error);
  }

  assertEquals(message, "Unsupported mimeType: audio/flac");
});

Deno.test("validateSnapMacroRequestInput rejects oversized audio payload", () => {
  let message = "";

  try {
    validateSnapMacroRequestInput({
      base64: "a".repeat(12_000_001),
      mimeType: "audio/m4a",
    });
  } catch (error) {
    message = error instanceof Error ? error.message : String(error);
  }

  assertEquals(message, "Audio input is too large");
});

Deno.test("mapSnapMacroModelResponse maps success payload", () => {
  const result = mapSnapMacroModelResponse(
    {
      status: "success",
      reason: "Hidden dressing may affect calories.",
      response: {
        name: "Chicken bowl",
        calories: 640.4,
        carbs: 48.1,
        proteins: 42.2,
        fats: 24.4,
        fiber: 6.2,
        note: "Estimate based on visible portion",
      },
    },
    { model: "gemini-2.5-flash-lite", inputTokens: 10, outputTokens: 20 },
  );

  assertEquals(result.success, true);
  assertEquals(result.reason, "");
  assertObjectMatch(result.response!, {
    name: "Chicken bowl",
    calories: 640,
    carbs: 48,
    proteins: 42,
    fats: 24,
    fiber: 6,
    note: "Estimate based on visible portion",
  });
});

Deno.test("mapSnapMacroModelResponse converts uncertain result into failure payload", () => {
  const result = mapSnapMacroModelResponse(
    {
      status: "uncertain",
      reason: "Image is too blurry to estimate safely.",
      response: null,
    },
    { model: "gemini-2.5-flash-lite", inputTokens: 10, outputTokens: 20 },
  );

  assertEquals(result.success, false);
  assertEquals(result.reason, "Image is too blurry to estimate safely.");
  assertEquals(result.response, null);
});

Deno.test("mapSnapMacroModelResponse rejects malformed success response", () => {
  const result = mapSnapMacroModelResponse(
    {
      status: "success",
      reason: "",
      response: {
        name: "Toast",
        calories: 120,
        carbs: -10,
        proteins: 2,
        fats: 1,
        fiber: 1,
      },
    },
    null,
  );

  assertEquals(result.success, false);
  assertEquals(
    result.reason,
    "Invalid model response. response.carbs must be zero or greater.",
  );
  assertEquals(result.response, null);
});

Deno.test("collectSnapMacroValidationErrors returns concrete field errors", () => {
  const errors = collectSnapMacroValidationErrors({
    name: "",
    calories: 120,
    carbs: Number.NaN,
    proteins: -1,
    fats: 5,
    fiber: 2,
    note: 123 as unknown as string,
  });

  assertEquals(errors, [
    "response.name must be a non-empty string.",
    "response.carbs must be a finite number.",
    "response.proteins must be zero or greater.",
    "response.note must be a string when present.",
  ]);
});

Deno.test("formatProviderWarning preserves exact provider error", () => {
  const warning = formatProviderWarning({
    name: "AiProviderError",
    message: "Google error: API key not valid. Please pass a valid API key.",
  });

  assertEquals(
    warning,
    "AiProviderError: Google error: API key not valid. Please pass a valid API key.",
  );
});

// ── portionPercent ────────────────────────────────────────────────────────────

Deno.test("mapSnapMacroModelResponse portionPercent defaults to 1 when checkPortion absent", () => {
  const result = mapSnapMacroModelResponse(
    {
      status: "success",
      reason: "",
      response: {
        name: "Salad",
        calories: 400,
        carbs: 20,
        proteins: 30,
        fats: 15,
        fiber: 5,
      },
    },
    null,
  );

  assertEquals(result.portionPercent, 1);
});

Deno.test("mapSnapMacroModelResponse portionPercent computes partial portion", () => {
  const result = mapSnapMacroModelResponse(
    {
      status: "success",
      reason: "",
      response: {
        name: "Pasta",
        calories: 800,
        carbs: 100,
        proteins: 30,
        fats: 20,
        fiber: 4,
      },
    },
    null,
    { totalDailyConsumedCalories: 1600, totalDailyTargetCalories: 2000 },
  );

  // remaining = 400, meal = 800 → 0.5
  assertEquals(result.portionPercent, 0.5);
});

Deno.test("mapSnapMacroModelResponse portionPercent clamps to 1 when remaining exceeds meal", () => {
  const result = mapSnapMacroModelResponse(
    {
      status: "success",
      reason: "",
      response: {
        name: "Snack",
        calories: 100,
        carbs: 10,
        proteins: 5,
        fats: 3,
        fiber: 1,
      },
    },
    null,
    { totalDailyConsumedCalories: 500, totalDailyTargetCalories: 2000 },
  );

  // remaining = 1500, meal = 100 → capped at 1
  assertEquals(result.portionPercent, 1);
});

Deno.test("mapSnapMacroModelResponse portionPercent is 0 when daily limit reached", () => {
  const result = mapSnapMacroModelResponse(
    {
      status: "success",
      reason: "",
      response: {
        name: "Burger",
        calories: 700,
        carbs: 50,
        proteins: 35,
        fats: 30,
        fiber: 2,
      },
    },
    null,
    { totalDailyConsumedCalories: 2100, totalDailyTargetCalories: 2000 },
  );

  assertEquals(result.portionPercent, 0);
});

Deno.test("mapSnapMacroModelResponse portionPercent is 0 when meal has 0 calories", () => {
  const result = mapSnapMacroModelResponse(
    {
      status: "success",
      reason: "",
      response: {
        name: "Water",
        calories: 0,
        carbs: 0,
        proteins: 0,
        fats: 0,
        fiber: 0,
      },
    },
    null,
    { totalDailyConsumedCalories: 500, totalDailyTargetCalories: 2000 },
  );

  assertEquals(result.portionPercent, 0);
});

Deno.test("mapSnapMacroModelResponse portionPercent is 1 on failure result", () => {
  const result = mapSnapMacroModelResponse(
    { status: "cannot_estimate", reason: "Too blurry.", response: null },
    null,
    { totalDailyConsumedCalories: 1000, totalDailyTargetCalories: 2000 },
  );

  assertEquals(result.success, false);
  assertEquals(result.portionPercent, 1);
});

Deno.test("validateSnapMacroRequestInput accepts checkPortion on image payload", () => {
  const result = validateSnapMacroRequestInput({
    imagePath: "user/photo.jpg",
    mimeType: "image/jpeg",
    checkPortion: {
      totalDailyConsumedCalories: 1200,
      totalDailyTargetCalories: 2000,
    },
  });

  assertEquals("imagePath" in result, true);
  assertEquals(
    "checkPortion" in result ? result.checkPortion : undefined,
    { totalDailyConsumedCalories: 1200, totalDailyTargetCalories: 2000 },
  );
});

Deno.test("validateSnapMacroRequestInput rejects invalid checkPortion", () => {
  let message = "";

  try {
    validateSnapMacroRequestInput({
      imagePath: "user/photo.jpg",
      mimeType: "image/jpeg",
      checkPortion: { totalDailyConsumedCalories: -10, totalDailyTargetCalories: 2000 },
    });
  } catch (error) {
    message = error instanceof Error ? error.message : String(error);
  }

  assertEquals(message, "Invalid checkPortion.totalDailyConsumedCalories");
});

Deno.test("normalizeLocaleCode collapses regional locale tags", () => {
  assertEquals(normalizeLocaleCode("pt-BR"), "pt");
  assertEquals(normalizeLocaleCode("en-US"), "en");
  assertEquals(normalizeLocaleCode("ja-JP"), "en");
});

Deno.test("buildLocaleInstruction uses TACO for Portuguese", () => {
  const instruction = buildLocaleInstruction("pt-BR");

  assertEquals(instruction.includes("Respond in Portuguese."), true);
  assertEquals(instruction.includes("use TACO when applicable"), true);
  assertEquals(
    instruction.includes("do not translate the field names"),
    true,
  );
});

Deno.test("buildLocaleInstruction maps other locales to local standards", () => {
  const german = buildLocaleInstruction("de-DE");
  const englishFallback = buildLocaleInstruction("ja-JP");
  const arabic = buildLocaleInstruction("ar");
  const russian = buildLocaleInstruction("ru");
  const chinese = buildLocaleInstruction("zh");

  assertEquals(german.includes("use BLS when applicable"), true);
  assertEquals(
    englishFallback.includes("use USDA FoodData Central when applicable"),
    true,
  );
  assertEquals(
    arabic.includes("use Food Composition Tables for Arab Gulf Countries when applicable"),
    true,
  );
  assertEquals(
    russian.includes("use Tables of Chemical Composition and Nutritive Value of Food Products when applicable"),
    true,
  );
  assertEquals(
    chinese.includes("use China Food Composition Table (Standard, 6th Edition) when applicable"),
    true,
  );
});
