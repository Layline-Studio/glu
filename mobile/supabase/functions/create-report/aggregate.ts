// Pure aggregation: daily series, medication-level model, adherence, BMI,
// summary stats. Semantics mirror the app (lib/screens/progress/progress_support.dart
// and lib/models/medication_level_estimate.dart) so charts match what the
// patient sees in the app.

import {
  CravingEntry,
  DoseEntry,
  ExerciseEntry,
  MealEntry,
  MoodEntry,
  NormalizedRecords,
  PatientProfile,
  ReportWindow,
  SymptomEntry,
  WaterEntry,
  WeightEntry,
  dayKey,
} from "./data.ts";

// --- Day-indexed series builders ---

function dayIndexOf(
  instant: Date,
  window: ReportWindow,
  indexByKey: Map<string, number>,
): number | null {
  const index = indexByKey.get(dayKey(instant, window.timeZone));
  return index === undefined ? null : index;
}

export function buildDayIndex(window: ReportWindow): Map<string, number> {
  const map = new Map<string, number>();
  window.dayKeys.forEach((key, index) => map.set(key, index));
  return map;
}

/** Latest value logged each day; null on empty days (weight semantics). */
export function latestPerDay<T extends { loggedAt: Date }>(
  entries: T[],
  window: ReportWindow,
  valueOf: (entry: T) => number,
): (number | null)[] {
  const indexByKey = buildDayIndex(window);
  const values: (number | null)[] = new Array(window.dayKeys.length).fill(null);
  for (const entry of entries) {
    const index = dayIndexOf(entry.loggedAt, window, indexByKey);
    if (index != null) values[index] = valueOf(entry);
  }
  return values;
}

/** Daily sums; zero on empty days. */
export function sumPerDay<T extends { loggedAt: Date }>(
  entries: T[],
  window: ReportWindow,
  valueOf: (entry: T) => number,
): number[] {
  const indexByKey = buildDayIndex(window);
  const values = new Array<number>(window.dayKeys.length).fill(0);
  for (const entry of entries) {
    const index = dayIndexOf(entry.loggedAt, window, indexByKey);
    if (index != null) values[index] += valueOf(entry);
  }
  return values;
}

/** Daily averages; null on empty days (mood semantics). */
export function averagePerDay<T extends { loggedAt: Date }>(
  entries: T[],
  window: ReportWindow,
  valueOf: (entry: T) => number,
): (number | null)[] {
  const indexByKey = buildDayIndex(window);
  const sums = new Array<number>(window.dayKeys.length).fill(0);
  const counts = new Array<number>(window.dayKeys.length).fill(0);
  for (const entry of entries) {
    const index = dayIndexOf(entry.loggedAt, window, indexByKey);
    if (index != null) {
      sums[index] += valueOf(entry);
      counts[index] += 1;
    }
  }
  return sums.map((sum, i) => (counts[i] > 0 ? sum / counts[i] : null));
}

/**
 * Trailing moving average. Faithful port of the app's movingAverageSparse,
 * including its quirk of only averaging values > 0 within the window.
 */
export function movingAverageSparse(
  values: (number | null)[],
  window = 7,
): (number | null)[] {
  if (values.length === 0) return values;
  const result: (number | null)[] = [];
  for (let i = 0; i < values.length; i++) {
    const start = Math.max(0, i - window + 1);
    const slice = values
      .slice(start, i + 1)
      .filter((v): v is number => v != null && v > 0);
    result.push(
      slice.length === 0
        ? null
        : slice.reduce((a, b) => a + b, 0) / slice.length,
    );
  }
  return result;
}

// --- Medication level model (port of MedicationLevelEstimate) ---

const DEFAULT_HALF_LIFE_HOURS = 168;

const HALF_LIFE_HOURS: Record<string, number> = {
  "zepbound": 120,
  "mounjaro": 120,
  "tirzepatide": 120,
  "wegovy": 168,
  "semaglutide": 168,
  "ozempic": 168,
  "semaglutide pill": 168,
  "wegovy pill": 168,
  "rybelsus": 168,
  "foundayo pill": 168,
  "saxenda": 13,
  "victoza": 13,
  "trulicity": 120,
  "retatrutide": 120,
};

