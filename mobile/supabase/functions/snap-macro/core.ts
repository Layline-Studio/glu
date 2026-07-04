import {
  AiInvalidResponseError,
  AiProviderError,
  AiRetryableProviderError,
} from "../_shared/ai_errors.ts";
import {
  callGoogleWithUsage,
  type GoogleUsage,
} from "../_shared/providers/google.ts";

export type SnapMacroInput = {
  imageBase64: string;
  mimeType: string;
};

export type CheckPortion = {
  totalDailyConsumedCalories: number;
  totalDailyTargetCalories: number;
};

export type SnapMacroTextInput = {
  text: string;
  mimeType: "text/plain";
  checkPortion?: CheckPortion;
};

export type SnapMacroAudioInput = {
  audioBase64: string;
  mimeType: string;
  checkPortion?: CheckPortion;
};

export type SnapMacroStoredImageInput = {
  imagePath: string;
  mimeType: string;
  checkPortion?: CheckPortion;
};

export type SnapMacroRequestInput =
  | SnapMacroStoredImageInput
  | SnapMacroTextInput
  | SnapMacroAudioInput;

export type SnapMacroMeal = {
  name: string;
  calories: number;
  carbs: number;
  proteins: number;
  fats: number;
  fiber: number;
  note?: string;
};

export type SnapMacroApiResponse = {
  success: boolean;
  reason: string;
  response: SnapMacroMeal | null;
  portionPercent: number;
};

export type SnapMacroCoreResult = SnapMacroApiResponse & {
  usage: GoogleUsage | null;
  raw: unknown | null;
};

type SnapMacroModelResponse = {
  status?: string;
  reason?: string;
  response?: {
    name?: string;
    calories?: number;
    carbs?: number;
    proteins?: number;
    fats?: number;
    fiber?: number;
    note?: string;
  } | null;
};

const allowedImageMimeTypes = new Set([
  "image/jpeg",
  "image/jpg",
  "image/png",
  "image/webp",
  "image/heic",
  "image/heif",
]);

const allowedAudioMimeTypes = new Set([
  "audio/m4a",
  "audio/mp4",
  "audio/aac",
  "audio/mpeg",
  "audio/mp3",
  "audio/wav",
  "audio/webm",
  "audio/ogg",
]);

const maxTextChars = 500;
const maxAudioBase64Chars = 12_000_000;

export const snapMacroStorageBucket = "assets";

const localeLanguageNames: Record<string, string> = {
  en: "English",
  pt: "Portuguese",
  fi: "Finnish",
  hi: "Hindi",
  nl: "Dutch",
  es: "Spanish",
  fr: "French",
  da: "Danish",
  de: "German",
  it: "Italian",
  ru: "Russian",
  ar: "Arabic",
  zh: "Chinese",
  no: "Norwegian",
  sv: "Swedish",
};

const localeFoodStandardNames: Record<string, string> = {
  en: "USDA FoodData Central",
  pt: "TACO",
  fi: "Fineli",
  hi: "IFCT",
  nl: "NEVO",
  es: "BEDCA",
  fr: "CIQUAL",
  da: "Frida",
  de: "BLS",
  it: "CREA",
  ru: "Tables of Chemical Composition and Nutritive Value of Food Products",
  ar: "Food Composition Tables for Arab Gulf Countries",
  zh: "China Food Composition Table (Standard, 6th Edition)",
  no: "Matvaretabellen",
  sv: "Livsmedelsverket",
};

export const snapMacroResponseSchema = {
  type: "object",
  properties: {
    status: {
      type: "string",
      enum: ["success", "uncertain", "cannot_estimate"],
    },
    reason: {
      type: "string",
      description:
        "Always present. Empty string when analysis succeeds. Non-empty only when the meal cannot be analyzed and response is null.",
    },
    response: {
      type: "object",
      nullable: true,
      properties: {
        name: { type: "string" },
        calories: { type: "number" },
        carbs: { type: "number" },
        proteins: { type: "number" },
        fats: { type: "number" },
        fiber: { type: "number" },
        note: { type: "string" },
      },
      required: ["name", "calories", "carbs", "proteins", "fats", "fiber"],
    },
  },
  required: ["status", "reason", "response"],
};

