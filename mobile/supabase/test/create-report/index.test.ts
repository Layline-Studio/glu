import {
  assert,
  assertAlmostEquals,
  assertEquals,
} from "https://deno.land/std/assert/mod.ts";
import {
  buildReportWindow,
  coerceDoseMg,
  coerceNumber,
  dayKey,
  normalizeProfile,
  normalizeRecords,
} from "../../functions/create-report/data.ts";
import {
  buildMedicationLevelSeries,
  computeAdherence,
  cravingIntensityStackPerDay,
  cravingOutcomeDistribution,
  cravingTypeFrequency,
  exerciseByActivity,
  injectionSiteUsage,
  latestPerDay,
  loggingConsistency,
  movingAverageSparse,
  normalizeMedicationName,
  severityStackPerDay,
  sumPerDay,
  symptomFrequency,
  weightSummary,
} from "../../functions/create-report/aggregate.ts";

const NOW = new Date("2026-07-07T15:00:00Z");

function isoDaysAgo(days: number, hour = 12): string {
  const date = new Date(NOW.getTime() - days * 24 * 60 * 60 * 1000);
  date.setUTCHours(hour, 0, 0, 0);
  return date.toISOString();
}

// --- data.ts: coercion ---

Deno.test("coerceNumber accepts numeric strings and numbers", () => {
  assertEquals(coerceNumber("170"), 170);
  assertEquals(coerceNumber(82.5), 82.5);
  assertEquals(coerceNumber("  5.5 "), 5.5);
  assertEquals(coerceNumber("abc"), null);
  assertEquals(coerceNumber(""), null);
  assertEquals(coerceNumber(null), null);
  assertEquals(coerceNumber(Infinity), null);
});

Deno.test("coerceDoseMg parses dose strings like the app", () => {
  assertEquals(coerceDoseMg("0.25"), 0.25);
  assertEquals(coerceDoseMg("1 mg"), 1);
  assertEquals(coerceDoseMg("2.5MG"), 2.5);
  assertEquals(coerceDoseMg(5), 5);
  assertEquals(coerceDoseMg("0.26"), 0.25); // rounds to 0.05 step
  assertEquals(coerceDoseMg("abc"), null);
  assertEquals(coerceDoseMg(null), null);
});

// --- data.ts: window ---

Deno.test("buildReportWindow yields 90 distinct ascending day keys", () => {
  const window = buildReportWindow("America/New_York", NOW);
  assertEquals(window.dayKeys.length, 90);
  assertEquals(new Set(window.dayKeys).size, 90);
  for (let i = 1; i < window.dayKeys.length; i++) {
    assert(window.dayKeys[i] > window.dayKeys[i - 1]);
  }
  assertEquals(window.dayKeys[89], dayKey(NOW, "America/New_York"));
});

Deno.test("buildReportWindow spans a DST transition without gaps", () => {
  // 2026 US DST starts March 8; window ending April 1 crosses it.
  const now = new Date("2026-04-01T12:00:00-04:00");
  const window = buildReportWindow("America/New_York", now);
  assertEquals(window.dayKeys.length, 90);
  const keySet = new Set(window.dayKeys);
  assert(keySet.has("2026-03-08"));
  assert(keySet.has("2026-03-09"));
});

Deno.test("buildReportWindow falls back to UTC for invalid timezone", () => {
  const window = buildReportWindow("Not/AZone", NOW);
  assertEquals(window.timeZone, "UTC");
});

Deno.test("late-evening logs land on the correct local day", () => {
  // 23:30 in New York on July 1 is 03:30 UTC July 2.
  const instant = new Date("2026-07-02T03:30:00Z");
  assertEquals(dayKey(instant, "America/New_York"), "2026-07-01");
  assertEquals(dayKey(instant, "UTC"), "2026-07-02");
});

// --- data.ts: record normalization ---

