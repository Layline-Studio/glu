// Normalization layer: raw profiles/records JSONB -> typed, validated,
// window-filtered structures. Field names mirror the app's writers in
// mobile/lib/services/record_service.dart — entries use `logged_at`,
// doses store `dose` as a string of mg, goals arrays are `history`.

export const REPORT_WINDOW_DAYS = 90;
export const LB_PER_KG = 2.2046226218;

export type RawRecords = {
  weight?: unknown;
  doses?: unknown;
  meals?: unknown;
  water?: unknown;
  exercise?: unknown;
  symptoms?: unknown;
  mood?: unknown;
  cravings?: unknown;
};

export type RawProfile = {
  settings?: Record<string, unknown> | null;
  goals?: Record<string, unknown> | null;
  timezone?: string | null;
};

export type ReportWindow = {
  dayKeys: string[]; // 90 "YYYY-MM-DD" keys in the patient's timezone, oldest first
  timeZone: string;
  now: Date;
};

export type WeightEntry = {
  loggedAt: Date;
  kg: number;
  unit: "kg" | "lb";
};

export type DoseEntry = {
  loggedAt: Date;
  method: "injection" | "pill";
  medication: string;
  doseMg: number;
  injectionSite: string | null;
  notes: string | null;
};

export type MealEntry = {
  loggedAt: Date;
  name: string | null;
  calories: number;
  carbs: number;
  proteins: number;
  fats: number;
  fiber: number;
  consumed: number;
  notes: string | null;
};

export type WaterEntry = {
  loggedAt: Date;
  ml: number;
};

export type ExerciseEntry = {
  loggedAt: Date;
  activityType: string;
  durationMinutes: number;
  intensity: "light" | "moderate" | "intense";
  notes: string | null;
};

export type SymptomEntry = {
  loggedAt: Date;
  symptoms: string[];
  severity: "mild" | "moderate" | "severe";
  notes: string | null;
};

export type MoodEntry = {
  loggedAt: Date;
  feeling: "great" | "good" | "okay" | "bad";
  notes: string | null;
};

export type CravingEntry = {
  loggedAt: Date;
  type: "general" | "sweet_sugary" | "salty_savory";
  intensity: "mild" | "moderate" | "strong" | null;
  outcome: "resisted" | "gave_in" | null;
  notes: string | null;
};

export type NormalizedRecords = {
  weight: WeightEntry[];
  doses: DoseEntry[];
  /** Doses reaching further back than the window, for the medication-level curve. */
  dosesForLevelCurve: DoseEntry[];
  meals: MealEntry[];
  water: WaterEntry[];
  exercise: ExerciseEntry[];
  symptoms: SymptomEntry[];
  mood: MoodEntry[];
  cravings: CravingEntry[];
};

export type GoalTargets = {
  weightTargetKg: number | null;
  weightTargetUnit: "kg" | "lb";
  /** Daily reference values (weekly timeframes already divided by 7). */
  waterTargetMlDaily: number | null;
  exerciseTargetMinutesDaily: number | null;
  mealsGoalMode: "meals" | "calories" | null;
  mealsGoalDailyValue: number | null;
  proteinTargetGramsDaily: number | null;
  fiberTargetGramsDaily: number | null;
};

export type PatientProfile = {
  preferredName: string | null;
  age: number | null;
  gender: string | null;
  heightCm: number | null;
  displayWeightUnit: "kg" | "lb";
  medicationName: string | null;
  currentDoseMg: number | null;
  medicationMethod: string | null;
  medicationFrequency: string | null;
  daysBetweenDoses: number | null;
  medicationStartedAt: Date | null;
  medicationStartWeightKg: number | null;
  timeZone: string;
  appLocale: string | null;
  goals: GoalTargets;
};

// --- Primitive coercion helpers ---