const systemPrompt = `You analyze meal inputs for nutrition logging.

Return JSON only.

Your job:
- Analyze either:
  - a meal photo,
  - a nutrition facts / nutrition label photo,
  - a typed meal description, or
  - a spoken meal description.
- Return a single combined meal entry from the provided input.
- Return grams for carbs, proteins, fats, and fiber.
- Return calories as a whole-number estimate for the entire meal.
- Return a short, user-facing meal name.
- Optionally return a brief note when there is relevant uncertainty, hidden ingredients, or portion ambiguity.
- Put any observation or caveat about a successful estimate into note, not reason.

Estimation method:
- First identify whether the input is:
  - a meal photo,
  - a nutrition facts label / packaging nutrition panel,
  - a typed meal description, or
  - a spoken meal description.
- If it is a meal photo:
  - identify the visible meal components
  - estimate portion size for each major component
  - estimate macros for each major component
  - sum the components into one combined meal result
- If it is a nutrition facts label:
  - read the visible nutrition values directly from the label
  - use the label values instead of visual estimation
  - if serving count is visible but total package nutrition is not explicit, use the clearly shown per-serving values
  - create a short natural name based on the product or food shown when possible, otherwise use a generic but useful name
- If it is a typed or spoken meal description:
  - identify each food, drink, and portion mentioned
  - if a recognizable named dish is given without a portion, assume one standard serving
  - use standard restaurant or home-serving assumptions when the dish is common and recognizable
  - estimate the full meal conservatively from the description
  - do not invent extra foods or portions that were not stated

Nutrition heuristics:
- Oils, dressings, sauces, cheese, nuts, seeds, fried coatings, and creamy toppings are major calorie drivers and must not be ignored when visibly present.
- Leafy greens and non-starchy vegetables are usually low calorie unless there is visible dressing, cheese, avocado, seeds, croutons, or oil.
- Rice, pasta, bread, potatoes, tortillas, grains, and croutons are usually the main carb sources.
- Meat, fish, eggs, tofu, beans, yogurt, and cheese are common protein sources, but cheese and nuts can also contribute substantial fat.
- Fiber should stay conservative unless vegetables, legumes, whole grains, fruit, seeds, or beans are clearly visible.
- Beverages, sides, dips, and sauces should only be included if they are clearly part of the meal shown in the image.
- Do not anchor on a healthy-sounding meal name. A salad can still be high calorie if visible ingredients include dressing, cheese, nuts, avocado, croutons, oil, or fried protein.

Rules:
- Be conservative. Do not invent precision you cannot support visually.
- Be conservative. Do not invent precision you cannot support from the provided description.
- Prefer a conservative but realistic estimate over a lowball estimate that ignores visible calorie-dense ingredients.
- For text or audio meal descriptions, prefer a standard-serving estimate with a brief note over rejecting a recognizable dish solely because portion size was omitted.
- Recognizable meals like "spaghetti bolognese", "chicken caesar salad", "burger and fries", or "pepperoni pizza" should usually return success with a conservative standard-serving estimate.
- Only return "uncertain" or "cannot_estimate" for text or audio when the description is truly too generic or missing the actual food, such as "lunch", "pasta", "snack", or "some food".
- If the input is not a meal photo, nutrition facts label, or meal description, or is too blurry, too dark, too noisy, or too ambiguous to estimate responsibly, do not guess a meal.
- When the input is estimate-able, set status to "success", set reason to an empty string, and return response.
- If there is any caveat for a successful estimate, put it in note.
- When it is not estimate-able with enough confidence, set status to "uncertain" or "cannot_estimate", include a short reason, and set response to null.
- Never return negative numbers.
- Never return ranges.
- Keep the meal name short and natural.
- Use note only for concise extra context; omit it when unnecessary.`;

const userPrompt = `Estimate the macros from the attached image.

The image may be either:
- a meal photo, or
- a nutrition facts label / packaging nutrition panel.

Return JSON with:
- status
- reason
- response

Set response to null unless the estimate is good enough to log as a meal.`;

const textUserPrompt =
  `Estimate the macros from the provided meal description text.

Treat the text as a direct user description of what they ate.
If the user gives a recognizable meal name without a portion, assume one standard serving and include a brief note saying it was estimated from a standard serving.

Return JSON with:
- status
- reason
- response

Set response to null unless the estimate is good enough to log as a meal.`;

