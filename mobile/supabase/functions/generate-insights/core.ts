import {
  AiInvalidResponseError,
  AiProviderError,
} from "../_shared/ai_errors.ts";
import {
  callGoogleWithUsage,
  type GoogleUsage,
} from "../_shared/providers/google.ts";

export type InsightType = "DAY" | "WEEK" | "MONTH";

export type GenerateInsightsRequestInput = {
  currentTimestamp: string;
};

export type GenerateInsightsSummary = {
  summary: string;
};

export type GenerateInsightsApiResponse = {
  success: boolean;
  reason: string;
  response: GenerateInsightsSummary | null;
};

export type GenerateInsightsCoreResult = GenerateInsightsApiResponse & {
  usage: GoogleUsage | null;
  raw: unknown | null;
};

type GenerateInsightsModelResponse = {
  summary?: string;
};

type TimeWindow = {
  startMs: number;
  endMs: number;
  offsetMinutes: number;
  offsetLabel: string;
  startIso: string;
  endIso: string;
  localNowIso: string;
};

type RecordsRow = Record<string, unknown>;

type DailyBucket = {
  date: string;
  mealCount: number;
  mealCalories: number;
  waterMl: number;
  exerciseMinutes: number;
  exerciseCount: number;
  doses: number;
  supplements: number;
  symptoms: number;
  symptomNames: string[];
  mood: number;
  weight: number;
  glowup: number;
};

const isoWithTimezonePattern = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/;

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

export const generateInsightsResponseSchema = {
  type: "object",
  properties: {
    summary: {
      type: "string",
      description:
        "A concise, user-facing insight summary based only on the provided profile and record context.",
    },
  },
  required: ["summary"],
};

export function validateGenerateInsightsRequestInput(
  input: unknown,
): GenerateInsightsRequestInput {
  const body = input && typeof input === "object"
    ? (input as Record<string, unknown>)
    : {};
  const currentTimestamp = typeof body.currentTimestamp === "string"
    ? body.currentTimestamp.trim()
    : "";

  if (!currentTimestamp) {
    throw new Error("Missing currentTimestamp");
  }
  if (!isIsoWithTimezone(currentTimestamp)) {
    throw new Error("Invalid currentTimestamp");
  }

  return {
    currentTimestamp,
  };
}

export function mapGenerateInsightsModelResponse(
  parsed: GenerateInsightsModelResponse,
  usage: GoogleUsage | null,
): GenerateInsightsCoreResult {
  const summary = typeof parsed?.summary === "string"
    ? parsed.summary.trim()
    : "";

  if (!summary) {
    throw new AiInvalidResponseError(
      "google",
      "Google response missing summary.",
    );
  }

  return {
    success: true,
    reason: "",
    response: { summary },
    usage,
    raw: parsed,
  };
}

export function toGenerateInsightsApiResponse(
  result: GenerateInsightsCoreResult,
): GenerateInsightsApiResponse {
  return {
    success: result.success,
    reason: result.reason,
    response: result.response,
  };
}

export async function generateInsightsFromData(
  input: GenerateInsightsRequestInput,
  profile: Record<string, unknown>,
  records: RecordsRow,
): Promise<GenerateInsightsCoreResult> {
  const period = inferInsightPeriod(input.currentTimestamp);
  const window = computeTimeWindow(input.currentTimestamp, period);
  const dataset = summarizeInsightDataset(
    period,
    normalizeProfile(profile),
    normalizeRecords(records),
    window,
  );
  const promptPayload = buildInsightPromptPayload(dataset);
  const localeCode = getProfileLocaleCode(profile);
  const result = await callGoogleWithUsage<GenerateInsightsModelResponse>(
    systemPrompt,
    {
      schema: generateInsightsResponseSchema,
      userPrompt: buildLocalizedPrompt(
        promptPrefix,
        promptPayload,
        localeCode,
      ),
    },
  );

  return mapGenerateInsightsModelResponse(result.result, result.usage);
}

function getProfileLocaleCode(profile: Record<string, unknown>): string {
  const settings = normalizeRecordObject(profile.settings);
  const locale = stringOrNull(settings.app_locale);
  return normalizeLocaleCode(locale);
}