export function coerceNumber(value: unknown): number | null {
  if (typeof value === "number") {
    return Number.isFinite(value) ? value : null;
  }
  if (typeof value === "string") {
    const trimmed = value.trim();
    if (!trimmed) return null;
    const parsed = Number(trimmed);
    return Number.isFinite(parsed) ? parsed : null;
  }
  return null;
}

/** Mirrors MedicationCatalog.coerceDoseValue: strips a trailing "mg", rounds to 0.05 step. */
export function coerceDoseMg(value: unknown): number | null {
  if (value == null) return null;
  const raw = String(value).trim().toLowerCase();
  const sanitized = raw.endsWith("mg") ? raw.slice(0, -2).trim() : raw;
  const numeric = Number(sanitized);
  if (!Number.isFinite(numeric)) return null;
  const rounded = Math.round(numeric / 0.05) * 0.05;
  return Number(rounded.toFixed(2));
}

function parseDate(value: unknown): Date | null {
  if (typeof value !== "string" || !value.trim()) return null;
  const parsed = new Date(value);
  return Number.isNaN(parsed.getTime()) ? null : parsed;
}

function parseNotes(value: unknown): string | null {
  if (typeof value !== "string") return null;
  const trimmed = value.trim();
  return trimmed ? trimmed : null;
}

function asArray(value: unknown): Record<string, unknown>[] {
  if (!Array.isArray(value)) return [];
  return value.filter(
    (item): item is Record<string, unknown> =>
      !!item && typeof item === "object" && !Array.isArray(item),
  );
}

// --- Day-key bucketing (timezone-aware, no external deps) ---

const dayKeyFormatters = new Map<string, Intl.DateTimeFormat>();

export function dayKey(instant: Date, timeZone: string): string {
  let formatter = dayKeyFormatters.get(timeZone);
  if (!formatter) {
    formatter = new Intl.DateTimeFormat("en-CA", {
      timeZone,
      year: "numeric",
      month: "2-digit",
      day: "2-digit",
    });
    dayKeyFormatters.set(timeZone, formatter);
  }
  return formatter.format(instant);
}

export function isValidTimeZone(timeZone: string | null | undefined): boolean {
  if (!timeZone) return false;
  try {
    new Intl.DateTimeFormat("en-CA", { timeZone });
    return true;
  } catch {
    return false;
  }
}

export function buildReportWindow(
  timeZone: string | null | undefined,
  now: Date = new Date(),
): ReportWindow {
  const tz = isValidTimeZone(timeZone) ? timeZone! : "UTC";
  const keys: string[] = [];
  const seen = new Set<string>();
  // Walk backwards in 24h UTC steps and derive local day keys; DST shifts can
  // repeat or skip an instant's key, so dedupe until 90 distinct days exist.
  let cursor = now.getTime();
  while (keys.length < REPORT_WINDOW_DAYS) {
    const key = dayKey(new Date(cursor), tz);
    if (!seen.has(key)) {
      seen.add(key);
      keys.push(key);
    }
    cursor -= 12 * 60 * 60 * 1000;
  }
  keys.reverse();
  return { dayKeys: keys, timeZone: tz, now };
}

export function isWithinWindow(instant: Date, window: ReportWindow): boolean {
  const key = dayKey(instant, window.timeZone);
  return key >= window.dayKeys[0] &&
    key <= window.dayKeys[window.dayKeys.length - 1] &&
    instant.getTime() <= window.now.getTime();
}

// --- Record parsers (skip malformed entries, never throw) ---

function parseWeight(raw: Record<string, unknown>): WeightEntry | null {
  const loggedAt = parseDate(raw.logged_at);
  const quantity = coerceNumber(raw.quantity);
  if (!loggedAt || quantity == null || quantity <= 0) return null;
  const unit = raw.unit === "lb" ? "lb" : "kg";
  return {
    loggedAt,
    unit,
    kg: unit === "lb" ? quantity / LB_PER_KG : quantity,
  };
}