const audioUserPrompt = `Estimate the macros from the attached audio.

First understand the spoken meal description, then estimate the full meal.
If the speaker gives a recognizable meal name without a portion, assume one standard serving and include a brief note saying it was estimated from a standard serving.

Return JSON with:
- status
- reason
- response

Set response to null unless the estimate is good enough to log as a meal.`;

export function normalizeLocaleCode(localeCode?: string | null): string {
  const value = localeCode?.trim();
  if (!value) {
    return "en";
  }

  const normalized = value.replaceAll("_", "-").split("-")[0]?.toLowerCase();
  if (!normalized) {
    return "en";
  }

  return normalized in localeLanguageNames ? normalized : "en";
}

function localeLanguageName(localeCode?: string | null): string {
  const normalized = normalizeLocaleCode(localeCode);
  return localeLanguageNames[normalized] ?? localeLanguageNames.en;
}

function localeFoodStandardName(localeCode?: string | null): string {
  const normalized = normalizeLocaleCode(localeCode);
  return localeFoodStandardNames[normalized] ??
    "the local food composition standard";
}

export function buildLocaleInstruction(localeCode?: string | null): string {
  const language = localeLanguageName(localeCode);
  const foodStandard = localeFoodStandardName(localeCode);
  return `The user's app language is ${language}. Respond in ${language}. When estimating foods, use ${foodStandard} when applicable. Use natural ${language} for response.name and response.note when possible. Keep the JSON keys and schema exactly as specified, and do not translate the field names.`;
}

function buildLocalizedPrompt(basePrompt: string, localeCode?: string | null) {
  return `${buildLocaleInstruction(localeCode)}\n\n${basePrompt}`;
}

export function validateSnapMacroInput(input: unknown): SnapMacroInput {
  const body = input && typeof input === "object"
    ? (input as Record<string, unknown>)
    : {};
  const imageBase64 = typeof body.imageBase64 === "string"
    ? body.imageBase64.trim()
    : "";
  const mimeType = typeof body.mimeType === "string"
    ? body.mimeType.trim().toLowerCase()
    : "";

  if (!imageBase64) {
    throw new Error("Missing imageBase64");
  }

  if (!mimeType) {
    throw new Error("Missing mimeType");
  }

  if (!allowedImageMimeTypes.has(mimeType)) {
    throw new Error(`Unsupported mimeType: ${mimeType}`);
  }

  return { imageBase64, mimeType };
}

export function validateSnapMacroRequestInput(
  input: unknown,
): SnapMacroRequestInput {
  const body = input && typeof input === "object"
    ? (input as Record<string, unknown>)
    : {};
  const text = typeof body.text === "string" ? body.text.trim() : "";
  const audioBase64 = typeof body.base64 === "string" ? body.base64.trim() : "";
  const imagePath = typeof body.imagePath === "string"
    ? body.imagePath.trim()
    : "";
  const mimeType = typeof body.mimeType === "string"
    ? body.mimeType.trim().toLowerCase()
    : "";
  const checkPortion = parseCheckPortion(body);

  if (text) {
    if (text.length > maxTextChars) {
      throw new Error(`Text input exceeds ${maxTextChars} characters`);
    }
    if (mimeType && mimeType !== "text/plain") {
      throw new Error(`Unsupported mimeType: ${mimeType}`);
    }
    return { text, mimeType: "text/plain", ...(checkPortion && { checkPortion }) };
  }

  if (audioBase64) {
    if (audioBase64.length > maxAudioBase64Chars) {
      throw new Error("Audio input is too large");
    }
    if (!mimeType) {
      throw new Error("Missing mimeType");
    }
    if (!allowedAudioMimeTypes.has(mimeType)) {
      throw new Error(`Unsupported mimeType: ${mimeType}`);
    }
    return { audioBase64, mimeType, ...(checkPortion && { checkPortion }) };
  }

  if (!imagePath) {
    throw new Error("Missing imagePath");
  }

  if (!mimeType) {
    throw new Error("Missing mimeType");
  }

  if (!allowedImageMimeTypes.has(mimeType)) {
    throw new Error(`Unsupported mimeType: ${mimeType}`);
  }

  return { imagePath, mimeType, ...(checkPortion && { checkPortion }) };
}