export function normalizeMedicationName(
  medication: string | null | undefined,
): string | null {
  const trimmed = medication?.trim();
  if (!trimmed) return null;
  const stripped = trimmed
    .replaceAll("®", "")
    .replace(/\s+/g, " ")
    .trim()
    .toLowerCase();
  return stripped || null;
}

export function halfLifeHoursFor(
  medication: string | null | undefined,
): number {
  const normalized = normalizeMedicationName(medication);
  if (!normalized) return DEFAULT_HALF_LIFE_HOURS;
  return HALF_LIFE_HOURS[normalized] ?? DEFAULT_HALF_LIFE_HOURS;
}

type DoseEvent = { at: number; doseMg: number };

function decayLevel(
  amountMg: number,
  fromMs: number,
  toMs: number,
  halfLifeMs: number,
): number {
  const elapsed = toMs - fromMs;
  if (elapsed <= 0 || amountMg <= 0 || halfLifeMs <= 0) return amountMg;
  return amountMg * Math.pow(0.5, elapsed / halfLifeMs);
}

function levelAt(events: DoseEvent[], atMs: number, halfLifeMs: number): number {
  let level = 0;
  let previousAt: number | null = null;
  for (const event of events) {
    if (event.at > atMs) break;
    if (previousAt != null) {
      level = decayLevel(level, previousAt, event.at, halfLifeMs);
    }
    level += event.doseMg;
    previousAt = event.at;
  }
  if (previousAt == null) return 0;
  return decayLevel(level, previousAt, atMs, halfLifeMs);
}

export type MedicationLevelSeries = {
  medication: string;
  halfLifeHours: number;
  /** mg level sampled once per window day; null before the first dose's influence. */
  values: (number | null)[];
  currentMg: number;
  peakMg: number;
  currentPercentOfPeak: number;
  /** Day indexes (into window.dayKeys) that have at least one dose event. */
  doseDayIndexes: Map<number, number>; // index -> doseMg of last dose that day
};

export function buildMedicationLevelSeries(
  dosesForLevelCurve: DoseEntry[],
  medicationName: string | null,
  window: ReportWindow,
): MedicationLevelSeries | null {
  const targetName = medicationName?.trim() ||
    dosesForLevelCurve[dosesForLevelCurve.length - 1]?.medication || null;
  const target = normalizeMedicationName(targetName);
  if (!target || !targetName) return null;

  const relevant: DoseEvent[] = dosesForLevelCurve
    .filter((d) => normalizeMedicationName(d.medication) === target)
    .map((d) => ({ at: d.loggedAt.getTime(), doseMg: d.doseMg }))
    .sort((a, b) => a.at - b.at);
  if (relevant.length === 0) return null;

  const halfLifeHours = halfLifeHoursFor(targetName);
  const halfLifeMs = halfLifeHours * 60 * 60 * 1000;
  const days = window.dayKeys.length;
  const nowMs = window.now.getTime();
  const firstDoseAt = relevant[0].at;

  const values: (number | null)[] = [];
  for (let i = 0; i < days; i++) {
    // Sample at "now minus (days-1-i) days" — mirrors the app's daily sampling.
    const sampleAt = nowMs - (days - 1 - i) * 24 * 60 * 60 * 1000;
    values.push(sampleAt < firstDoseAt ? null : levelAt(relevant, sampleAt, halfLifeMs));
  }

  const currentMg = levelAt(relevant, nowMs, halfLifeMs);
  let peakMg = currentMg;
  // Peak across dose instants (level is maximal immediately after a dose).
  let running = 0;
  let previousAt: number | null = null;
  for (const event of relevant) {
    if (previousAt != null) {
      running = decayLevel(running, previousAt, event.at, halfLifeMs);
    }
    running += event.doseMg;
    peakMg = Math.max(peakMg, running);
    previousAt = event.at;
  }

  const indexByKey = buildDayIndex(window);
  const doseDayIndexes = new Map<number, number>();
  for (const dose of dosesForLevelCurve) {
    if (normalizeMedicationName(dose.medication) !== target) continue;
    const index = indexByKey.get(dayKey(dose.loggedAt, window.timeZone));
    if (index !== undefined) doseDayIndexes.set(index, dose.doseMg);
  }

  return {
    medication: targetName,
    halfLifeHours,
    values,
    currentMg,
    peakMg,
    currentPercentOfPeak: peakMg <= 0
      ? 0
      : Math.min(100, Math.max(0, Math.round((currentMg / peakMg) * 100))),
    doseDayIndexes,
  };
}