function normalizeLocaleCode(localeCode?: string | null): string {
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

function buildLocalizedPrompt(
  basePrompt: string,
  payload: Record<string, unknown>,
  localeCode?: string | null,
): string {
  const language = localeLanguageName(localeCode);
  const instruction =
    `The user's app language is ${language}. Respond in ${language}. Keep the output natural and conversational in ${language}.`;

  return `${instruction}\n\n${basePrompt}\n\n${JSON.stringify(payload, null, 2)}`;
}

export function inferInsightPeriod(currentTimestamp: string): InsightType {
  const offsetMinutes = parseTimezoneOffsetMinutes(currentTimestamp);
  const instantMs = Date.parse(currentTimestamp);
  if (Number.isNaN(instantMs)) {
    throw new AiProviderError("google", "Invalid currentTimestamp.");
  }

  const localNow = toLocalParts(instantMs, offsetMinutes);
  if (localNow.day === 1) {
    return "MONTH";
  }

  const weekday = weekdayFromDateParts(localNow.year, localNow.month, localNow.day);
  if (weekday === 1) {
    return "WEEK";
  }

  return "DAY";
}

export function computeTimeWindow(
  currentTimestamp: string,
  period: InsightType,
): TimeWindow {
  const offsetMinutes = parseTimezoneOffsetMinutes(currentTimestamp);
  const offsetLabel = formatOffsetLabel(offsetMinutes);
  const instantMs = Date.parse(currentTimestamp);
  if (Number.isNaN(instantMs)) {
    throw new AiProviderError("google", "Invalid currentTimestamp.");
  }

  const localNow = toLocalParts(instantMs, offsetMinutes);
  let startLocal: LocalParts;
  let endLocal: LocalParts;

  switch (period) {
    case "DAY":
      startLocal = {
        year: localNow.year,
        month: localNow.month,
        day: localNow.day,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
      };
      endLocal = addDaysLocal(startLocal, 1);
      break;
    case "WEEK": {
      const startOfDay = {
        year: localNow.year,
        month: localNow.month,
        day: localNow.day,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
      };
      const weekday = weekdayFromDateParts(localNow.year, localNow.month, localNow.day);
      const daysSinceMonday = weekday === 0 ? 6 : weekday - 1;
      startLocal = addDaysLocal(startOfDay, -daysSinceMonday);
      endLocal = addDaysLocal(startLocal, 7);
      break;
    }
    case "MONTH":
      endLocal = {
        year: localNow.year,
        month: localNow.month,
        day: 1,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
      };
      startLocal = localNow.month === 1
        ? {
          year: localNow.year - 1,
          month: 12,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
        }
        : {
          year: localNow.year,
          month: localNow.month - 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
        };
      break;
    default:
      throw new AiProviderError("google", "Unsupported insight type.");
  }

  const startMs = localPartsToUtcMs(startLocal, offsetMinutes);
  const endMs = localPartsToUtcMs(endLocal, offsetMinutes);

  return {
    startMs,
    endMs,
    offsetMinutes,
    offsetLabel,
    startIso: formatIsoWithOffset(startLocal, offsetLabel),
    endIso: formatIsoWithOffset(endLocal, offsetLabel),
    localNowIso: formatIsoWithOffset(localNow, offsetLabel),
  };
}

function summarizeInsightDataset(
  period: InsightType,
  profile: RecordsRow,
  records: RecordsRow,
  window: TimeWindow,
): Record<string, unknown> {
  const buckets = createDailyBuckets(window);

  const meals = filterEntries(records.meals, window);
  const water = filterEntries(records.water, window);
  const exercise = filterEntries(records.exercise, window);
  const weight = filterEntries(records.weight, window);
  const symptoms = filterEntries(records.symptoms, window);
  const mood = filterEntries(records.mood, window);
  const supplements = filterEntries(records.supplements, window);
  const doses = filterEntries(records.doses, window);
  const glowup = filterEntries(records.glowup, window);

  const mealTotals = summarizeMeals(meals, buckets, window.offsetMinutes);
  const waterTotals = summarizeWater(water, buckets, window.offsetMinutes);
  const exerciseTotals = summarizeExercise(exercise, buckets, window.offsetMinutes);
  const weightSummary = summarizeWeight(weight, buckets, window.offsetMinutes);
  const symptomSummary = summarizeSymptoms(symptoms, buckets, window.offsetMinutes);
  const moodSummary = summarizeMood(mood, buckets, window.offsetMinutes);
  const doseSummary = summarizeDoses(doses, buckets, window.offsetMinutes);
  const supplementSummary = summarizeSupplements(
    supplements,
    buckets,
    window.offsetMinutes,
  );
  const glowupSummary = summarizeGlowup(glowup, buckets, window.offsetMinutes);

  return {
    periodType: period,
    period: {
      start: window.startIso,
      end: window.endIso,
      currentLocalTimestamp: window.localNowIso,
      offset: window.offsetLabel,
    },
    profile: profileSnapshot(profile),
    goals: goalSnapshot(profile, {
      mealTotals,
      waterTotals,
      exerciseTotals,
      weightSummary,
      window,
    }),
    aggregates: {
      meals: mealTotals,
      water: waterTotals,
      exercise: exerciseTotals,
      weight: weightSummary,
      symptoms: symptomSummary,
      mood: moodSummary,
      doses: doseSummary,
      supplements: supplementSummary,
      glowup: glowupSummary,
    },
    daily: buckets.map((bucket) => ({
      date: bucket.date,
      mealCount: bucket.mealCount,
      mealCalories: roundOne(bucket.mealCalories),
      waterMl: roundOne(bucket.waterMl),
      exerciseMinutes: roundOne(bucket.exerciseMinutes),
      exerciseCount: bucket.exerciseCount,
      weightEntries: bucket.weight,
      doseCount: bucket.doses,
      supplementCount: bucket.supplements,
      symptomCount: bucket.symptoms,
      symptomNames: bucket.symptomNames,
      moodCount: bucket.mood,
      glowUpCount: bucket.glowup,
    })),
  };
}

function buildInsightPromptPayload(
  dataset: Record<string, unknown>,
): Record<string, unknown> {
  const profile = normalizeRecordObject(dataset.profile);
  const goals = normalizeRecordObject(dataset.goals);
  const aggregates = normalizeRecordObject(dataset.aggregates);
  const meals = normalizeRecordObject(aggregates.meals);
  const water = normalizeRecordObject(aggregates.water);
  const exercise = normalizeRecordObject(aggregates.exercise);
  const weight = normalizeRecordObject(aggregates.weight);
  const symptoms = normalizeRecordObject(aggregates.symptoms);
  const mood = normalizeRecordObject(aggregates.mood);
  const doses = normalizeRecordObject(aggregates.doses);
  const supplements = normalizeRecordObject(aggregates.supplements);
  const glowup = normalizeRecordObject(aggregates.glowup);

  return {
    period: dataset.period,
    logs_today: {
      meals: {
        count: numberOrZero(meals.count),
        calories: numberOrZero(meals.totalCalories),
        carbs_grams: numberOrZero(meals.totalCarbsGrams),
        protein_grams: numberOrZero(meals.totalProteinGrams),
        fats_grams: numberOrZero(meals.totalFatGrams),
        fiber_grams: numberOrZero(meals.totalFiberGrams),
        note_count: numberOrZero(meals.noteCount),
        top_names: normalizeUnknownValue(meals.topNames),
      },
      water: {
        count: numberOrZero(water.count),
        milliliters: numberOrZero(water.totalMl),
      },
      exercise: {
        count: numberOrZero(exercise.count),
        minutes: numberOrZero(exercise.totalMinutes),
        intensity_counts: normalizeUnknownValue(exercise.intensityCounts),
      },
      weight: {
        count: numberOrZero(weight.count),
        latest_kg: normalizeUnknownValue(weight.latestKg),
        change_kg: normalizeUnknownValue(weight.changeKg),
      },
      symptoms: {
        count: numberOrZero(symptoms.count),
        severity_counts: normalizeUnknownValue(symptoms.severityCounts),
        symptom_counts: normalizeUnknownValue(symptoms.symptomCounts),
      },
      mood: {
        count: numberOrZero(mood.count),
        feeling_counts: normalizeUnknownValue(mood.feelingCounts),
      },
      doses: {
        count: numberOrZero(doses.count),
        method_counts: normalizeUnknownValue(doses.methodCounts),
        medication_counts: normalizeUnknownValue(doses.medicationCounts),
      },
      supplements: {
        count: numberOrZero(supplements.count),
        names: normalizeUnknownValue(supplements.names),
      },
      glowup: {
        count: numberOrZero(glowup.count),
      },
    },
    active_goals: buildActiveGoals(profile, goals),
    goal_progress: {
      water: normalizeUnknownValue(goals.water),
      exercise: normalizeUnknownValue(goals.exercise),
      meals: normalizeUnknownValue(goals.meals),
      protein: normalizeUnknownValue(goals.protein),
      fiber: normalizeUnknownValue(goals.fiber),
      weight: normalizeUnknownValue(goals.weight),
    },
    journey_stage: inferJourneyStage(dataset, profile, aggregates),
    recent_pattern: buildRecentPattern(dataset, aggregates, profile),
    attention_pattern: buildAttentionPattern(dataset),
    tone: "warm, calm, encouraging, non-judgmental, precise",
    output: {
      type: "card_copy",
      max_words: 55,
      paragraph_count: 1,
      response_field: "summary",
    },
  };
}

function buildActiveGoals(
  profile: RecordsRow,
  goals: RecordsRow,
): Array<Record<string, unknown>> {
  const entries: Array<Record<string, unknown>> = [];
  const goalEntries = [
    ["water", "Water"],
    ["exercise", "Movement"],
    ["meals", "Meals"],
    ["protein", "Protein"],
    ["fiber", "Fiber"],
    ["weight", "Weight"],
  ] as const;

  for (const [key, label] of goalEntries) {
    const goal = normalizeRecordObject(goals[key]);
    const enabled = goal.enabled !== false;
    if (!enabled) {
      continue;
    }
    const history = asRecordArray(goal.history);
    const current = history.at(-1) ?? null;
    if (!current) {
      continue;
    }

    entries.push({
      key,
      label,
      timeframe: stringOrNull(current.timeframe),
      target: goalTargetSnapshot(current),
    });
  }

  return entries;
}

function goalTargetSnapshot(current: RecordsRow): Record<string, unknown> {
  return {
    mode: stringOrNull(current.mode),
    target_ml: numberOrNull(current.target_ml),
    target_minutes: numberOrNull(current.target_minutes),
    target_grams: numberOrNull(current.target_grams),
    target_value: numberOrNull(current.target_value),
    target_kg: numberOrNull(current.target_kg),
    target_unit: stringOrNull(current.target_unit),
  };
}

function inferJourneyStage(
  dataset: Record<string, unknown>,
  profile: RecordsRow,
  aggregates: Record<string, unknown>,
): string {
  const settings = normalizeRecordObject(profile.settings);
  const totalLogs = [
    "meals",
    "water",
    "exercise",
    "weight",
    "symptoms",
    "mood",
    "doses",
    "supplements",
    "glowup",
  ].reduce((sum, key) => {
    const item = normalizeRecordObject(aggregates[key]);
    return sum + numberOrZero(item.count);
  }, 0);
  const onboardingCompletedAt = stringOrNull(settings.onboarding_completed_at);
  const primaryGoal = stringOrNull(settings.primary_goal);
  const medicationStatus = stringOrNull(settings.medication_status);

  if (totalLogs <= 2) {
    return "getting started";
  }
  if (totalLogs <= 7) {
    return "building consistency";
  }
  if (medicationStatus === "started" || medicationStatus === "ongoing") {
    return "staying on track with treatment";
  }
  if (onboardingCompletedAt) {
    return primaryGoal ? "tracking with a clear goal" : "tracking regularly";
  }
  return "building momentum";
}

function buildRecentPattern(
  dataset: Record<string, unknown>,
  aggregates: Record<string, unknown>,
  profile: RecordsRow,
): string | null {
  const logs: string[] = [];
  const meals = normalizeRecordObject(aggregates.meals);
  const water = normalizeRecordObject(aggregates.water);
  const exercise = normalizeRecordObject(aggregates.exercise);
  const weight = normalizeRecordObject(aggregates.weight);
  const symptoms = normalizeRecordObject(aggregates.symptoms);
  const doses = normalizeRecordObject(aggregates.doses);
  const mood = normalizeRecordObject(aggregates.mood);

  if (numberOrZero(meals.count) > 0 && numberOrZero(water.count) > 0) {
    logs.push("Meals and water were both logged, which gives a clearer view of the day.");
  } else if (numberOrZero(meals.count) > 0) {
    logs.push("Meal logging is the strongest signal in this window.");
  } else if (numberOrZero(water.count) > 0) {
    logs.push("Water logging is the clearest routine signal in this window.");
  }

  if (numberOrZero(exercise.count) > 0) {
    logs.push("Movement was logged, so the routine includes activity.");
  }
  if (numberOrZero(doses.count) > 0) {
    logs.push("Dose logging is present, which helps anchor treatment consistency.");
  }
  if (numberOrZero(symptoms.count) > 0 || numberOrZero(mood.count) > 0) {
    logs.push("Symptoms or mood were logged, which may help spot how the day felt.");
  }

  const latestWeight = weight.latestKg;
  const changeKg = weight.changeKg;
  if (typeof latestWeight === "number" && Number.isFinite(latestWeight)) {
    const changeText = typeof changeKg === "number" && Number.isFinite(changeKg)
      ? ` recent weight change of ${Math.abs(changeKg).toFixed(1)} kg`
      : "";
    logs.push(`Weight tracking provides a ${changeText || "recent"} reference point.`);
  }

  return logs.length > 0 ? logs.slice(0, 2).join(" ") : null;
}

function buildAttentionPattern(
  dataset: Record<string, unknown>,
): Record<string, unknown> | null {
  const periodType = stringOrNull(dataset.periodType);
  if (periodType === "DAY") {
    return null;
  }

  const dailyEntries = asRecordArray(dataset.daily);
  if (dailyEntries.length < 7) {
    return null;
  }

  const weeklyStats = new Map<string, {
    exerciseCount: number;
    symptomNames: Map<string, number>;
  }>();
  const symptomFrequency = new Map<string, number>();

  for (const entry of dailyEntries) {
    const dateKey = stringOrNull(entry.date);
    if (!dateKey) {
      continue;
    }

    const weekKey = weekStartKeyFromDateKey(dateKey);
    const stats = weeklyStats.get(weekKey) ?? {
      exerciseCount: 0,
      symptomNames: new Map<string, number>(),
    };

    stats.exerciseCount += numberOrZero(entry.exerciseCount);

    for (const symptomName of asStringArray(entry.symptomNames)) {
      stats.symptomNames.set(
        symptomName,
        (stats.symptomNames.get(symptomName) ?? 0) + 1,
      );
      symptomFrequency.set(
        symptomName,
        (symptomFrequency.get(symptomName) ?? 0) + 1,
      );
    }

    weeklyStats.set(weekKey, stats);
  }

  const focusSymptom = [...symptomFrequency.entries()]
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))[0]?.[0];
  if (!focusSymptom) {
    return null;
  }

  const weeks = [...weeklyStats.entries()]
    .map(([weekKey, stats]) => ({
      weekKey,
      exerciseCount: stats.exerciseCount,
      symptomCount: stats.symptomNames.get(focusSymptom) ?? 0,
    }))
    .sort((a, b) => a.weekKey.localeCompare(b.weekKey));

  const highExerciseWeeks = weeks.filter((week) => week.exerciseCount >= 3);
  const lowerExerciseWeeks = weeks.filter((week) => week.exerciseCount < 3);
  if (highExerciseWeeks.length < 2 || lowerExerciseWeeks.length === 0) {
    return null;
  }

  const highAverage = average(highExerciseWeeks.map((week) => week.symptomCount));
  const lowAverage = average(lowerExerciseWeeks.map((week) => week.symptomCount));
  const everyHighWeekLower = highExerciseWeeks.every((week) =>
    week.symptomCount < lowAverage
  );

  if (!(highAverage + 0.25 < lowAverage && everyHighWeekLower)) {
    return null;
  }

  const periodLabel = periodType === "MONTH" ? "month" : "period";

  return {
    focus: focusSymptom,
    observation:
      `Pay attention to whether ${focusSymptom} stays lower on weeks you exercise 3+ times.`,
    evidence:
      `That pattern showed up in ${highExerciseWeeks.length} of ${weeks.length} weeks this ${periodLabel}.`,
  };
}