function parseDose(raw: Record<string, unknown>): DoseEntry | null {
  const loggedAt = parseDate(raw.logged_at);
  const medication = typeof raw.medication === "string"
    ? raw.medication.trim()
    : "";
  const doseMg = coerceDoseMg(raw.dose);
  if (!loggedAt || !medication || doseMg == null || doseMg <= 0) return null;
  const method = raw.method === "pill" ? "pill" : "injection";
  const injectionSite = typeof raw.injection_site === "string" &&
      raw.injection_site.trim()
    ? raw.injection_site.trim()
    : null;
  return {
    loggedAt,
    method,
    medication,
    doseMg,
    injectionSite,
    notes: parseNotes(raw.notes),
  };
}

function parseMeal(raw: Record<string, unknown>): MealEntry | null {
  const loggedAt = parseDate(raw.logged_at);
  if (!loggedAt) return null;
  const calories = Math.max(0, coerceNumber(raw.calories) ?? 0);
  const carbs = Math.max(0, coerceNumber(raw.carbs) ?? 0);
  const proteins = Math.max(0, coerceNumber(raw.proteins) ?? 0);
  const fats = Math.max(0, coerceNumber(raw.fats) ?? 0);
  const fiber = Math.max(0, coerceNumber(raw.fiber) ?? 0);
  if (calories + carbs + proteins + fats + fiber <= 0) return null;
  const rawConsumed = coerceNumber(raw.consumed);
  const consumed = rawConsumed != null && rawConsumed >= 0.25 && rawConsumed <= 1
    ? rawConsumed
    : 1;
  return {
    loggedAt,
    name: parseNotes(raw.name),
    calories,
    carbs,
    proteins,
    fats,
    fiber,
    consumed,
    notes: parseNotes(raw.notes),
  };
}

function parseWater(raw: Record<string, unknown>): WaterEntry | null {
  const loggedAt = parseDate(raw.logged_at);
  const quantity = coerceNumber(raw.quantity);
  if (!loggedAt || quantity == null || quantity <= 0) return null;
  return { loggedAt, ml: quantity };
}

function parseExercise(raw: Record<string, unknown>): ExerciseEntry | null {
  const loggedAt = parseDate(raw.logged_at);
  const duration = coerceNumber(raw.duration_minutes);
  const activityType = typeof raw.activity_type === "string"
    ? raw.activity_type.trim()
    : "";
  if (!loggedAt || duration == null || duration <= 0 || !activityType) {
    return null;
  }
  const intensity = raw.intensity === "light" || raw.intensity === "intense"
    ? raw.intensity
    : "moderate";
  return {
    loggedAt,
    activityType,
    durationMinutes: duration,
    intensity,
    notes: parseNotes(raw.notes),
  };
}

function parseSymptom(raw: Record<string, unknown>): SymptomEntry | null {
  const loggedAt = parseDate(raw.logged_at);
  if (!loggedAt || !Array.isArray(raw.symptoms)) return null;
  const symptoms = raw.symptoms
    .filter((s): s is string => typeof s === "string" && !!s.trim())
    .map((s) => s.trim());
  if (symptoms.length === 0) return null;
  const severity = raw.severity === "mild" || raw.severity === "severe"
    ? raw.severity
    : "moderate";
  return { loggedAt, symptoms, severity, notes: parseNotes(raw.notes) };
}

function parseMood(raw: Record<string, unknown>): MoodEntry | null {
  const loggedAt = parseDate(raw.logged_at);
  const feeling = raw.feeling;
  if (
    !loggedAt ||
    (feeling !== "great" && feeling !== "good" && feeling !== "okay" &&
      feeling !== "bad")
  ) {
    return null;
  }
  return { loggedAt, feeling, notes: parseNotes(raw.notes) };
}

function parseCraving(raw: Record<string, unknown>): CravingEntry | null {
  const loggedAt = parseDate(raw.logged_at);
  const type = raw.type;
  if (
    !loggedAt ||
    (type !== "general" && type !== "sweet_sugary" && type !== "salty_savory")
  ) {
    return null;
  }
  const intensity = raw.intensity === "mild" || raw.intensity === "moderate" ||
      raw.intensity === "strong"
    ? raw.intensity
    : null;
  const outcome = raw.outcome === "resisted" || raw.outcome === "gave_in"
    ? raw.outcome
    : null;
  return { loggedAt, type, intensity, outcome, notes: parseNotes(raw.notes) };
}