// --- Adherence ---

export type AdherenceStats = {
  expectedIntervalDays: number | null;
  expectedCount: number | null;
  actualCount: number;
  missedCount: number | null;
  adherencePct: number | null;
  medianActualIntervalDays: number | null;
};

export function computeAdherence(
  doses: DoseEntry[],
  profile: PatientProfile,
  window: ReportWindow,
): AdherenceStats {
  const actualCount = doses.length;
  const interval = profile.daysBetweenDoses;

  let medianActualIntervalDays: number | null = null;
  if (doses.length >= 2) {
    const gaps: number[] = [];
    for (let i = 1; i < doses.length; i++) {
      gaps.push(
        (doses[i].loggedAt.getTime() - doses[i - 1].loggedAt.getTime()) /
          (24 * 60 * 60 * 1000),
      );
    }
    gaps.sort((a, b) => a - b);
    const mid = Math.floor(gaps.length / 2);
    medianActualIntervalDays = gaps.length % 2 === 1
      ? gaps[mid]
      : (gaps[mid - 1] + gaps[mid]) / 2;
  }

  if (interval == null || interval <= 0 || actualCount === 0) {
    return {
      expectedIntervalDays: interval,
      expectedCount: null,
      actualCount,
      missedCount: null,
      adherencePct: null,
      medianActualIntervalDays,
    };
  }

  // Expected doses from the first dose in the window (or medication start if
  // it falls inside the window) through now, one per interval.
  const windowSpanDays = window.dayKeys.length;
  const firstDoseMs = doses[0].loggedAt.getTime();
  const trackedDays = Math.min(
    windowSpanDays,
    (window.now.getTime() - firstDoseMs) / (24 * 60 * 60 * 1000),
  );
  const expectedCount = Math.floor(trackedDays / interval) + 1;
  const missedCount = Math.max(0, expectedCount - actualCount);
  const adherencePct = Math.min(
    100,
    Math.round((actualCount / expectedCount) * 100),
  );

  return {
    expectedIntervalDays: interval,
    expectedCount,
    actualCount,
    missedCount,
    adherencePct,
    medianActualIntervalDays,
  };
}

// --- BMI ---

export function bmiSeries(
  weightDailyKg: (number | null)[],
  heightCm: number | null,
): (number | null)[] {
  if (heightCm == null || heightCm <= 0) {
    return new Array(weightDailyKg.length).fill(null);
  }
  const heightM = heightCm / 100;
  return weightDailyKg.map((kg) => (kg == null ? null : kg / (heightM * heightM)));
}

// --- Injection sites ---

export const INJECTION_SITE_GROUPS: Record<string, string[]> = {
  abdomen: [
    "abdomen_upper_left",
    "abdomen_upper_right",
    "abdomen_lower_right",
    "abdomen_lower_left",
  ],
  thigh: [
    "thigh_upper_left",
    "thigh_upper_right",
    "thigh_lower_right",
    "thigh_lower_left",
  ],
  arm: ["arm_upper_left", "arm_upper_right"],
  buttocks: ["buttocks_upper_left", "buttocks_upper_right"],
};

export type InjectionSiteUsage = {
  site: string;
  group: string;
  count: number;
  lastUsedAt: Date | null;
};

export function injectionSiteUsage(doses: DoseEntry[]): InjectionSiteUsage[] {
  const usage = new Map<string, { count: number; lastUsedAt: Date | null }>();
  for (const dose of doses) {
    if (!dose.injectionSite) continue;
    const existing = usage.get(dose.injectionSite) ??
      { count: 0, lastUsedAt: null };
    existing.count += 1;
    if (!existing.lastUsedAt || dose.loggedAt > existing.lastUsedAt) {
      existing.lastUsedAt = dose.loggedAt;
    }
    usage.set(dose.injectionSite, existing);
  }
  const result: InjectionSiteUsage[] = [];
  for (const [group, sites] of Object.entries(INJECTION_SITE_GROUPS)) {
    for (const site of sites) {
      const entry = usage.get(site);
      if (entry) {
        result.push({ site, group, count: entry.count, lastUsedAt: entry.lastUsedAt });
      }
    }
  }
  return result.sort((a, b) => b.count - a.count);
}