function parseCheckPortion(
  body: Record<string, unknown>,
): CheckPortion | undefined {
  const cp = body.checkPortion;
  if (cp == null) return undefined;
  if (typeof cp !== "object" || Array.isArray(cp)) {
    throw new Error("Invalid checkPortion");
  }
  const obj = cp as Record<string, unknown>;
  const consumed = obj.totalDailyConsumedCalories;
  const target = obj.totalDailyTargetCalories;
  if (
    typeof consumed !== "number" || !Number.isFinite(consumed) || consumed < 0
  ) {
    throw new Error("Invalid checkPortion.totalDailyConsumedCalories");
  }
  if (
    typeof target !== "number" || !Number.isFinite(target) || target < 0
  ) {
    throw new Error("Invalid checkPortion.totalDailyTargetCalories");
  }
  return {
    totalDailyConsumedCalories: consumed,
    totalDailyTargetCalories: target,
  };
}

export function toSnapMacroApiResponse(
  result: SnapMacroCoreResult,
): SnapMacroApiResponse {
  return {
    success: result.success,
    reason: result.reason,
    response: result.response,
    portionPercent: result.portionPercent,
  };
}

export function mapSnapMacroModelResponse(
  parsed: SnapMacroModelResponse,
  usage: GoogleUsage | null,
  checkPortion?: CheckPortion,
): SnapMacroCoreResult {
  const status = typeof parsed?.status === "string"
    ? parsed.status.trim().toLowerCase()
    : "";
  const reason = typeof parsed?.reason === "string" ? parsed.reason.trim() : "";

  if (
    status !== "success" && status !== "uncertain" &&
    status !== "cannot_estimate"
  ) {
    return failureResult("Invalid model status.", usage, parsed);
  }

  if (status !== "success") {
    return {
      success: false,
      reason: reason ||
        "Could not estimate macros confidently from the image.",
      response: null,
      portionPercent: 1,
      usage,
      raw: parsed,
    };
  }

  const validationErrors = collectSnapMacroValidationErrors(parsed?.response);
  if (validationErrors.length > 0) {
    return failureResult(
      `Invalid model response. ${validationErrors.join(" ")}`,
      usage,
      parsed,
    );
  }
  const meal = normalizeMeal(parsed?.response)!;

  return {
    success: true,
    reason: "",
    response: meal,
    portionPercent: computePortionPercent(checkPortion, meal.calories),
    usage,
    raw: parsed,
  };
}

export async function analyzeMealFromImage(
  input: SnapMacroInput,
  checkPortion?: CheckPortion,
  localeCode?: string | null,
): Promise<SnapMacroCoreResult> {
  try {
    const attachments = [
      {
        mimeType: input.mimeType,
        dataBase64: input.imageBase64,
      },
    ];
    let validationFeedback: string[] = [];
    let combinedUsage: GoogleUsage | null = null;
    let lastResult: SnapMacroModelResponse | null = null;

    for (let attempt = 0; attempt < 2; attempt++) {
      const { result, usage } = await callGoogleWithUsage<
        SnapMacroModelResponse
      >(
        systemPrompt,
        {
          userPrompt: buildLocalizedPrompt(userPrompt, localeCode),
          attachments,
          attachmentInstructionText:
            "Analyze the attached image in full before answering.",
          schema: snapMacroResponseSchema,
          validationFeedback,
        },
      );
      lastResult = result;
      combinedUsage = mergeUsage(combinedUsage, usage);

      const status = typeof result?.status === "string"
        ? result.status.trim().toLowerCase()
        : "";
      if (status === "success") {
        const errors = collectSnapMacroValidationErrors(result?.response);
        if (errors.length === 0) {
          return mapSnapMacroModelResponse(result, combinedUsage, checkPortion);
        }
        validationFeedback = errors;
        continue;
      }

      return mapSnapMacroModelResponse(result, combinedUsage, checkPortion);
    }

    const finalErrors = collectSnapMacroValidationErrors(lastResult?.response);
    return failureResult(
      finalErrors.length > 0
        ? `Invalid model response. ${finalErrors.join(" ")}`
        : "Invalid model response.",
      combinedUsage,
      lastResult,
    );
  } catch (error) {
    if (
      error instanceof AiProviderError ||
      error instanceof AiRetryableProviderError ||
      error instanceof AiInvalidResponseError
    ) {
      return failureResult(
        formatProviderWarning(error),
        null,
        {
          error: error.message,
          name: error.name,
        },
      );
    }
    throw error;
  }
}