function average(values: number[]): number {
  if (values.length === 0) {
    return 0;
  }
  return values.reduce((sum, value) => sum + value, 0) / values.length;
}

function weekStartKeyFromDateKey(dateKey: string): string {
  const parts = dateKey.split("-").map((part) => Number(part));
  if (parts.length !== 3 || parts.some((part) => Number.isNaN(part))) {
    return dateKey;
  }

  const [year, month, day] = parts;
  const utcDate = new Date(Date.UTC(year, month - 1, day));
  const weekday = utcDate.getUTCDay();
  const daysSinceMonday = weekday === 0 ? 6 : weekday - 1;
  utcDate.setUTCDate(utcDate.getUTCDate() - daysSinceMonday);
  return `${utcDate.getUTCFullYear().toString().padStart(4, "0")}-${(utcDate.getUTCMonth() + 1)
    .toString()
    .padStart(2, "0")}-${utcDate.getUTCDate().toString().padStart(2, "0")}`;
}

const promptPrefix = `Generate a short "Today’s Journey Insight" card for a GLP-1 / metabolic health tracker app.

The user may have logged some combination of water, meals, medication, symptoms, weight, movement, or mood in the selected window. The card should make the user feel rewarded, supported, and more aware of how today’s actions matter to their health journey.

Inputs are provided as JSON:
- "logs_today" represents the selected insight window.
- "active_goals" lists the user’s currently enabled goals.
- "goal_progress" shows progress toward those goals.
- "journey_stage" is a short stage label.
- "recent_pattern" is an optional short pattern summary.
- "attention_pattern" is an optional evidence-backed signal about what the user should pay attention to next.
- "tone" is warm, calm, encouraging, non-judgmental, precise.

Write a concise insight in markdown.

Formatting rules:
- Prefer 1 short paragraph when there is a single takeaway.
- Use bullets when there are 2-4 distinct observations or actions.
- Keep each bullet to one sentence.
- Keep the response scannable and short.
- Do not force a strict word limit if it would make the insight unclear.

The card must:
1. Positively acknowledge what the user logged.
2. Explain why that logging matters to the user’s journey.
3. Include one useful insight based on their logs and goals.
4. Call out one thing the user should pay attention to next when the data supports a repeatable pattern.
5. Suggest one gentle next step only if helpful.
6. Avoid medical claims, diagnosis, shame, pressure, or generic praise.
7. If "attention_pattern" is present, weave it into the summary naturally as an observed pattern, not a diagnosis or causal claim.
8. Use markdown bullets when that improves readability.

Do not say:
- "Glu needs this data"
- "Complete your goals"
- "You failed"
- "You should"
- "Crush your goals"
- "Don’t break your streak"

Preferred language:
- "You’re building..."
- "This helps you see..."
- "Worth noticing..."
- "One small next step..."
- "Keep going with..."
- "Your logs suggest..."
- "This can help you understand..."
- "Pay attention to..."

Example:
- "Pay attention to whether nausea stays lower on weeks you exercise 3+ times."

Output only the card copy.`;