// --- Symptoms ---

export type SymptomFrequency = { symptom: string; count: number };

export function symptomFrequency(entries: SymptomEntry[]): SymptomFrequency[] {
  const counts = new Map<string, number>();
  for (const entry of entries) {
    for (const symptom of entry.symptoms) {
      counts.set(symptom, (counts.get(symptom) ?? 0) + 1);
    }
  }
  return [...counts.entries()]
    .map(([symptom, count]) => ({ symptom, count }))
    .sort((a, b) => b.count - a.count || a.symptom.localeCompare(b.symptom));
}

export type SeverityPerDay = { mild: number; moderate: number; severe: number };

export function severityStackPerDay(
  entries: SymptomEntry[],
  window: ReportWindow,
): SeverityPerDay[] {
  const indexByKey = buildDayIndex(window);
  const result: SeverityPerDay[] = window.dayKeys.map(() => ({
    mild: 0,
    moderate: 0,
    severe: 0,
  }));
  for (const entry of entries) {
    const index = indexByKey.get(dayKey(entry.loggedAt, window.timeZone));
    if (index === undefined) continue;
    // Each logged symptom value counts once at the entry's severity, matching
    // the app's frequency counting (symptoms.length per entry).
    result[index][entry.severity] += entry.symptoms.length;
  }
  return result;
}

// --- Mood ---

const MOOD_SCORES: Record<MoodEntry["feeling"], number> = {
  bad: 1,
  okay: 2,
  good: 3,
  great: 4,
};

export function moodScore(feeling: MoodEntry["feeling"]): number {
  return MOOD_SCORES[feeling];
}

export function moodDistribution(
  entries: MoodEntry[],
): Record<MoodEntry["feeling"], number> {
  const distribution = { great: 0, good: 0, okay: 0, bad: 0 };
  for (const entry of entries) distribution[entry.feeling] += 1;
  return distribution;
}

// --- Cravings ---

export type CravingTypeFrequency = { type: string; count: number };

export function cravingTypeFrequency(
  entries: CravingEntry[],
): CravingTypeFrequency[] {
  const counts = new Map<string, number>();
  for (const entry of entries) {
    counts.set(entry.type, (counts.get(entry.type) ?? 0) + 1);
  }
  return [...counts.entries()]
    .map(([type, count]) => ({ type, count }))
    .sort((a, b) => b.count - a.count || a.type.localeCompare(b.type));
}

export function cravingIntensityStackPerDay(
  entries: CravingEntry[],
  window: ReportWindow,
): SeverityPerDay[] {
  const indexByKey = buildDayIndex(window);
  const result: SeverityPerDay[] = window.dayKeys.map(() => ({
    mild: 0,
    moderate: 0,
    severe: 0,
  }));
  for (const entry of entries) {
    if (entry.intensity == null) continue;
    const index = indexByKey.get(dayKey(entry.loggedAt, window.timeZone));
    if (index === undefined) continue;
    const bucket = entry.intensity === "strong" ? "severe" : entry.intensity;
    result[index][bucket] += 1;
  }
  return result;
}

export type CravingOutcomeDistribution = {
  resisted: number;
  gaveIn: number;
  unspecified: number;
};

export function cravingOutcomeDistribution(
  entries: CravingEntry[],
): CravingOutcomeDistribution {
  const distribution: CravingOutcomeDistribution = {
    resisted: 0,
    gaveIn: 0,
    unspecified: 0,
  };
  for (const entry of entries) {
    if (entry.outcome === "resisted") distribution.resisted += 1;
    else if (entry.outcome === "gave_in") distribution.gaveIn += 1;
    else distribution.unspecified += 1;
  }
  return distribution;
}

// --- Logging consistency ---