export async function analyzeMealFromText(
  text: string,
  checkPortion?: CheckPortion,
  localeCode?: string | null,
): Promise<SnapMacroCoreResult> {
  try {
    let validationFeedback: string[] = [];
    let combinedUsage: GoogleUsage | null = null;
    let lastResult: SnapMacroModelResponse | null = null;

    for (let attempt = 0; attempt < 2; attempt++) {
      const { result, usage } = await callGoogleWithUsage<
        SnapMacroModelResponse
      >(
        systemPrompt,
        {
          userPrompt: buildLocalizedPrompt(
            `${textUserPrompt}\n\nMeal description:\n${text}`,
            localeCode,
          ),
          schema: snapMacroResponseSchema,
          validationFeedback,
        },
      );
      lastResult = result;
      combinedUsage = mergeUsage(combinedUsage, usage);

      const status = typeof result?.status === "string"
        ? result.status.trim().toLowerCase()
        : "";
      if (status === "success") {
        const errors = collectSnapMacroValidationErrors(result?.response);
        if (errors.length === 0) {
          return mapSnapMacroModelResponse(result, combinedUsage, checkPortion);
        }
        validationFeedback = errors;
        continue;
      }

      return mapSnapMacroModelResponse(result, combinedUsage, checkPortion);
    }

    const finalErrors = collectSnapMacroValidationErrors(lastResult?.response);
    return failureResult(
      finalErrors.length > 0
        ? `Invalid model response. ${finalErrors.join(" ")}`
        : "Invalid model response.",
      combinedUsage,
      lastResult,
    );
  } catch (error) {
    if (
      error instanceof AiProviderError ||
      error instanceof AiRetryableProviderError ||
      error instanceof AiInvalidResponseError
    ) {
      return failureResult(
        formatProviderWarning(error),
        null,
        {
          error: error.message,
          name: error.name,
        },
      );
    }
    throw error;
  }
}

export async function analyzeMealFromAudio(
  input: SnapMacroAudioInput,
  checkPortion?: CheckPortion,
  localeCode?: string | null,
): Promise<SnapMacroCoreResult> {
  try {
    const attachments = [
      {
        mimeType: input.mimeType,
        dataBase64: input.audioBase64,
      },
    ];
    let validationFeedback: string[] = [];
    let combinedUsage: GoogleUsage | null = null;
    let lastResult: SnapMacroModelResponse | null = null;

    for (let attempt = 0; attempt < 2; attempt++) {
      const { result, usage } = await callGoogleWithUsage<
        SnapMacroModelResponse
      >(
        systemPrompt,
        {
          userPrompt: buildLocalizedPrompt(audioUserPrompt, localeCode),
          attachments,
          attachmentInstructionText:
            "Listen to the attached audio in full before answering.",
          schema: snapMacroResponseSchema,
          validationFeedback,
        },
      );
      lastResult = result;
      combinedUsage = mergeUsage(combinedUsage, usage);

      const status = typeof result?.status === "string"
        ? result.status.trim().toLowerCase()
        : "";
      if (status === "success") {
        const errors = collectSnapMacroValidationErrors(result?.response);
        if (errors.length === 0) {
          return mapSnapMacroModelResponse(result, combinedUsage, checkPortion);
        }
        validationFeedback = errors;
        continue;
      }

      return mapSnapMacroModelResponse(result, combinedUsage, checkPortion);
    }

    const finalErrors = collectSnapMacroValidationErrors(lastResult?.response);
    return failureResult(
      finalErrors.length > 0
        ? `Invalid model response. ${finalErrors.join(" ")}`
        : "Invalid model response.",
      combinedUsage,
      lastResult,
    );
  } catch (error) {
    if (
      error instanceof AiProviderError ||
      error instanceof AiRetryableProviderError ||
      error instanceof AiInvalidResponseError
    ) {
      return failureResult(
        formatProviderWarning(error),
        null,
        {
          error: error.message,
          name: error.name,
        },
      );
    }
    throw error;
  }
}