Deno.test("normalizeRecords parses all record types with app field names", () => {
  const window = buildReportWindow("UTC", NOW);
  const records = normalizeRecords({
    weight: [
      { id: "1", logged_at: isoDaysAgo(5), quantity: 180, unit: "lb" },
      { id: "2", logged_at: isoDaysAgo(3), quantity: 81, unit: "kg" },
      { id: "x", logged_at: isoDaysAgo(2) }, // malformed: no quantity
    ],
    doses: [
      {
        id: "3",
        logged_at: isoDaysAgo(7),
        method: "injection",
        medication: "Ozempic ®",
        dose: "0.5",
        injection_site: "abdomen_upper_left",
        notes: "slight bruise",
      },
    ],
    meals: [
      {
        id: "4",
        logged_at: isoDaysAgo(1),
        calories: 600,
        carbs: 50,
        proteins: 30,
        fats: 20,
        fiber: 8,
        consumed: 0.5,
      },
    ],
    water: [{ id: "5", logged_at: isoDaysAgo(1), quantity: 500, unit: "ml" }],
    exercise: [
      {
        id: "6",
        logged_at: isoDaysAgo(2),
        activity_type: "walking",
        duration_minutes: 30,
        intensity: "light",
      },
    ],
    symptoms: [
      {
        id: "7",
        logged_at: isoDaysAgo(4),
        symptoms: ["nausea", "fatigue"],
        severity: "mild",
        notes: "after dinner",
      },
    ],
    mood: [{ id: "8", logged_at: isoDaysAgo(1), feeling: "good" }],
    cravings: [
      {
        id: "9",
        logged_at: isoDaysAgo(1),
        type: "sweet_sugary",
        intensity: "strong",
        outcome: "gave_in",
        notes: "office birthday cake",
      },
    ],
  }, window);

  assertEquals(records.weight.length, 2);
  assertAlmostEquals(records.weight[0].kg, 81.646, 0.01); // 180 lb
  assertEquals(records.weight[1].kg, 81);
  assertEquals(records.doses.length, 1);
  assertEquals(records.doses[0].doseMg, 0.5);
  assertEquals(records.doses[0].medication, "Ozempic ®");
  assertEquals(records.doses[0].injectionSite, "abdomen_upper_left");
  assertEquals(records.doses[0].notes, "slight bruise");
  assertEquals(records.meals[0].consumed, 0.5);
  assertEquals(records.water[0].ml, 500);
  assertEquals(records.exercise[0].activityType, "walking");
  assertEquals(records.symptoms[0].symptoms, ["nausea", "fatigue"]);
  assertEquals(records.mood[0].feeling, "good");
  assertEquals(records.cravings.length, 1);
  assertEquals(records.cravings[0].type, "sweet_sugary");
  assertEquals(records.cravings[0].intensity, "strong");
  assertEquals(records.cravings[0].outcome, "gave_in");
  assertEquals(records.cravings[0].notes, "office birthday cake");
});

Deno.test("normalizeRecords filters entries outside the 90-day window", () => {
  const window = buildReportWindow("UTC", NOW);
  const records = normalizeRecords({
    weight: [
      { id: "1", logged_at: isoDaysAgo(100), quantity: 90, unit: "kg" },
      { id: "2", logged_at: isoDaysAgo(10), quantity: 85, unit: "kg" },
    ],
    doses: [
      // Outside window but inside level-curve lookback:
      {
        id: "3",
        logged_at: isoDaysAgo(110),
        method: "injection",
        medication: "Ozempic ®",
        dose: "0.5",
      },
      {
        id: "4",
        logged_at: isoDaysAgo(10),
        method: "injection",
        medication: "Ozempic ®",
        dose: "1",
      },
    ],
  }, window);

  assertEquals(records.weight.length, 1);
  assertEquals(records.doses.length, 1);
  assertEquals(records.dosesForLevelCurve.length, 2);
});

// --- data.ts: profile normalization ---