function sortByLoggedAt<T extends { loggedAt: Date }>(entries: T[]): T[] {
  return entries.sort((a, b) => a.loggedAt.getTime() - b.loggedAt.getTime());
}

/** Extra lookback so the medication-level curve is accurate at window start (7 × longest half-life = 49d). */
export const LEVEL_CURVE_LOOKBACK_DAYS = 49;

export function normalizeRecords(
  raw: RawRecords,
  window: ReportWindow,
): NormalizedRecords {
  const parseAll = <T>(
    value: unknown,
    parse: (raw: Record<string, unknown>) => T | null,
  ): T[] =>
    asArray(value)
      .map(parse)
      .filter((entry): entry is T => entry !== null);

  const inWindow = <T extends { loggedAt: Date }>(entries: T[]): T[] =>
    sortByLoggedAt(entries.filter((e) => isWithinWindow(e.loggedAt, window)));

  const allDoses = parseAll(raw.doses, parseDose);
  const levelCurveStart = window.now.getTime() -
    (REPORT_WINDOW_DAYS - 1 + LEVEL_CURVE_LOOKBACK_DAYS) * 24 * 60 * 60 * 1000;
  const dosesForLevelCurve = sortByLoggedAt(
    allDoses.filter(
      (d) =>
        d.loggedAt.getTime() >= levelCurveStart &&
        d.loggedAt.getTime() <= window.now.getTime(),
    ),
  );

  return {
    weight: inWindow(parseAll(raw.weight, parseWeight)),
    doses: inWindow(allDoses),
    dosesForLevelCurve,
    meals: inWindow(parseAll(raw.meals, parseMeal)),
    water: inWindow(parseAll(raw.water, parseWater)),
    exercise: inWindow(parseAll(raw.exercise, parseExercise)),
    symptoms: inWindow(parseAll(raw.symptoms, parseSymptom)),
    mood: inWindow(parseAll(raw.mood, parseMood)),
    cravings: inWindow(parseAll(raw.cravings, parseCraving)),
  };
}

// --- Profile normalization ---

/** Parses a `{primary, unit}` measurement object (weight-like) into kg. */
function parseMeasurementKg(value: unknown): number | null {
  if (!value || typeof value !== "object" || Array.isArray(value)) return null;
  const measurement = value as Record<string, unknown>;
  const primary = coerceNumber(measurement.primary);
  if (primary == null || primary <= 0) return null;
  return measurement.unit === "lb" ? primary / LB_PER_KG : primary;
}

function parseHeightCm(value: unknown): number | null {
  if (!value || typeof value !== "object" || Array.isArray(value)) return null;
  const height = value as Record<string, unknown>;
  const primary = coerceNumber(height.primary);
  if (primary == null || primary <= 0) return null;
  if (height.unit === "imperial") {
    const inches = coerceNumber(height.secondary) ?? 0;
    return (primary * 12 + inches) * 2.54;
  }
  return primary;
}

function lastGoalEntry(
  goals: Record<string, unknown> | null | undefined,
  key: string,
): Record<string, unknown> | null {
  const goal = goals?.[key];
  if (!goal || typeof goal !== "object" || Array.isArray(goal)) return null;
  const goalObject = goal as Record<string, unknown>;
  if (goalObject.enabled === false) return null;
  const history = asArray(goalObject.history);
  return history.length > 0 ? history[history.length - 1] : null;
}

function dailyTarget(
  entry: Record<string, unknown> | null,
  valueKey: string,
): number | null {
  if (!entry) return null;
  const value = coerceNumber(entry[valueKey]);
  if (value == null || value <= 0) return null;
  return entry.timeframe === "weekly" ? value / 7 : value;
}