function normalizeMeal(
  meal: SnapMacroModelResponse["response"],
): SnapMacroMeal | null {
  const errors = collectSnapMacroValidationErrors(meal);
  if (errors.length > 0 || !meal || typeof meal !== "object") {
    return null;
  }

  const name = typeof meal.name === "string" ? meal.name.trim() : "";
  const normalized = {
    name,
    calories: normalizeNumber(meal.calories),
    carbs: normalizeNumber(meal.carbs),
    proteins: normalizeNumber(meal.proteins),
    fats: normalizeNumber(meal.fats),
    fiber: normalizeNumber(meal.fiber),
  };

  if (
    Object.values(normalized).some((value) =>
      typeof value === "number" && !Number.isFinite(value)
    )
  ) {
    return null;
  }

  if (
    normalized.calories == null ||
    normalized.carbs == null ||
    normalized.proteins == null ||
    normalized.fats == null ||
    normalized.fiber == null
  ) {
    return null;
  }

  if (
    normalized.calories < 0 ||
    normalized.carbs < 0 ||
    normalized.proteins < 0 ||
    normalized.fats < 0 ||
    normalized.fiber < 0
  ) {
    return null;
  }

  const note = typeof meal.note === "string" ? meal.note.trim() : "";
  const {
    calories,
    carbs,
    proteins,
    fats,
    fiber,
  } = normalized as {
    calories: number;
    carbs: number;
    proteins: number;
    fats: number;
    fiber: number;
  };

  return {
    name,
    calories,
    carbs,
    proteins,
    fats,
    fiber,
    ...(note ? { note } : {}),
  };
}

function normalizeNumber(value: unknown): number | null {
  if (typeof value !== "number" || !Number.isFinite(value)) {
    return null;
  }
  return Math.round(value);
}

function computePortionPercent(
  checkPortion: CheckPortion | undefined,
  mealCalories: number,
): number {
  if (!checkPortion) return 1;
  const remaining = checkPortion.totalDailyTargetCalories -
    checkPortion.totalDailyConsumedCalories;
  if (remaining <= 0 || mealCalories <= 0) return 0;
  const rawPortionPercent = remaining / mealCalories;
  const roundedPortionPercent = Math.ceil(rawPortionPercent * 4) / 4;
  return Math.min(roundedPortionPercent, 1);
}

function failureResult(
  reason: string,
  usage: GoogleUsage | null,
  raw: unknown,
): SnapMacroCoreResult {
  return {
    success: false,
    reason,
    response: null,
    portionPercent: 1,
    usage,
    raw,
  };
}

export function formatProviderWarning(error: {
  name?: string;
  message?: string;
}) {
  const message = typeof error.message === "string" ? error.message.trim() : "";
  if (!message) {
    return "Could not analyze the meal image right now.";
  }

  const normalizedMessage = message.replace(/\s+/g, " ");
  return `${error.name ?? "Error"}: ${normalizedMessage}`;
}

export function collectSnapMacroValidationErrors(
  meal: SnapMacroModelResponse["response"],
): string[] {
  const errors: string[] = [];

  if (!meal || typeof meal !== "object") {
    return ["response must be an object when status is success."];
  }

  const name = typeof meal.name === "string" ? meal.name.trim() : "";
  if (!name) {
    errors.push("response.name must be a non-empty string.");
  }

  for (
    const field of ["calories", "carbs", "proteins", "fats", "fiber"] as const
  ) {
    const value = meal[field];
    if (typeof value !== "number" || !Number.isFinite(value)) {
      errors.push(`response.${field} must be a finite number.`);
      continue;
    }
    if (value < 0) {
      errors.push(`response.${field} must be zero or greater.`);
    }
  }

  if (meal.note != null && typeof meal.note !== "string") {
    errors.push("response.note must be a string when present.");
  }

  return errors;
}

function mergeUsage(
  current: GoogleUsage | null,
  next: GoogleUsage,
): GoogleUsage {
  if (!current) {
    return { ...next };
  }

  return {
    model: next.model || current.model,
    inputTokens: current.inputTokens + next.inputTokens,
    outputTokens: current.outputTokens + next.outputTokens,
    promptCacheReadTokens: (current.promptCacheReadTokens ?? 0) +
      (next.promptCacheReadTokens ?? 0),
  };
}