Deno.test("normalizeProfile coerces strings and reads goals.history", () => {
  const profile = normalizeProfile({
    timezone: "Europe/Lisbon",
    settings: {
      preferred_name: "Ana",
      age: 42,
      gender: "female",
      height: { unit: "metric", primary: "170", secondary: null },
      weight: { primary: "82", unit: "kg" },
      medication_name: "Ozempic ®",
      current_dose_mg: "1",
      medication_method: "injection",
      medication_frequency: "weekly",
      medication_frequency_days_between_doses: 7,
      medication_started_at: "2026-01-15T10:00:00Z",
      medication_start_weight: { primary: "200", unit: "lb" },
      app_locale: "pt",
    },
    goals: {
      weight: {
        enabled: true,
        history: [
          { created_at: "2026-01-01", timeframe: "weekly", target_kg: 75, target_unit: "kg" },
          { created_at: "2026-03-01", timeframe: "weekly", target_kg: 72, target_unit: "lb" },
        ],
      },
      water: {
        enabled: true,
        history: [
          { created_at: "2026-02-01", timeframe: "weekly", target_ml: 14000 },
        ],
      },
      exercise: { enabled: false, history: [{ timeframe: "daily", target_minutes: 30 }] },
    },
  });

  assertEquals(profile.preferredName, "Ana");
  assertEquals(profile.heightCm, 170);
  assertEquals(profile.currentDoseMg, 1);
  assertEquals(profile.daysBetweenDoses, 7);
  assertAlmostEquals(profile.medicationStartWeightKg!, 90.72, 0.01); // 200 lb
  assertEquals(profile.timeZone, "Europe/Lisbon");
  assertEquals(profile.appLocale, "pt");
  assertEquals(profile.goals.weightTargetKg, 72); // last history entry
  assertEquals(profile.goals.weightTargetUnit, "lb");
  assertEquals(profile.displayWeightUnit, "lb"); // follows goal target unit
  assertEquals(profile.goals.waterTargetMlDaily, 2000); // weekly ÷ 7
  assertEquals(profile.goals.exerciseTargetMinutesDaily, null); // disabled goal
});

Deno.test("normalizeProfile parses imperial height", () => {
  const profile = normalizeProfile({
    settings: {
      height: { unit: "imperial", primary: "5", secondary: "10" },
    },
  });
  assertAlmostEquals(profile.heightCm!, 177.8, 0.01);
});

// --- aggregate.ts: series ---

Deno.test("latestPerDay keeps the last value per day with null gaps", () => {
  const window = buildReportWindow("UTC", NOW);
  const values = latestPerDay(
    [
      { loggedAt: new Date(isoDaysAgo(1, 8)), kg: 80 },
      { loggedAt: new Date(isoDaysAgo(1, 20)), kg: 79.5 },
      { loggedAt: new Date(isoDaysAgo(3, 9)), kg: 81 },
    ].sort((a, b) => a.loggedAt.getTime() - b.loggedAt.getTime()),
    window,
    (e) => e.kg,
  );
  assertEquals(values[88], 79.5); // latest of the two same-day weigh-ins
  assertEquals(values[86], 81);
  assertEquals(values[87], null);
});

Deno.test("sumPerDay accumulates per local day", () => {
  const window = buildReportWindow("UTC", NOW);
  const values = sumPerDay(
    [
      { loggedAt: new Date(isoDaysAgo(2, 9)), ml: 300 },
      { loggedAt: new Date(isoDaysAgo(2, 15)), ml: 450 },
    ],
    window,
    (e) => e.ml,
  );
  assertEquals(values[87], 750);
  assertEquals(values[86], 0);
});

Deno.test("movingAverageSparse matches the app's semantics", () => {
  // Includes the app's quirk: zeros/nulls are excluded from the average.
  const values = [80, null, 78, 0, 76, null, null];
  const result = movingAverageSparse(values as (number | null)[], 3);
  assertEquals(result[0], 80);
  assertEquals(result[1], 80);
  assertAlmostEquals(result[2]!, 79, 0.0001);
  assertEquals(result[3], 78); // window [null,78,0] -> only 78 counts
  assertAlmostEquals(result[4]!, 77, 0.0001); // [78,0,76] -> (78+76)/2
  assertEquals(result[5], 76);
  assertEquals(result[6], 76);
});