export type LoggingConsistency = {
  daysWithAnyLog: number;
  totalDays: number;
  pctOfDays: number;
  loggedDayIndexes: Set<number>;
};

export function loggingConsistency(
  records: NormalizedRecords,
  window: ReportWindow,
): LoggingConsistency {
  const indexByKey = buildDayIndex(window);
  const loggedDayIndexes = new Set<number>();
  const allEntries: { loggedAt: Date }[][] = [
    records.weight,
    records.doses,
    records.meals,
    records.water,
    records.exercise,
    records.symptoms,
    records.mood,
    records.cravings,
  ];
  for (const list of allEntries) {
    for (const entry of list) {
      const index = indexByKey.get(dayKey(entry.loggedAt, window.timeZone));
      if (index !== undefined) loggedDayIndexes.add(index);
    }
  }
  const totalDays = window.dayKeys.length;
  return {
    daysWithAnyLog: loggedDayIndexes.size,
    totalDays,
    pctOfDays: Math.round((loggedDayIndexes.size / totalDays) * 100),
    loggedDayIndexes,
  };
}

// --- Weight summary ---

export type WeightSummary = {
  firstKg: number | null;
  lastKg: number | null;
  deltaKg: number | null;
  deltaPct: number | null;
  currentBmi: number | null;
};

export function weightSummary(
  weight: WeightEntry[],
  heightCm: number | null,
): WeightSummary {
  if (weight.length === 0) {
    return {
      firstKg: null,
      lastKg: null,
      deltaKg: null,
      deltaPct: null,
      currentBmi: null,
    };
  }
  const firstKg = weight[0].kg;
  const lastKg = weight[weight.length - 1].kg;
  const deltaKg = lastKg - firstKg;
  const deltaPct = firstKg > 0 ? (deltaKg / firstKg) * 100 : null;
  const currentBmi = heightCm != null && heightCm > 0
    ? lastKg / Math.pow(heightCm / 100, 2)
    : null;
  return { firstKg, lastKg, deltaKg, deltaPct, currentBmi };
}

// --- Simple helpers used by pages ---

export function averageOf(values: number[]): number | null {
  const positive = values.filter((v) => v > 0);
  if (positive.length === 0) return null;
  return positive.reduce((a, b) => a + b, 0) / positive.length;
}

export function daysMeetingGoal(values: number[], goal: number | null): number | null {
  if (goal == null || goal <= 0) return null;
  return values.filter((v) => v >= goal).length;
}

export type ExerciseByActivity = {
  activityType: string;
  sessions: number;
  totalMinutes: number;
  dominantIntensity: "light" | "moderate" | "intense";
};

export function exerciseByActivity(entries: ExerciseEntry[]): ExerciseByActivity[] {
  const byActivity = new Map<
    string,
    { sessions: number; totalMinutes: number; intensity: Record<string, number> }
  >();
  for (const entry of entries) {
    const existing = byActivity.get(entry.activityType) ??
      { sessions: 0, totalMinutes: 0, intensity: { light: 0, moderate: 0, intense: 0 } };
    existing.sessions += 1;
    existing.totalMinutes += entry.durationMinutes;
    existing.intensity[entry.intensity] += 1;
    byActivity.set(entry.activityType, existing);
  }
  return [...byActivity.entries()]
    .map(([activityType, stats]) => {
      const dominantIntensity = (["intense", "moderate", "light"] as const)
        .reduce((best, level) =>
          stats.intensity[level] > stats.intensity[best] ? level : best,
        "moderate" as "light" | "moderate" | "intense");
      return {
        activityType,
        sessions: stats.sessions,
        totalMinutes: stats.totalMinutes,
        dominantIntensity,
      };
    })
    .sort((a, b) => b.totalMinutes - a.totalMinutes);
}

export function effectiveCalories(meal: MealEntry): number {
  return meal.calories * meal.consumed;
}

export function effectiveProtein(meal: MealEntry): number {
  return meal.proteins * meal.consumed;
}

export function effectiveFiber(meal: MealEntry): number {
  return meal.fiber * meal.consumed;
}

export function waterMl(entry: WaterEntry): number {
  return entry.ml;
}