const systemPrompt = `You are a careful health-tracker insight writer.

Return JSON only.

The JSON response must contain a single short summary under the key "summary".

The summary must follow the prompt exactly:
- markdown is allowed
- prefer a short paragraph unless bullets make the insight easier to scan
- do not force a hard word count
- warm, calm, encouraging, non-judgmental, precise
- no medical claims
- acknowledge the user’s logs, explain why they matter, add one useful insight, call out what they should pay attention to next when the data supports it, and include one gentle next step only if helpful
- keep the output concise and readable

Never output anything except valid JSON.`;

function profileSnapshot(profile: RecordsRow): Record<string, unknown> {
  const settings = normalizeRecordObject(profile.settings);
  const goal = normalizeRecordObject(profile.goals);
  return {
    timezone: stringOrNull(profile.timezone),
    subscriptionTier: stringOrNull(profile.subscription_tier),
    preferredName: stringOrNull(settings.preferred_name),
    primaryGoal: stringOrNull(settings.primary_goal),
    medicationStatus: stringOrNull(settings.medication_status),
    medicationMethod: stringOrNull(settings.medication_method),
    medicationName: stringOrNull(settings.medication_name),
    currentDoseMg: numberOrNull(settings.current_dose_mg),
    age: numberOrNull(settings.age),
    gender: stringOrNull(settings.gender),
    height: normalizeUnknownValue(settings.height),
    weight: normalizeUnknownValue(settings.weight),
    goals: goal,
  };
}