// --- aggregate.ts: medication level (golden values) ---

Deno.test("medication level halves after one half-life", () => {
  const window = buildReportWindow("UTC", NOW);
  const doseAt = new Date(NOW.getTime() - 7 * 24 * 60 * 60 * 1000); // exactly 168h ago
  const series = buildMedicationLevelSeries(
    [{
      loggedAt: doseAt,
      method: "injection",
      medication: "Ozempic ®", // 168h half-life
      doseMg: 1,
      injectionSite: null,
      notes: null,
    }],
    "Ozempic ®",
    window,
  );
  assert(series);
  assertAlmostEquals(series.currentMg, 0.5, 0.001);
  assertEquals(series.halfLifeHours, 168);
  assertAlmostEquals(series.peakMg, 1, 0.001);
  // Sample at the dose instant (index 89-7) equals the freshly-taken dose:
  assertAlmostEquals(series.values[82]!, 1, 0.01);
  // One day later the level shows 24h of decay: 0.5^(24/168)
  assertAlmostEquals(series.values[83]!, Math.pow(0.5, 24 / 168), 0.01);
  assertEquals(series.values[81], null); // day before first dose
});

Deno.test("medication level accumulates repeated doses", () => {
  const window = buildReportWindow("UTC", NOW);
  const mkDose = (daysAgo: number) => ({
    loggedAt: new Date(NOW.getTime() - daysAgo * 24 * 60 * 60 * 1000),
    method: "injection" as const,
    medication: "Ozempic ®",
    doseMg: 1,
    injectionSite: null,
    notes: null,
  });
  const series = buildMedicationLevelSeries(
    [mkDose(14), mkDose(7), mkDose(0)],
    "Ozempic ®",
    window,
  );
  assert(series);
  // Level right after third dose: 1*0.5^2 + 1*0.5 + 1 = 1.75
  assertAlmostEquals(series.currentMg, 1.75, 0.001);
  assertAlmostEquals(series.peakMg, 1.75, 0.001);
  assertEquals(series.doseDayIndexes.size, 3);
});

Deno.test("medication name normalization merges label variants", () => {
  assertEquals(normalizeMedicationName("Ozempic ®"), "ozempic");
  assertEquals(normalizeMedicationName("  ozempic"), "ozempic");
  assertEquals(normalizeMedicationName("Wegovy  ®  Pill"), "wegovy pill");
  assertEquals(normalizeMedicationName(null), null);
  assertEquals(normalizeMedicationName("  "), null);
});

// --- aggregate.ts: adherence ---

Deno.test("computeAdherence counts expected vs actual doses", () => {
  const window = buildReportWindow("UTC", NOW);
  const mkDose = (daysAgo: number) => ({
    loggedAt: new Date(NOW.getTime() - daysAgo * 24 * 60 * 60 * 1000),
    method: "injection" as const,
    medication: "Ozempic ®",
    doseMg: 1,
    injectionSite: null,
    notes: null,
  });
  // Weekly schedule, first dose 28 days ago, one dose skipped (21d ago missing).
  const doses = [mkDose(28), mkDose(14), mkDose(7), mkDose(0)];
  const profile = normalizeProfile({
    settings: { medication_frequency_days_between_doses: 7 },
  });
  const stats = computeAdherence(doses, profile, window);
  assertEquals(stats.expectedCount, 5); // days 28,21,14,7,0
  assertEquals(stats.actualCount, 4);
  assertEquals(stats.missedCount, 1);
  assertEquals(stats.adherencePct, 80);
  assertEquals(stats.medianActualIntervalDays, 7);
});

