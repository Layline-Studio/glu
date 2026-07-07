// Synthetic 90-day patient dataset shared by the PDF structural tests
// (pdf.test.ts) and the preview generator (preview.ts). Dates are anchored
// to `now` so the report window is always fully populated.

export const DAY_MS = 24 * 60 * 60 * 1000;

function isoDaysAgo(now: Date, daysAgo: number, hour = 12): string {
  const date = new Date(now.getTime() - daysAgo * DAY_MS);
  date.setUTCHours(hour, 0, 0, 0);
  return date.toISOString();
}

export function fullFixture(
  locale: string,
  now: Date,
): {
  profile: Record<string, unknown>;
  records: Record<string, unknown>;
} {
  const iso = (daysAgo: number, hour = 12) => isoDaysAgo(now, daysAgo, hour);

  const weight = Array.from({ length: 80 }, (_, i) => ({
    id: `w${i}`,
    logged_at: iso(89 - i, 8),
    quantity: Number((92 - i * 0.09 + Math.sin(i / 3) * 0.6).toFixed(1)),
    unit: "kg",
  }));
  const doses = Array.from({ length: 14 }, (_, i) => ({
    id: `d${i}`,
    logged_at: iso(91 - i * 7, 9),
    method: "injection",
    medication: "Ozempic ®",
    dose: i < 6 ? "0.5" : "1",
    injection_site: [
      "abdomen_upper_left",
      "abdomen_upper_right",
      "thigh_upper_left",
      "thigh_upper_right",
    ][i % 4],
    notes: i % 5 === 0 ? "Slight redness at site 💉 but fine" : null,
  }));
  const meals = Array.from({ length: 150 }, (_, i) => ({
    id: `m${i}`,
    logged_at: iso(Math.floor(i / 2), i % 2 === 0 ? 12 : 19),
    name: i % 3 === 0 ? "Chicken salad" : null,
    calories: 450 + (i % 5) * 60,
    carbs: 40,
    proteins: 28 + (i % 4) * 4,
    fats: 15,
    fiber: 6 + (i % 3),
    consumed: i % 4 === 0 ? 0.75 : 1.0,
    notes: i % 20 === 0 ? "Ate slowly, small portions helped with nausea" : null,
  }));
  const water = Array.from({ length: 200 }, (_, i) => ({
    id: `h${i}`,
    logged_at: iso(Math.floor(i / 3), 8 + (i % 3) * 4),
    quantity: 350,
    unit: "ml",
  }));
  const exercise = Array.from({ length: 40 }, (_, i) => ({
    id: `e${i}`,
    logged_at: iso(i * 2, 18),
    activity_type: i % 3 === 0 ? "Running" : "Walking",
    duration_minutes: 25 + (i % 4) * 10,
    intensity: ["light", "moderate", "intense"][i % 3],
    notes: i % 12 === 0 ? "Felt strong today" : null,
  }));
  const symptoms = Array.from({ length: 30 }, (_, i) => ({
    id: `s${i}`,
    logged_at: iso(i * 3, 14),
    symptoms: i % 4 === 0
      ? ["nausea", "fatigue"]
      : i % 4 === 1
      ? ["nausea"]
      : i % 4 === 2
      ? ["constipation", "headache"]
      : ["suppressed_appetite"],
    severity: ["mild", "moderate", "severe"][i % 3],
    notes: i % 6 === 0 ? "Worse after fatty dinner, settled by morning" : null,
  }));
  const mood = Array.from({ length: 60 }, (_, i) => ({
    id: `md${i}`,
    logged_at: iso(Math.floor(i * 1.5), 21),
    feeling: ["good", "great", "okay", "good", "bad"][i % 5],
    notes: i % 15 === 0 ? "Energy coming back 🎉" : null,
  }));
  const cravings = Array.from({ length: 25 }, (_, i) => ({
    id: `cr${i}`,
    logged_at: iso(i * 3 + 1, 16),
    type: ["general", "sweet_sugary", "salty_savory"][i % 3],
    intensity: i % 5 === 4 ? null : ["mild", "moderate", "strong"][i % 3],
    outcome: i % 4 === 3 ? null : i % 2 === 0 ? "resisted" : "gave_in",
    notes: i % 8 === 0 ? "Craving hit hard after a stressful meeting" : null,
  }));

  return {
    profile: {
      timezone: "America/New_York",
      settings: {
        preferred_name: "Alex",
        age: 41,
        gender: "female",
        height: { unit: "metric", primary: "170", secondary: null },
        weight: { primary: "84", unit: "kg" },
        medication_name: "Ozempic ®",
        current_dose_mg: "1",
        medication_method: "injection",
        medication_frequency: "weekly",
        medication_frequency_days_between_doses: 7,
        medication_started_at: iso(180),
        medication_start_weight: { primary: "95", unit: "kg" },
        app_locale: locale,
      },
      goals: {
        weight: {
          enabled: true,
          history: [
            { created_at: "2026-04-01", timeframe: "weekly", target_kg: 78, target_unit: "kg" },
          ],
        },
        water: {
          enabled: true,
          history: [{ created_at: "2026-04-01", timeframe: "daily", target_ml: 2000 }],
        },
        exercise: {
          enabled: true,
          history: [{ created_at: "2026-04-01", timeframe: "weekly", target_minutes: 210 }],
        },
        meals: {
          enabled: true,
          history: [
            { created_at: "2026-04-01", timeframe: "daily", mode: "calories", target_value: 1600 },
          ],
        },
        protein: {
          enabled: true,
          history: [{ created_at: "2026-04-01", timeframe: "daily", target_grams: 90 }],
        },
        fiber: {
          enabled: true,
          history: [{ created_at: "2026-04-01", timeframe: "daily", target_grams: 25 }],
        },
      },
    },
    records: { weight, doses, meals, water, exercise, symptoms, mood, cravings },
  };
}