function goalSnapshot(
  profile: RecordsRow,
  metrics: {
    mealTotals: ReturnType<typeof summarizeMeals>;
    waterTotals: ReturnType<typeof summarizeWater>;
    exerciseTotals: ReturnType<typeof summarizeExercise>;
    weightSummary: ReturnType<typeof summarizeWeight>;
    window: TimeWindow;
  },
): Record<string, unknown> {
  const goals = normalizeRecordObject(profile.goals);
  return {
    water: goalEntrySnapshot(
      goals.water,
      metrics.waterTotals.totalMl,
      "ml",
    ),
    exercise: goalEntrySnapshot(
      goals.exercise,
      metrics.exerciseTotals.totalMinutes,
      "minutes",
    ),
    meals: mealGoalSnapshot(goals.meals, metrics.mealTotals),
    protein: goalEntrySnapshot(
      goals.protein,
      metrics.mealTotals.totalProteinGrams,
      "grams",
    ),
    fiber: goalEntrySnapshot(
      goals.fiber,
      metrics.mealTotals.totalFiberGrams,
      "grams",
    ),
    weight: weightGoalSnapshot(goals.weight, metrics.weightSummary),
  };
}

function goalEntrySnapshot(
  rawGoal: unknown,
  achievedValue: number,
  unitLabel: string,
): Record<string, unknown> | null {
  const goal = normalizeRecordObject(rawGoal);
  const enabled = goal.enabled !== false;
  const history = asRecordArray(goal.history);
  const current = history.at(-1) ?? null;
  if (!enabled || current == null) {
    return {
      enabled,
      current: current ?? null,
      achievedValue: roundOne(achievedValue),
    };
  }

  const target =
    numberOrNull(current.target_ml) ??
      numberOrNull(current.target_minutes) ??
      numberOrNull(current.target_grams) ??
      numberOrNull(current.target_value) ??
      numberOrNull(current.targetKg) ??
      numberOrNull(current.target_kg);

  const progress = typeof target === "number" && target > 0
    ? Math.min(achievedValue / target, 1)
    : null;

  return {
    enabled,
    timeframe: stringOrNull(current.timeframe),
    current,
    achievedValue: roundOne(achievedValue),
    unit: unitLabel,
    target,
    progress,
  };
}

function mealGoalSnapshot(rawGoal: unknown, mealTotals: ReturnType<typeof summarizeMeals>) {
  const goal = normalizeRecordObject(rawGoal);
  const enabled = goal.enabled !== false;
  const history = asRecordArray(goal.history);
  const current = history.at(-1) ?? null;
  if (!enabled || current == null) {
    return {
      enabled,
      current: current ?? null,
      achievedMeals: mealTotals.count,
      achievedCalories: roundOne(mealTotals.totalCalories),
    };
  }

  const mode = stringOrNull(current.mode);
  const targetValue = numberOrNull(current.target_value);
  const achievedValue = mode === "calories"
    ? mealTotals.totalCalories
    : mealTotals.count;
  const progress = typeof targetValue === "number" && targetValue > 0
    ? Math.min(achievedValue / targetValue, 1)
    : null;

  return {
    enabled,
    timeframe: stringOrNull(current.timeframe),
    mode,
    current,
    achievedValue: roundOne(achievedValue),
    targetValue,
    progress,
  };
}

