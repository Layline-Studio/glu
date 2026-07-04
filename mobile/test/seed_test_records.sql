-- =============================================================
-- Glu — Test data seed for records table
-- Covers 60 days of data (2026-02-05 → 2026-04-06) so all
-- progress ranges (7D / 30D / 3M) have data to render.
--
-- Replace YOUR-USER-ID-HERE with your Supabase auth user UUID.
-- Run in the Supabase SQL editor or via psql.
-- =============================================================

INSERT INTO records (
  user_id,
  water,
  exercise,
  weight,
  meals,
  mood,
  symptoms,
  supplements,
  doses
)
VALUES (
  'YOUR-USER-ID-HERE',

  -- ----------------------------------------------------------------
  -- WATER  (quantity in ml)
  -- ----------------------------------------------------------------
  '[
    {"logged_at": "2026-04-06T08:15:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-04-06T12:30:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-04-06T18:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-04-05T09:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-04-05T14:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-04-05T20:00:00-03:00", "quantity": 250, "unit": "ml"},
    {"logged_at": "2026-04-04T08:30:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-04-04T13:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-04-04T19:30:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-04-03T07:45:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-04-03T12:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-04-03T17:30:00-03:00", "quantity": 250, "unit": "ml"},
    {"logged_at": "2026-04-02T08:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-04-02T13:30:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-04-01T09:15:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-04-01T15:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-03-31T08:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-03-31T14:00:00-03:00", "quantity": 250, "unit": "ml"},
    {"logged_at": "2026-03-30T09:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-03-30T18:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-03-28T08:30:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-03-28T13:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-03-26T09:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-03-26T15:30:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-03-24T08:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-03-22T10:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-03-20T09:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-03-18T08:30:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-03-15T09:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-03-12T10:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-03-08T09:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-03-04T08:00:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-02-28T09:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-02-22T08:30:00-03:00", "quantity": 350, "unit": "ml"},
    {"logged_at": "2026-02-15T09:00:00-03:00", "quantity": 500, "unit": "ml"},
    {"logged_at": "2026-02-08T10:00:00-03:00", "quantity": 350, "unit": "ml"}
  ]'::jsonb,

  -- ----------------------------------------------------------------
  -- EXERCISE
  -- ----------------------------------------------------------------
  '[
    {"logged_at": "2026-04-06T07:00:00-03:00", "activity_type": "Walking", "duration_minutes": 35, "intensity": "light"},
    {"logged_at": "2026-04-04T07:30:00-03:00", "activity_type": "Cycling", "duration_minutes": 45, "intensity": "moderate"},
    {"logged_at": "2026-04-02T06:45:00-03:00", "activity_type": "Walking", "duration_minutes": 30, "intensity": "light"},
    {"logged_at": "2026-03-31T07:00:00-03:00", "activity_type": "Strength training", "duration_minutes": 50, "intensity": "moderate"},
    {"logged_at": "2026-03-29T07:30:00-03:00", "activity_type": "Walking", "duration_minutes": 40, "intensity": "light"},
    {"logged_at": "2026-03-27T06:00:00-03:00", "activity_type": "Running", "duration_minutes": 30, "intensity": "intense"},
    {"logged_at": "2026-03-25T07:00:00-03:00", "activity_type": "Cycling", "duration_minutes": 40, "intensity": "moderate"},
    {"logged_at": "2026-03-23T07:30:00-03:00", "activity_type": "Walking", "duration_minutes": 45, "intensity": "light"},
    {"logged_at": "2026-03-21T06:45:00-03:00", "activity_type": "Strength training", "duration_minutes": 55, "intensity": "moderate"},
    {"logged_at": "2026-03-18T07:00:00-03:00", "activity_type": "Walking", "duration_minutes": 30, "intensity": "light"},
    {"logged_at": "2026-03-15T07:30:00-03:00", "activity_type": "Cycling", "duration_minutes": 35, "intensity": "moderate"},
    {"logged_at": "2026-03-12T06:00:00-03:00", "activity_type": "Running", "duration_minutes": 25, "intensity": "intense"},
    {"logged_at": "2026-03-09T07:00:00-03:00", "activity_type": "Walking", "duration_minutes": 40, "intensity": "light"},
    {"logged_at": "2026-03-05T07:30:00-03:00", "activity_type": "Strength training", "duration_minutes": 50, "intensity": "moderate"},
    {"logged_at": "2026-03-01T07:00:00-03:00", "activity_type": "Walking", "duration_minutes": 35, "intensity": "light"},
    {"logged_at": "2026-02-25T07:30:00-03:00", "activity_type": "Cycling", "duration_minutes": 40, "intensity": "moderate"},
    {"logged_at": "2026-02-20T06:45:00-03:00", "activity_type": "Walking", "duration_minutes": 30, "intensity": "light"},
    {"logged_at": "2026-02-14T07:00:00-03:00", "activity_type": "Strength training", "duration_minutes": 45, "intensity": "moderate"},
    {"logged_at": "2026-02-08T07:30:00-03:00", "activity_type": "Walking", "duration_minutes": 35, "intensity": "light"}
  ]'::jsonb,

  -- ----------------------------------------------------------------
  -- WEIGHT  (trending down: ~97kg → ~88kg over 60 days)
  -- ----------------------------------------------------------------
  '[
    {"logged_at": "2026-04-06T07:00:00-03:00", "quantity": 88.4, "unit": "kg"},
    {"logged_at": "2026-04-05T07:00:00-03:00", "quantity": 88.6, "unit": "kg"},
    {"logged_at": "2026-04-04T07:00:00-03:00", "quantity": 88.9, "unit": "kg"},
    {"logged_at": "2026-04-03T07:00:00-03:00", "quantity": 89.1, "unit": "kg"},
    {"logged_at": "2026-04-02T07:00:00-03:00", "quantity": 89.3, "unit": "kg"},
    {"logged_at": "2026-04-01T07:00:00-03:00", "quantity": 89.0, "unit": "kg"},
    {"logged_at": "2026-03-31T07:00:00-03:00", "quantity": 89.5, "unit": "kg"},
    {"logged_at": "2026-03-30T07:00:00-03:00", "quantity": 89.7, "unit": "kg"},
    {"logged_at": "2026-03-28T07:00:00-03:00", "quantity": 90.1, "unit": "kg"},
    {"logged_at": "2026-03-26T07:00:00-03:00", "quantity": 90.4, "unit": "kg"},
    {"logged_at": "2026-03-24T07:00:00-03:00", "quantity": 90.2, "unit": "kg"},
    {"logged_at": "2026-03-22T07:00:00-03:00", "quantity": 90.8, "unit": "kg"},
    {"logged_at": "2026-03-20T07:00:00-03:00", "quantity": 91.1, "unit": "kg"},
    {"logged_at": "2026-03-18T07:00:00-03:00", "quantity": 91.3, "unit": "kg"},
    {"logged_at": "2026-03-16T07:00:00-03:00", "quantity": 91.6, "unit": "kg"},
    {"logged_at": "2026-03-14T07:00:00-03:00", "quantity": 91.9, "unit": "kg"},
    {"logged_at": "2026-03-12T07:00:00-03:00", "quantity": 92.2, "unit": "kg"},
    {"logged_at": "2026-03-10T07:00:00-03:00", "quantity": 92.0, "unit": "kg"},
    {"logged_at": "2026-03-08T07:00:00-03:00", "quantity": 92.5, "unit": "kg"},
    {"logged_at": "2026-03-06T07:00:00-03:00", "quantity": 92.8, "unit": "kg"},
    {"logged_at": "2026-03-04T07:00:00-03:00", "quantity": 93.1, "unit": "kg"},
    {"logged_at": "2026-03-02T07:00:00-03:00", "quantity": 93.4, "unit": "kg"},
    {"logged_at": "2026-02-28T07:00:00-03:00", "quantity": 93.6, "unit": "kg"},
    {"logged_at": "2026-02-26T07:00:00-03:00", "quantity": 93.9, "unit": "kg"},
    {"logged_at": "2026-02-24T07:00:00-03:00", "quantity": 94.2, "unit": "kg"},
    {"logged_at": "2026-02-22T07:00:00-03:00", "quantity": 94.5, "unit": "kg"},
    {"logged_at": "2026-02-20T07:00:00-03:00", "quantity": 94.8, "unit": "kg"},
    {"logged_at": "2026-02-18T07:00:00-03:00", "quantity": 95.1, "unit": "kg"},
    {"logged_at": "2026-02-16T07:00:00-03:00", "quantity": 95.4, "unit": "kg"},
    {"logged_at": "2026-02-14T07:00:00-03:00", "quantity": 95.7, "unit": "kg"},
    {"logged_at": "2026-02-12T07:00:00-03:00", "quantity": 96.0, "unit": "kg"},
    {"logged_at": "2026-02-10T07:00:00-03:00", "quantity": 96.4, "unit": "kg"},
    {"logged_at": "2026-02-08T07:00:00-03:00", "quantity": 96.7, "unit": "kg"},
    {"logged_at": "2026-02-06T07:00:00-03:00", "quantity": 97.0, "unit": "kg"},
    {"logged_at": "2026-02-05T07:00:00-03:00", "quantity": 97.3, "unit": "kg"}
  ]'::jsonb,

  -- ----------------------------------------------------------------
  -- MEALS
  -- ----------------------------------------------------------------
  '[
    {"logged_at": "2026-04-06T08:00:00-03:00", "calories": 380, "carbs": 42, "proteins": 28, "fats": 10, "fiber": 5, "sugars": 8, "notes": "Oats with protein powder"},
    {"logged_at": "2026-04-06T13:00:00-03:00", "calories": 520, "carbs": 48, "proteins": 35, "fats": 16, "fiber": 7, "sugars": 4, "notes": "Grilled chicken salad"},
    {"logged_at": "2026-04-06T19:30:00-03:00", "calories": 610, "carbs": 55, "proteins": 40, "fats": 18, "fiber": 8, "sugars": 6},
    {"logged_at": "2026-04-05T08:30:00-03:00", "calories": 340, "carbs": 38, "proteins": 22, "fats": 9, "fiber": 4, "sugars": 10},
    {"logged_at": "2026-04-05T13:30:00-03:00", "calories": 490, "carbs": 44, "proteins": 32, "fats": 14, "fiber": 6, "sugars": 5},
    {"logged_at": "2026-04-05T20:00:00-03:00", "calories": 580, "carbs": 52, "proteins": 38, "fats": 17, "fiber": 7, "sugars": 4},
    {"logged_at": "2026-04-04T08:00:00-03:00", "calories": 420, "carbs": 46, "proteins": 30, "fats": 12, "fiber": 5, "sugars": 9},
    {"logged_at": "2026-04-04T13:00:00-03:00", "calories": 540, "carbs": 50, "proteins": 36, "fats": 15, "fiber": 6, "sugars": 3},
    {"logged_at": "2026-04-04T19:30:00-03:00", "calories": 600, "carbs": 54, "proteins": 42, "fats": 16, "fiber": 9, "sugars": 5},
    {"logged_at": "2026-04-03T08:30:00-03:00", "calories": 360, "carbs": 40, "proteins": 24, "fats": 10, "fiber": 4, "sugars": 11},
    {"logged_at": "2026-04-03T13:30:00-03:00", "calories": 510, "carbs": 46, "proteins": 34, "fats": 15, "fiber": 7, "sugars": 4},
    {"logged_at": "2026-04-02T08:00:00-03:00", "calories": 400, "carbs": 44, "proteins": 28, "fats": 11, "fiber": 5, "sugars": 8},
    {"logged_at": "2026-04-02T19:00:00-03:00", "calories": 620, "carbs": 56, "proteins": 44, "fats": 17, "fiber": 8, "sugars": 6},
    {"logged_at": "2026-04-01T08:30:00-03:00", "calories": 370, "carbs": 41, "proteins": 25, "fats": 10, "fiber": 4, "sugars": 9},
    {"logged_at": "2026-04-01T13:00:00-03:00", "calories": 500, "carbs": 45, "proteins": 33, "fats": 14, "fiber": 6, "sugars": 4},
    {"logged_at": "2026-03-30T08:00:00-03:00", "calories": 410, "carbs": 43, "proteins": 29, "fats": 12, "fiber": 5, "sugars": 7},
    {"logged_at": "2026-03-30T19:30:00-03:00", "calories": 590, "carbs": 53, "proteins": 41, "fats": 16, "fiber": 8, "sugars": 5},
    {"logged_at": "2026-03-28T13:00:00-03:00", "calories": 530, "carbs": 49, "proteins": 36, "fats": 15, "fiber": 7, "sugars": 3},
    {"logged_at": "2026-03-26T08:30:00-03:00", "calories": 385, "carbs": 42, "proteins": 27, "fats": 11, "fiber": 5, "sugars": 8},
    {"logged_at": "2026-03-24T13:00:00-03:00", "calories": 515, "carbs": 47, "proteins": 35, "fats": 14, "fiber": 6, "sugars": 4},
    {"logged_at": "2026-03-22T08:00:00-03:00", "calories": 395, "carbs": 43, "proteins": 28, "fats": 11, "fiber": 5, "sugars": 9},
    {"logged_at": "2026-03-20T19:00:00-03:00", "calories": 605, "carbs": 55, "proteins": 43, "fats": 17, "fiber": 8, "sugars": 5},
    {"logged_at": "2026-03-18T13:00:00-03:00", "calories": 485, "carbs": 44, "proteins": 33, "fats": 13, "fiber": 6, "sugars": 4},
    {"logged_at": "2026-03-15T08:30:00-03:00", "calories": 365, "carbs": 40, "proteins": 25, "fats": 10, "fiber": 4, "sugars": 10},
    {"logged_at": "2026-03-12T13:00:00-03:00", "calories": 525, "carbs": 48, "proteins": 36, "fats": 15, "fiber": 7, "sugars": 3},
    {"logged_at": "2026-03-08T08:00:00-03:00", "calories": 405, "carbs": 44, "proteins": 29, "fats": 11, "fiber": 5, "sugars": 8},
    {"logged_at": "2026-03-04T19:00:00-03:00", "calories": 595, "carbs": 54, "proteins": 42, "fats": 16, "fiber": 8, "sugars": 5},
    {"logged_at": "2026-02-28T13:00:00-03:00", "calories": 495, "carbs": 45, "proteins": 34, "fats": 14, "fiber": 6, "sugars": 4},
    {"logged_at": "2026-02-22T08:30:00-03:00", "calories": 375, "carbs": 41, "proteins": 26, "fats": 10, "fiber": 4, "sugars": 9},
    {"logged_at": "2026-02-15T13:00:00-03:00", "calories": 510, "carbs": 47, "proteins": 35, "fats": 14, "fiber": 6, "sugars": 4},
    {"logged_at": "2026-02-08T08:00:00-03:00", "calories": 390, "carbs": 43, "proteins": 27, "fats": 11, "fiber": 5, "sugars": 8}
  ]'::jsonb,

  -- ----------------------------------------------------------------
  -- MOOD
  -- ----------------------------------------------------------------
  '[
    {"logged_at": "2026-04-06T21:00:00-03:00", "feeling": "good"},
    {"logged_at": "2026-04-04T21:00:00-03:00", "feeling": "good"},
    {"logged_at": "2026-04-02T21:00:00-03:00", "feeling": "okay"},
    {"logged_at": "2026-03-30T21:00:00-03:00", "feeling": "good"},
    {"logged_at": "2026-03-27T21:00:00-03:00", "feeling": "great"},
    {"logged_at": "2026-03-24T21:00:00-03:00", "feeling": "okay"},
    {"logged_at": "2026-03-21T21:00:00-03:00", "feeling": "good"},
    {"logged_at": "2026-03-18T21:00:00-03:00", "feeling": "great"},
    {"logged_at": "2026-03-15T21:00:00-03:00", "feeling": "okay"},
    {"logged_at": "2026-03-12T21:00:00-03:00", "feeling": "good"},
    {"logged_at": "2026-03-09T21:00:00-03:00", "feeling": "okay"},
    {"logged_at": "2026-03-06T21:00:00-03:00", "feeling": "good"},
    {"logged_at": "2026-03-03T21:00:00-03:00", "feeling": "great"},
    {"logged_at": "2026-02-28T21:00:00-03:00", "feeling": "bad"},
    {"logged_at": "2026-02-25T21:00:00-03:00", "feeling": "okay"},
    {"logged_at": "2026-02-22T21:00:00-03:00", "feeling": "okay"},
    {"logged_at": "2026-02-18T21:00:00-03:00", "feeling": "bad"},
    {"logged_at": "2026-02-15T21:00:00-03:00", "feeling": "okay"},
    {"logged_at": "2026-02-12T21:00:00-03:00", "feeling": "okay"},
    {"logged_at": "2026-02-08T21:00:00-03:00", "feeling": "okay"}
  ]'::jsonb,

  -- ----------------------------------------------------------------
  -- SYMPTOMS
  -- ----------------------------------------------------------------
  '[
    {"logged_at": "2026-04-06T21:00:00-03:00", "symptoms": ["suppressed_appetite"], "severity": "mild"},
    {"logged_at": "2026-04-04T21:00:00-03:00", "symptoms": [], "severity": "mild"},
    {"logged_at": "2026-04-02T21:00:00-03:00", "symptoms": ["nausea", "fatigue"], "severity": "mild", "notes": "Felt tired after injection day"},
    {"logged_at": "2026-03-30T21:00:00-03:00", "symptoms": ["suppressed_appetite"], "severity": "mild"},
    {"logged_at": "2026-03-27T21:00:00-03:00", "symptoms": [], "severity": "mild"},
    {"logged_at": "2026-03-24T21:00:00-03:00", "symptoms": ["constipation", "bloating"], "severity": "moderate", "notes": "GI issues mid-week"},
    {"logged_at": "2026-03-21T21:00:00-03:00", "symptoms": ["fatigue"], "severity": "mild"},
    {"logged_at": "2026-03-18T21:00:00-03:00", "symptoms": [], "severity": "mild"},
    {"logged_at": "2026-03-15T21:00:00-03:00", "symptoms": ["nausea", "suppressed_appetite"], "severity": "mild"},
    {"logged_at": "2026-03-12T21:00:00-03:00", "symptoms": ["headache"], "severity": "mild"},
    {"logged_at": "2026-03-09T21:00:00-03:00", "symptoms": ["nausea", "fatigue", "bloating"], "severity": "moderate", "notes": "Rough day after dose bump"},
    {"logged_at": "2026-03-06T21:00:00-03:00", "symptoms": ["suppressed_appetite"], "severity": "mild"},
    {"logged_at": "2026-03-03T21:00:00-03:00", "symptoms": [], "severity": "mild"},
    {"logged_at": "2026-02-28T21:00:00-03:00", "symptoms": ["nausea", "vomiting", "fatigue", "stomach_pain"], "severity": "severe", "notes": "Very rough after first injection"},
    {"logged_at": "2026-02-25T21:00:00-03:00", "symptoms": ["nausea", "constipation"], "severity": "moderate"},
    {"logged_at": "2026-02-22T21:00:00-03:00", "symptoms": ["fatigue", "suppressed_appetite"], "severity": "mild"},
    {"logged_at": "2026-02-18T21:00:00-03:00", "symptoms": ["nausea", "bloating", "stomach_pain"], "severity": "moderate", "notes": "Side effects still adjusting"},
    {"logged_at": "2026-02-15T21:00:00-03:00", "symptoms": ["fatigue"], "severity": "mild"},
    {"logged_at": "2026-02-12T21:00:00-03:00", "symptoms": ["nausea", "injection_site_reaction"], "severity": "mild"},
    {"logged_at": "2026-02-08T21:00:00-03:00", "symptoms": ["nausea", "fatigue", "suppressed_appetite"], "severity": "moderate", "notes": "First week on Wegovy"}
  ]'::jsonb,

  -- ----------------------------------------------------------------
  -- SUPPLEMENTS
  -- ----------------------------------------------------------------
  '[
    {"logged_at": "2026-04-06T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-04-06T09:00:00-03:00", "name": "Magnesium", "dose": "400", "unit": "mg"},
    {"logged_at": "2026-04-05T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-04-05T09:00:00-03:00", "name": "Magnesium", "dose": "400", "unit": "mg"},
    {"logged_at": "2026-04-04T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-04-04T09:00:00-03:00", "name": "Vitamin D3", "dose": "2000", "unit": "IU"},
    {"logged_at": "2026-04-03T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-04-03T09:00:00-03:00", "name": "Magnesium", "dose": "400", "unit": "mg"},
    {"logged_at": "2026-04-02T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-04-01T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-04-01T09:00:00-03:00", "name": "Vitamin D3", "dose": "2000", "unit": "IU"},
    {"logged_at": "2026-03-31T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-31T09:00:00-03:00", "name": "Magnesium", "dose": "400", "unit": "mg"},
    {"logged_at": "2026-03-30T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-28T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-28T09:00:00-03:00", "name": "Vitamin D3", "dose": "2000", "unit": "IU"},
    {"logged_at": "2026-03-26T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-26T09:00:00-03:00", "name": "Magnesium", "dose": "400", "unit": "mg"},
    {"logged_at": "2026-03-24T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-22T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-20T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-18T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-15T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-12T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-08T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-03-04T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-02-28T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-02-22T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-02-15T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"},
    {"logged_at": "2026-02-08T09:00:00-03:00", "name": "Vitamin B12", "dose": "1000", "unit": "mcg"}
  ]'::jsonb,

  -- ----------------------------------------------------------------
  -- DOSES  (weekly injections, rotating sites)
  -- ----------------------------------------------------------------
  '[
    {"logged_at": "2026-04-05T10:00:00-03:00", "created_at": "2026-04-05T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "1.0 mg", "injection_site": "abdomen_upper_left"},
    {"logged_at": "2026-03-29T10:00:00-03:00", "created_at": "2026-03-29T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "1.0 mg", "injection_site": "abdomen_upper_right"},
    {"logged_at": "2026-03-22T10:00:00-03:00", "created_at": "2026-03-22T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "1.0 mg", "injection_site": "abdomen_lower_right"},
    {"logged_at": "2026-03-15T10:00:00-03:00", "created_at": "2026-03-15T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "0.5 mg", "injection_site": "abdomen_lower_left", "notes": "Dose bumped to 1.0 mg next week"},
    {"logged_at": "2026-03-08T10:00:00-03:00", "created_at": "2026-03-08T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "0.5 mg", "injection_site": "thigh_upper_left"},
    {"logged_at": "2026-03-01T10:00:00-03:00", "created_at": "2026-03-01T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "0.5 mg", "injection_site": "thigh_upper_right"},
    {"logged_at": "2026-02-22T10:00:00-03:00", "created_at": "2026-02-22T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "0.25 mg", "injection_site": "thigh_lower_right"},
    {"logged_at": "2026-02-15T10:00:00-03:00", "created_at": "2026-02-15T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "0.25 mg", "injection_site": "thigh_lower_left"},
    {"logged_at": "2026-02-08T10:00:00-03:00", "created_at": "2026-02-08T10:00:00-03:00", "method": "injection", "medication": "Wegovy", "dose": "0.25 mg", "injection_site": "arm_upper_left", "notes": "First dose"}
  ]'::jsonb
)
ON CONFLICT (user_id) DO UPDATE SET
  water       = EXCLUDED.water,
  exercise    = EXCLUDED.exercise,
  weight      = EXCLUDED.weight,
  meals       = EXCLUDED.meals,
  mood        = EXCLUDED.mood,
  symptoms    = EXCLUDED.symptoms,
  supplements = EXCLUDED.supplements,
  doses       = EXCLUDED.doses;