const FREQUENCY_DAY_FALLBACK: Record<string, number> = {
  daily: 1,
  weekly: 7,
};

export function normalizeProfile(raw: RawProfile): PatientProfile {
  const settings = raw.settings ?? {};
  const goals = raw.goals ?? null;

  const weightGoal = lastGoalEntry(goals, "weight");
  const weightTargetKg = weightGoal
    ? coerceNumber(weightGoal.target_kg)
    : null;
  const weightTargetUnit = weightGoal?.target_unit === "lb" ? "lb" : "kg";

  const mealsGoal = lastGoalEntry(goals, "meals");
  const mealsGoalMode = mealsGoal?.mode === "calories"
    ? "calories"
    : mealsGoal?.mode === "meals"
    ? "meals"
    : null;
  const mealsGoalValue = mealsGoal
    ? coerceNumber(mealsGoal.target_value) ??
      coerceNumber(mealsGoal.logs_per_period)
    : null;
  const mealsGoalDailyValue = mealsGoalValue != null && mealsGoalValue > 0
    ? (mealsGoal?.timeframe === "weekly" ? mealsGoalValue / 7 : mealsGoalValue)
    : null;

  const proteinGoal = lastGoalEntry(goals, "protein");
  const fiberGoal = lastGoalEntry(goals, "fiber");

  const settingsWeightKg = parseMeasurementKg(settings.weight);
  const startWeightKg = parseMeasurementKg(settings.medication_start_weight);
  let latestRecordUnit: "kg" | "lb" | null = null;
  if (
    settings.weight && typeof settings.weight === "object" &&
    !Array.isArray(settings.weight)
  ) {
    const unit = (settings.weight as Record<string, unknown>).unit;
    if (unit === "lb" || unit === "kg") latestRecordUnit = unit;
  }
  const measurementUnit = settings.measurement_unit === "lb" ? "lb" : null;

  const displayWeightUnit: "kg" | "lb" = weightGoal
    ? weightTargetUnit
    : measurementUnit ?? latestRecordUnit ?? "kg";

  const startedAt = parseDate(settings.medication_started_at);

  return {
    preferredName: parseNotes(settings.preferred_name),
    age: coerceNumber(settings.age),
    gender: parseNotes(settings.gender),
    heightCm: parseHeightCm(settings.height),
    displayWeightUnit,
    medicationName: parseNotes(settings.medication_name),
    currentDoseMg: coerceDoseMg(settings.current_dose_mg),
    medicationMethod: parseNotes(settings.medication_method),
    medicationFrequency: parseNotes(settings.medication_frequency),
    daysBetweenDoses:
      coerceNumber(settings.medication_frequency_days_between_doses) ??
        (typeof settings.medication_frequency === "string"
          ? FREQUENCY_DAY_FALLBACK[settings.medication_frequency] ?? null
          : null),
    medicationStartedAt: startedAt,
    medicationStartWeightKg: startWeightKg ?? settingsWeightKg,
    timeZone: isValidTimeZone(raw.timezone) ? raw.timezone! : "UTC",
    appLocale: parseNotes(settings.app_locale),
    goals: {
      weightTargetKg: weightTargetKg != null && weightTargetKg > 0
        ? weightTargetKg
        : null,
      weightTargetUnit,
      waterTargetMlDaily: dailyTarget(lastGoalEntry(goals, "water"), "target_ml"),
      exerciseTargetMinutesDaily: dailyTarget(
        lastGoalEntry(goals, "exercise"),
        "target_minutes",
      ),
      mealsGoalMode,
      mealsGoalDailyValue,
      proteinTargetGramsDaily: dailyTarget(proteinGoal, "target_grams") ??
        dailyTarget(proteinGoal, "target_value"),
      fiberTargetGramsDaily: dailyTarget(fiberGoal, "target_grams") ??
        dailyTarget(fiberGoal, "target_value"),
    },
  };
}