function weightGoalSnapshot(
  rawGoal: unknown,
  weightSummary: ReturnType<typeof summarizeWeight>,
) {
  const goal = normalizeRecordObject(rawGoal);
  const enabled = goal.enabled !== false;
  const history = asRecordArray(goal.history);
  const current = history.at(-1) ?? null;
  if (!enabled || current == null) {
    return {
      enabled,
      current: current ?? null,
      latestWeightKg: weightSummary.latestKg,
      changeKg: weightSummary.changeKg,
    };
  }

  const targetKg = numberOrNull(current.target_kg);
  const progress =
    typeof targetKg === "number" && targetKg > 0 && weightSummary.latestKg != null
      ? Math.min(weightSummary.latestKg / targetKg, 1)
      : null;

  return {
    enabled,
    timeframe: stringOrNull(current.timeframe),
    current,
    latestWeightKg: weightSummary.latestKg,
    changeKg: weightSummary.changeKg,
    targetKg,
    progress,
  };
}

function summarizeMeals(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  const topNames = new Map<string, number>();
  let totalCalories = 0;
  let totalCarbs = 0;
  let totalProtein = 0;
  let totalFats = 0;
  let totalFiber = 0;
  let noteCount = 0;

  for (const entry of entries) {
    const factor = consumedFactor(entry.consumed);
    const calories = numberOrZero(entry.calories) * factor;
    const carbs = numberOrZero(entry.carbs) * factor;
    const proteins = numberOrZero(entry.proteins) * factor;
    const fats = numberOrZero(entry.fats) * factor;
    const fiber = numberOrZero(entry.fiber) * factor;
    const dateKey = dateKeyForEntry(entry, offsetMinutes);

    totalCalories += calories;
    totalCarbs += carbs;
    totalProtein += proteins;
    totalFats += fats;
    totalFiber += fiber;
    if (stringOrNull(entry.notes)) {
      noteCount += 1;
    }

    if (dateKey) {
      const bucket = buckets.find((item) => item.date === dateKey);
      if (bucket) {
        bucket.mealCount += 1;
        bucket.mealCalories += calories;
      }
    }

    const name = normalizeMealName(entry.name);
    if (name) {
      topNames.set(name, (topNames.get(name) ?? 0) + 1);
    }
  }

  return {
    count: entries.length,
    totalCalories: roundOne(totalCalories),
    totalCarbsGrams: roundOne(totalCarbs),
    totalProteinGrams: roundOne(totalProtein),
    totalFatGrams: roundOne(totalFats),
    totalFiberGrams: roundOne(totalFiber),
    noteCount,
    topNames: topCounts(topNames),
  };
}

function summarizeWater(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  let totalMl = 0;
  for (const entry of entries) {
    const quantity = numberOrZero(entry.quantity);
    totalMl += quantity;
    const dateKey = dateKeyForEntry(entry, offsetMinutes);
    if (!dateKey) continue;
    const bucket = buckets.find((item) => item.date === dateKey);
    if (bucket) {
      bucket.waterMl += quantity;
    }
  }
  return { count: entries.length, totalMl: roundOne(totalMl) };
}

function summarizeExercise(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  let totalMinutes = 0;
  const intensity = new Map<string, number>();
  for (const entry of entries) {
    const minutes = numberOrZero(entry.duration_minutes);
    totalMinutes += minutes;
    const dateKey = dateKeyForEntry(entry, offsetMinutes);
    if (dateKey) {
      const bucket = buckets.find((item) => item.date === dateKey);
      if (bucket) {
        bucket.exerciseMinutes += minutes;
        bucket.exerciseCount += 1;
      }
    }
    const currentIntensity = stringOrNull(entry.intensity);
    if (currentIntensity) {
      intensity.set(
        currentIntensity,
        (intensity.get(currentIntensity) ?? 0) + 1,
      );
    }
  }
  return {
    count: entries.length,
    totalMinutes: roundOne(totalMinutes),
    intensityCounts: topCounts(intensity),
  };
}

function summarizeWeight(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  const sorted = [...entries].sort((a, b) =>
    (stringOrNull(a.logged_at) ?? "").localeCompare(stringOrNull(b.logged_at) ?? "")
  );
  const latest = sorted.at(-1);
  const earliest = sorted[0];
  let latestKg: number | null = null;
  let changeKg: number | null = null;

  if (latest) {
    latestKg = weightToKg(latest.quantity, latest.unit);
  }
  if (latest && earliest) {
    changeKg = weightToKg(latest.quantity, latest.unit) -
      weightToKg(earliest.quantity, earliest.unit);
  }

  for (const entry of entries) {
    const dateKey = dateKeyForEntry(entry, offsetMinutes);
    if (!dateKey) continue;
    const bucket = buckets.find((item) => item.date === dateKey);
    if (bucket) {
      bucket.weight += 1;
    }
  }

  return {
    count: entries.length,
    latestKg: latestKg == null ? null : roundOne(latestKg),
    changeKg: changeKg == null ? null : roundOne(changeKg),
    latestEntry: latest ? normalizeUnknownValue(latest) : null,
  };
}

function summarizeSymptoms(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  const symptomCounts = new Map<string, number>();
  const severityCounts = new Map<string, number>();
  for (const entry of entries) {
    const dateKey = dateKeyForEntry(entry, offsetMinutes);
    if (dateKey) {
      const bucket = buckets.find((item) => item.date === dateKey);
      if (bucket) {
        bucket.symptoms += 1;
        bucket.symptomNames.push(...asStringArray(entry.symptoms));
      }
    }
    const severity = stringOrNull(entry.severity);
    if (severity) {
      severityCounts.set(severity, (severityCounts.get(severity) ?? 0) + 1);
    }
    const symptoms = asStringArray(entry.symptoms);
    for (const symptom of symptoms) {
      symptomCounts.set(symptom, (symptomCounts.get(symptom) ?? 0) + 1);
    }
  }
  return {
    count: entries.length,
    severityCounts: topCounts(severityCounts),
    symptomCounts: topCounts(symptomCounts),
  };
}