Deno.test("computeAdherence returns nulls without a known interval", () => {
  const window = buildReportWindow("UTC", NOW);
  const stats = computeAdherence([], normalizeProfile({ settings: {} }), window);
  assertEquals(stats.adherencePct, null);
  assertEquals(stats.expectedCount, null);
});

// --- aggregate.ts: symptoms, sites, consistency ---

Deno.test("symptomFrequency ranks by count", () => {
  const entries = [
    { loggedAt: NOW, symptoms: ["nausea", "fatigue"], severity: "mild" as const, notes: null },
    { loggedAt: NOW, symptoms: ["nausea"], severity: "severe" as const, notes: null },
  ];
  const ranked = symptomFrequency(entries);
  assertEquals(ranked[0], { symptom: "nausea", count: 2 });
  assertEquals(ranked[1], { symptom: "fatigue", count: 1 });
});

Deno.test("severityStackPerDay counts symptom values at entry severity", () => {
  const window = buildReportWindow("UTC", NOW);
  const stacks = severityStackPerDay(
    [
      {
        loggedAt: new Date(isoDaysAgo(1)),
        symptoms: ["nausea", "fatigue"],
        severity: "moderate",
        notes: null,
      },
    ],
    window,
  );
  assertEquals(stacks[88], { mild: 0, moderate: 2, severe: 0 });
});

Deno.test("cravingTypeFrequency ranks by count", () => {
  const entries = [
    { loggedAt: NOW, type: "sweet_sugary" as const, intensity: null, outcome: null, notes: null },
    { loggedAt: NOW, type: "sweet_sugary" as const, intensity: null, outcome: null, notes: null },
    { loggedAt: NOW, type: "salty_savory" as const, intensity: null, outcome: null, notes: null },
  ];
  const ranked = cravingTypeFrequency(entries);
  assertEquals(ranked[0], { type: "sweet_sugary", count: 2 });
  assertEquals(ranked[1], { type: "salty_savory", count: 1 });
});

Deno.test("cravingIntensityStackPerDay counts craving intensities per day", () => {
  const window = buildReportWindow("UTC", NOW);
  const stacks = cravingIntensityStackPerDay(
    [
      {
        loggedAt: new Date(isoDaysAgo(1)),
        type: "general",
        intensity: "strong",
        outcome: null,
        notes: null,
      },
      {
        loggedAt: new Date(isoDaysAgo(1)),
        type: "sweet_sugary",
        intensity: null,
        outcome: null,
        notes: null,
      },
    ],
    window,
  );
  // The intensity-less entry is skipped; "strong" buckets into the severe slot.
  assertEquals(stacks[88], { mild: 0, moderate: 0, severe: 1 });
});

Deno.test("cravingOutcomeDistribution counts resisted, gave in, and unspecified", () => {
  const distribution = cravingOutcomeDistribution([
    { loggedAt: NOW, type: "general", intensity: null, outcome: "resisted", notes: null },
    { loggedAt: NOW, type: "general", intensity: null, outcome: "gave_in", notes: null },
    { loggedAt: NOW, type: "general", intensity: null, outcome: null, notes: null },
  ]);
  assertEquals(distribution, { resisted: 1, gaveIn: 1, unspecified: 1 });
});

Deno.test("injectionSiteUsage groups and ranks sites", () => {
  const mkDose = (site: string, daysAgo: number) => ({
    loggedAt: new Date(NOW.getTime() - daysAgo * 24 * 60 * 60 * 1000),
    method: "injection" as const,
    medication: "Ozempic ®",
    doseMg: 1,
    injectionSite: site,
    notes: null,
  });
  const usage = injectionSiteUsage([
    mkDose("abdomen_upper_left", 14),
    mkDose("abdomen_upper_left", 7),
    mkDose("thigh_upper_right", 0),
  ]);
  assertEquals(usage[0].site, "abdomen_upper_left");
  assertEquals(usage[0].count, 2);
  assertEquals(usage[0].group, "abdomen");
  assertEquals(usage[1].group, "thigh");
});