function summarizeMood(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  const feelingCounts = new Map<string, number>();
  for (const entry of entries) {
    const dateKey = dateKeyForEntry(entry, offsetMinutes);
    if (dateKey) {
      const bucket = buckets.find((item) => item.date === dateKey);
      if (bucket) {
        bucket.mood += 1;
      }
    }
    const feeling = stringOrNull(entry.feeling);
    if (feeling) {
      feelingCounts.set(feeling, (feelingCounts.get(feeling) ?? 0) + 1);
    }
  }
  return {
    count: entries.length,
    feelingCounts: topCounts(feelingCounts),
  };
}

function summarizeDoses(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  const methodCounts = new Map<string, number>();
  const medicationCounts = new Map<string, number>();
  for (const entry of entries) {
    const dateKey = dateKeyForEntry(entry, offsetMinutes);
    if (dateKey) {
      const bucket = buckets.find((item) => item.date === dateKey);
      if (bucket) {
        bucket.doses += 1;
      }
    }
    const method = stringOrNull(entry.method);
    if (method) {
      methodCounts.set(method, (methodCounts.get(method) ?? 0) + 1);
    }
    const medication = stringOrNull(entry.medication);
    if (medication) {
      medicationCounts.set(
        medication,
        (medicationCounts.get(medication) ?? 0) + 1,
      );
    }
  }
  return {
    count: entries.length,
    methodCounts: topCounts(methodCounts),
    medicationCounts: topCounts(medicationCounts),
  };
}

function summarizeSupplements(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  const nameCounts = new Map<string, number>();
  for (const entry of entries) {
    const dateKey = dateKeyForEntry(entry, offsetMinutes);
    if (dateKey) {
      const bucket = buckets.find((item) => item.date === dateKey);
      if (bucket) {
        bucket.supplements += 1;
      }
    }
    const name = normalizeSupplementName(entry);
    if (name) {
      nameCounts.set(name, (nameCounts.get(name) ?? 0) + 1);
    }
  }
  return {
    count: entries.length,
    names: topCounts(nameCounts),
  };
}

function summarizeGlowup(
  entries: RecordsRow[],
  buckets: DailyBucket[],
  offsetMinutes: number,
) {
  for (const entry of entries) {
    const dateKey = dateKeyForEntry(entry, offsetMinutes);
    if (dateKey) {
      const bucket = buckets.find((item) => item.date === dateKey);
      if (bucket) {
        bucket.glowup += 1;
      }
    }
  }
  return { count: entries.length };
}

function createDailyBuckets(window: TimeWindow): DailyBucket[] {
  const buckets: DailyBucket[] = [];
  let current = new Date(window.startMs);
  while (current.getTime() < window.endMs) {
    buckets.push({
      date: formatDateKey(current.getTime(), window.offsetMinutes),
      mealCount: 0,
      mealCalories: 0,
      waterMl: 0,
      exerciseMinutes: 0,
      exerciseCount: 0,
      doses: 0,
      supplements: 0,
      symptoms: 0,
      symptomNames: [],
      mood: 0,
      weight: 0,
      glowup: 0,
    });
    current = new Date(current.getTime() + 24 * 60 * 60 * 1000);
  }
  return buckets;
}

function filterEntries(entries: unknown, window: TimeWindow): RecordsRow[] {
  return asRecordArray(entries).filter((entry) => {
    const timestamp = entryTimestamp(entry);
    return timestamp != null &&
      timestamp >= window.startMs &&
      timestamp < window.endMs;
  });
}

function entryTimestamp(entry: RecordsRow): number | null {
  for (const key of ["logged_at", "saved_at", "created_at"]) {
    const value = entry[key];
    if (typeof value !== "string" || !isIsoWithTimezone(value)) {
      continue;
    }
    const parsed = Date.parse(value);
    if (!Number.isNaN(parsed)) {
      return parsed;
    }
  }
  return null;
}

function dateKeyForEntry(entry: RecordsRow, offsetMinutes: number): string | null {
  const timestamp = entryTimestamp(entry);
  if (timestamp == null) {
    return null;
  }
  return formatDateKey(timestamp, offsetMinutes);
}

function normalizeProfile(profile: RecordsRow): RecordsRow {
  return normalizeRecordObject(profile);
}

function normalizeRecords(records: RecordsRow): RecordsRow {
  return {
    water: asRecordArray(records.water),
    exercise: asRecordArray(records.exercise),
    weight: asRecordArray(records.weight),
    meals: asRecordArray(records.meals),
    symptoms: asRecordArray(records.symptoms),
    mood: asRecordArray(records.mood),
    glowup: asRecordArray(records.glowup),
    supplements: asRecordArray(records.supplements),
    doses: asRecordArray(records.doses),
  };
}

function normalizeRecordObject(value: unknown): RecordsRow {
  return value && typeof value === "object" && !Array.isArray(value)
    ? { ...(value as RecordsRow) }
    : {};
}

function asRecordArray(value: unknown): RecordsRow[] {
  return Array.isArray(value)
    ? value.map((entry) =>
      entry && typeof entry === "object" && !Array.isArray(entry)
        ? { ...(entry as RecordsRow) }
        : {}
    )
    : [];
}

function asStringArray(value: unknown): string[] {
  return Array.isArray(value)
    ? value.filter((entry): entry is string =>
      typeof entry === "string" && entry.trim().length > 0
    )
    : [];
}