Deno.test("loggingConsistency counts distinct days across all features", () => {
  const window = buildReportWindow("UTC", NOW);
  const records = normalizeRecords({
    water: [{ id: "1", logged_at: isoDaysAgo(1), quantity: 500, unit: "ml" }],
    mood: [
      { id: "2", logged_at: isoDaysAgo(1), feeling: "good" },
      { id: "3", logged_at: isoDaysAgo(2), feeling: "okay" },
    ],
  }, window);
  const consistency = loggingConsistency(records, window);
  assertEquals(consistency.daysWithAnyLog, 2);
  assertEquals(consistency.totalDays, 90);
});

Deno.test("weightSummary computes delta and BMI", () => {
  const summary = weightSummary(
    [
      { loggedAt: new Date(isoDaysAgo(80)), kg: 90, unit: "kg" },
      { loggedAt: new Date(isoDaysAgo(1)), kg: 84, unit: "kg" },
    ],
    170,
  );
  assertEquals(summary.deltaKg, -6);
  assertAlmostEquals(summary.deltaPct!, -6.667, 0.01);
  assertAlmostEquals(summary.currentBmi!, 29.07, 0.01);
});

Deno.test("exerciseByActivity aggregates sessions and dominant intensity", () => {
  const mk = (
    type: string,
    minutes: number,
    intensity: "light" | "moderate" | "intense",
  ) => ({
    loggedAt: NOW,
    activityType: type,
    durationMinutes: minutes,
    intensity,
    notes: null,
  });
  const byActivity = exerciseByActivity([
    mk("walking", 30, "light"),
    mk("walking", 45, "light"),
    mk("running", 20, "intense"),
  ]);
  assertEquals(byActivity[0].activityType, "walking");
  assertEquals(byActivity[0].totalMinutes, 75);
  assertEquals(byActivity[0].dominantIntensity, "light");
  assertEquals(byActivity[1].dominantIntensity, "intense");
});

// --- i18n.ts ---

Deno.test("resolveReportLocale normalizes and falls back", async () => {
  const { resolveReportLocale } = await import(
    "../../functions/create-report/i18n.ts"
  );
  assertEquals(resolveReportLocale("pt-BR"), "pt");
  assertEquals(resolveReportLocale("zh_CN"), "zh");
  assertEquals(resolveReportLocale("ar"), "en"); // RTL fallback
  assertEquals(resolveReportLocale("hi"), "en");
  assertEquals(resolveReportLocale(null), "en");
  assertEquals(resolveReportLocale("xx"), "en");
});

Deno.test("every locale covers every string key", async () => {
  const { STRINGS } = await import("../../functions/create-report/i18n.ts");
  // Locale-independent symbols served by the English fallback:
  const universal = new Set(["common.na"]);
  const enKeys = Object.keys(STRINGS.en).sort();
  for (const [locale, strings] of Object.entries(STRINGS)) {
    const missing = enKeys.filter(
      (key) => !(key in strings) && !universal.has(key),
    );
    assertEquals(missing, [], `locale ${locale} missing keys`);
  }
});

Deno.test("makeT interpolates params and falls back per-key", async () => {
  const { makeT } = await import("../../functions/create-report/i18n.ts");
  const t = makeT("pt");
  assertEquals(t("report.page", { n: 2, total: 8 }), "Página 2 de 8");
  assertEquals(t("summary.years", { n: 42 }), "42 anos");
});

Deno.test("date/number formatters honor locale and timezone", async () => {
  const { makeDateFmt, makeNumFmt } = await import(
    "../../functions/create-report/i18n.ts"
  );
  const fmt = makeDateFmt("de", "Europe/Berlin");
  const date = new Date("2026-07-07T00:30:00Z"); // 02:30 in Berlin
  assert(fmt.long(date).includes("Juli"));
  const num = makeNumFmt("de");
  assertEquals(num.n1(1234.5), "1.234,5");
});