function normalizeUnknownValue(value: unknown): unknown {
  if (Array.isArray(value)) {
    return value.map((entry) => normalizeUnknownValue(entry));
  }
  if (value && typeof value === "object") {
    return Object.fromEntries(
      Object.entries(value as Record<string, unknown>).map(([key, entry]) => [
        key,
        normalizeUnknownValue(entry),
      ]),
    );
  }
  return value;
}

function normalizeMealName(value: unknown): string | null {
  const name = stringOrNull(value);
  if (name) {
    return name;
  }
  return null;
}

function normalizeSupplementName(entry: RecordsRow): string | null {
  const candidates = [
    entry.name,
    entry.title,
    entry.label,
    entry.medication,
    entry.supplement,
    entry.item,
  ];
  for (const candidate of candidates) {
    const value = stringOrNull(candidate);
    if (value) {
      return value;
    }
  }
  return null;
}

function topCounts(counts: Map<string, number>): Array<{ key: string; count: number }> {
  return [...counts.entries()]
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .slice(0, 5)
    .map(([key, count]) => ({ key, count }));
}

function roundOne(value: number): number {
  return Math.round(value * 10) / 10;
}

function stringOrNull(value: unknown): string | null {
  return typeof value === "string" && value.trim().length > 0
    ? value.trim()
    : null;
}

function numberOrNull(value: unknown): number | null {
  return typeof value === "number" && Number.isFinite(value) ? value : null;
}

function numberOrZero(value: unknown): number {
  return typeof value === "number" && Number.isFinite(value) ? value : 0;
}

function consumedFactor(value: unknown): number {
  const consumed = typeof value === "number" && Number.isFinite(value)
    ? value
    : 1;
  return Math.min(Math.max(consumed, 0), 1);
}

function weightToKg(quantity: unknown, unit: unknown): number {
  const qty = numberOrZero(quantity);
  const unitValue = stringOrNull(unit) ?? "kg";
  return unitValue === "lb" ? qty / 2.20462 : qty;
}

function parseTimezoneOffsetMinutes(value: string): number {
  if (value.endsWith("Z")) {
    return 0;
  }
  const match = value.match(/([+-])(\d{2}):(\d{2})$/);
  if (!match) {
    throw new AiProviderError("google", "currentTimestamp must include a timezone offset.");
  }
  const sign = match[1] === "-" ? -1 : 1;
  const hours = Number(match[2]);
  const minutes = Number(match[3]);
  return sign * (hours * 60 + minutes);
}

function isIsoWithTimezone(value: string): boolean {
  return isoWithTimezonePattern.test(value) && !Number.isNaN(Date.parse(value));
}

function formatOffsetLabel(offsetMinutes: number): string {
  if (offsetMinutes === 0) {
    return "+00:00";
  }
  const sign = offsetMinutes < 0 ? "-" : "+";
  const absolute = Math.abs(offsetMinutes);
  const hours = Math.floor(absolute / 60).toString().padStart(2, "0");
  const minutes = (absolute % 60).toString().padStart(2, "0");
  return `${sign}${hours}:${minutes}`;
}

type LocalParts = {
  year: number;
  month: number;
  day: number;
  hour: number;
  minute: number;
  second: number;
  millisecond: number;
};

function toLocalParts(instantMs: number, offsetMinutes: number): LocalParts {
  const shifted = new Date(instantMs + offsetMinutes * 60_000);
  return {
    year: shifted.getUTCFullYear(),
    month: shifted.getUTCMonth() + 1,
    day: shifted.getUTCDate(),
    hour: shifted.getUTCHours(),
    minute: shifted.getUTCMinutes(),
    second: shifted.getUTCSeconds(),
    millisecond: shifted.getUTCMilliseconds(),
  };
}

function localPartsToUtcMs(parts: LocalParts, offsetMinutes: number): number {
  return Date.UTC(
    parts.year,
    parts.month - 1,
    parts.day,
    parts.hour,
    parts.minute,
    parts.second,
    parts.millisecond,
  ) - offsetMinutes * 60_000;
}

function addDaysLocal(parts: LocalParts, days: number): LocalParts {
  const shifted = new Date(Date.UTC(
    parts.year,
    parts.month - 1,
    parts.day,
    parts.hour,
    parts.minute,
    parts.second,
    parts.millisecond,
  ));
  shifted.setUTCDate(shifted.getUTCDate() + days);
  return {
    year: shifted.getUTCFullYear(),
    month: shifted.getUTCMonth() + 1,
    day: shifted.getUTCDate(),
    hour: shifted.getUTCHours(),
    minute: shifted.getUTCMinutes(),
    second: shifted.getUTCSeconds(),
    millisecond: shifted.getUTCMilliseconds(),
  };
}

function weekdayFromDateParts(year: number, month: number, day: number): number {
  return new Date(Date.UTC(year, month - 1, day)).getUTCDay();
}

function formatIsoWithOffset(parts: LocalParts, offsetLabel: string): string {
  const datePart = `${parts.year.toString().padStart(4, "0")}-${parts.month
    .toString()
    .padStart(2, "0")}-${parts.day.toString().padStart(2, "0")}`;
  const timePart = `${parts.hour.toString().padStart(2, "0")}:${parts.minute
    .toString()
    .padStart(2, "0")}:${parts.second.toString().padStart(2, "0")}`;
  const fractional = parts.millisecond > 0
    ? `.${parts.millisecond.toString().padStart(3, "0")}`
    : "";
  return `${datePart}T${timePart}${fractional}${offsetLabel}`;
}

function formatDateKey(instantMs: number, offsetMinutes: number): string {
  const local = toLocalParts(instantMs, offsetMinutes);
  return `${local.year.toString().padStart(4, "0")}-${local.month
    .toString()
    .padStart(2, "0")}-${local.day.toString().padStart(2, "0")}`;
}
