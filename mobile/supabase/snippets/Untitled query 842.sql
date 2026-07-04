-- =============================================================
-- Glu - Long-range test data seed for records table
-- Generates a 13-month history ending on `current_date`.
--
-- On 2026-04-15, this spans 2025-03-15 -> 2026-04-15.
-- Weight logs are recorded almost weekly and trend from 115.0 kg
-- down to 72.0 kg, while water, meals, exercise, symptoms,
-- supplements, and doses follow the same overall progress story.
--
-- Replace the `user_id` below if needed, then run in the
-- Supabase SQL editor or via psql.
-- =============================================================
-- =============================================================
-- Glu - Long-range test data seed for records table
-- Generates a 13-month history ending on `current_date`.
--
-- On 2026-04-15, this spans 2025-03-15 -> 2026-04-15.
-- Weight logs are recorded almost weekly and trend from 115.0 kg
-- down to 72.0 kg, while water, meals, exercise, symptoms,
-- supplements, and doses follow the same overall progress story.
--
-- Replace the `user_id` below if needed, then run in the
-- Supabase SQL editor or via psql.
-- =============================================================

create or replace function public.seed_local_iso(
  p_day date,
  p_time time
)
returns text
language sql
immutable
as $$
  select to_char(
    p_day::timestamp + p_time,
    'YYYY-MM-DD"T"HH24:MI:SS.MS'
  ) || '-03:00'
$$;

WITH params AS (
  SELECT
    '91040b26-a321-432e-bc5d-e0d7aae9a1c2'::uuid AS user_id,
    (current_date - interval '13 months')::date AS start_date,
    current_date::date AS end_date
),
date_span AS (
  SELECT
    gs.day::date AS day,
    row_number() OVER (ORDER BY gs.day)::int - 1 AS day_index,
    greatest(count(*) OVER ()::int - 1, 1) AS total_days,
    (row_number() OVER (ORDER BY gs.day)::numeric - 1)
      / greatest(count(*) OVER ()::numeric - 1, 1) AS progress
  FROM params p
  CROSS JOIN generate_series(p.start_date, p.end_date, interval '1 day') AS gs(day)
),
dose_days AS (
  SELECT
    day,
    day_index,
    progress,
    (day_index / 7) AS week_index,
    row_number() OVER (ORDER BY day) - 1 AS dose_index
  FROM date_span
  WHERE extract(isodow FROM day) = 7
     OR day = (SELECT start_date FROM params)
),
weight_logs AS (
  SELECT coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', format('weight-%s', to_char(day, 'YYYYMMDD')),
        'logged_at', public.seed_local_iso(day, time '07:05'),
        'quantity',
          round(
            (
              CASE
                WHEN progress < 0.23 THEN
                  115 - (18 * (progress / 0.23))
                WHEN progress < 0.50 THEN
                  97 - (10 * ((progress - 0.23) / 0.27))
                WHEN progress < 0.72 THEN
                  87 - (4 * ((progress - 0.50) / 0.22))
                WHEN progress < 0.86 THEN
                  83 - (6 * ((progress - 0.72) / 0.14))
                ELSE
                  77 - (5 * ((progress - 0.86) / 0.14))
              END
              + (0.9 * sin(progress * 14 * pi()))
              + (0.35 * cos(progress * 31 * pi()))
              + CASE
                  WHEN progress BETWEEN 0.32 AND 0.46 THEN 1.2
                  WHEN progress BETWEEN 0.58 AND 0.66 THEN 0.8
                  WHEN progress BETWEEN 0.90 AND 0.96 THEN 0.5
                  ELSE 0
                END
              + CASE
                  WHEN day_index % 37 = 0 THEN 0.5
                  WHEN day_index % 53 = 0 THEN 0.3
                  ELSE 0
                END
            )::numeric,
            1
          ),
        'unit', 'kg'
      )
      ORDER BY day::timestamp + time '07:05'
    ),
    '[]'::jsonb
  ) AS payload
  FROM date_span
  WHERE day = (SELECT start_date FROM params)
     OR day = (SELECT end_date FROM params)
     OR extract(isodow FROM day) = 1
     OR (day_index % 11 = 0)
),
water_logs AS (
  SELECT coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', format('water-%s-%s', to_char(day, 'YYYYMMDD'), slot_index),
        'logged_at', logged_at,
        'quantity', quantity_ml,
        'unit', 'ml'
      )
      ORDER BY logged_at
    ),
    '[]'::jsonb
  ) AS payload
  FROM (
    SELECT
      d.day,
      s.slot_index,
      public.seed_local_iso(d.day, s.log_time) AS logged_at,
      (
        s.base_ml
        + round((450 * d.progress))::int
        + CASE
            WHEN extract(isodow FROM d.day) IN (6, 7) THEN -80
            ELSE 0
          END
        + CASE
            WHEN s.slot_index = 3 AND d.day_index % 9 = 0 THEN 120
            ELSE 0
          END
      ) AS quantity_ml
    FROM date_span d
    CROSS JOIN (
      VALUES
        (1, time '07:15', 360),
        (2, time '12:40', 540),
        (3, time '18:20', 460)
    ) AS s(slot_index, log_time, base_ml)
    WHERE extract(isodow FROM d.day) <> 7
       OR s.slot_index <= 2
  ) entries
),
exercise_logs AS (
  SELECT coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', format('exercise-%s', to_char(day, 'YYYYMMDD')),
        'logged_at', logged_at,
        'activity_type', activity_type,
        'duration_minutes', duration_minutes,
        'intensity', intensity,
        'notes', notes
      )
      ORDER BY logged_at
    ),
    '[]'::jsonb
  ) AS payload
  FROM (
    SELECT
      d.day,
      public.seed_local_iso(d.day, time '06:40') AS logged_at,
      CASE extract(isodow FROM d.day)
        WHEN 1 THEN 'Walking'
        WHEN 3 THEN CASE WHEN d.progress < 0.45 THEN 'Walking' ELSE 'Strength training' END
        WHEN 5 THEN CASE WHEN d.progress < 0.30 THEN 'Cycling' ELSE 'Running' END
        ELSE 'Cycling'
      END AS activity_type,
      CASE extract(isodow FROM d.day)
        WHEN 1 THEN 22 + round(18 * d.progress)::int
        WHEN 3 THEN 24 + round(26 * d.progress)::int
        WHEN 5 THEN 20 + round(20 * d.progress)::int
        ELSE 28 + round(24 * d.progress)::int
      END AS duration_minutes,
      CASE
        WHEN extract(isodow FROM d.day) = 5 AND d.progress >= 0.40 THEN 'intense'
        WHEN d.progress >= 0.20 THEN 'moderate'
        ELSE 'light'
      END AS intensity,
      CASE
        WHEN d.progress < 0.12 AND extract(isodow FROM d.day) = 1
          THEN 'Starting with shorter sessions'
        WHEN d.progress > 0.80 AND extract(isodow FROM d.day) = 6
          THEN 'Longer weekend session'
        ELSE NULL
      END AS notes
    FROM date_span d
    WHERE extract(isodow FROM d.day) IN (1, 3, 5, 6)
  ) entries
),
meal_logs AS (
  SELECT coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', format('meal-%s-%s', to_char(day, 'YYYYMMDD'), meal_code),
        'logged_at', logged_at,
        'name', meal_name,
        'calories', calories,
        'carbs', carbs,
        'proteins', proteins,
        'fats', fats,
        'fiber', fiber,
        'consumed', consumed,
        'notes', notes
      )
      ORDER BY logged_at
    ),
    '[]'::jsonb
  ) AS payload
  FROM (
    SELECT
      d.day,
      m.meal_code,
      public.seed_local_iso(d.day, m.log_time) AS logged_at,
      m.meal_name,
      greatest(
        220,
        m.base_calories
          - round(m.calorie_drop * d.progress)::int
          + CASE WHEN extract(isodow FROM d.day) IN (6, 7) THEN 45 ELSE 0 END
      ) AS calories,
      greatest(
        18,
        m.base_carbs
          - round(m.carb_drop * d.progress)::int
          + CASE WHEN extract(isodow FROM d.day) IN (6, 7) THEN 4 ELSE 0 END
      ) AS carbs,
      m.base_protein + round(m.protein_gain * d.progress)::int AS proteins,
      greatest(
        7,
        m.base_fats
          - round(m.fat_drop * d.progress)::int
          + CASE WHEN extract(isodow FROM d.day) IN (6, 7) THEN 2 ELSE 0 END
      ) AS fats,
      m.base_fiber + round(m.fiber_gain * d.progress)::int AS fiber,
      CASE
        WHEN m.meal_code = 'dinner' AND d.day_index % 17 = 0 THEN 0.75
        WHEN m.meal_code = 'lunch' AND d.day_index % 29 = 0 THEN 0.50
        ELSE 1.0
      END AS consumed,
      CASE
        WHEN d.progress < 0.18 AND m.meal_code = 'dinner'
          THEN 'Portions were still larger early on'
        WHEN d.progress > 0.72 AND m.meal_code = 'breakfast'
          THEN 'Protein-first breakfast'
        ELSE NULL
      END AS notes
    FROM date_span d
    CROSS JOIN (
      VALUES
        ('breakfast', time '08:05', 'Greek yogurt oats', 520, 120, 58, 18, 26, 8, 18, 7, 5, 4),
        ('lunch', time '13:00', 'Chicken rice bowl', 910, 260, 98, 28, 42, 10, 32, 12, 8, 4),
        ('dinner', time '19:20', 'Salmon veggie plate', 760, 180, 64, 20, 38, 8, 30, 10, 7, 4)
    ) AS m(
      meal_code,
      log_time,
      meal_name,
      base_calories,
      calorie_drop,
      base_carbs,
      carb_drop,
      base_protein,
      protein_gain,
      base_fats,
      fat_drop,
      base_fiber,
      fiber_gain
    )
  ) entries
),
symptom_logs AS (
  SELECT coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', format('symptom-%s', to_char(day, 'YYYYMMDD')),
        'logged_at', logged_at,
        'symptoms', symptoms,
        'severity', severity,
        'notes', notes
      )
      ORDER BY logged_at
    ),
    '[]'::jsonb
  ) AS payload
  FROM (
    SELECT
      d.day,
      public.seed_local_iso(d.day, time '20:45') AS logged_at,
      CASE
        WHEN d.progress < 0.12 THEN to_jsonb(ARRAY['nausea', 'fatigue', 'suppressed_appetite']::text[])
        WHEN d.progress < 0.25 THEN to_jsonb(ARRAY['nausea', 'constipation']::text[])
        WHEN d.progress < 0.45 THEN to_jsonb(ARRAY['suppressed_appetite', 'bloating']::text[])
        WHEN d.progress < 0.72 THEN to_jsonb(ARRAY['suppressed_appetite']::text[])
        ELSE to_jsonb(ARRAY['no_symptoms']::text[])
      END AS symptoms,
      CASE
        WHEN d.progress < 0.10 THEN 'moderate'
        WHEN d.progress < 0.22 THEN 'moderate'
        ELSE 'mild'
      END AS severity,
      CASE
        WHEN d.progress < 0.10 THEN 'Adjustment period after the first few doses'
        WHEN d.progress < 0.25 AND extract(isodow FROM d.day) = 1 THEN 'Symptoms tended to peak the day after injection'
        WHEN d.progress > 0.80 AND extract(isodow FROM d.day) = 4 THEN 'Symptoms largely settled by this stage'
        ELSE NULL
      END AS notes
    FROM date_span d
    WHERE extract(isodow FROM d.day) IN (1, 4)
  ) entries
),
mood_logs AS (
  SELECT coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', format('mood-%s', to_char(day, 'YYYYMMDD')),
        'logged_at', logged_at,
        'feeling', feeling
      )
      ORDER BY logged_at
    ),
    '[]'::jsonb
  ) AS payload
  FROM (
    SELECT
      d.day,
      public.seed_local_iso(d.day, time '20:30') AS logged_at,
      CASE
        WHEN d.progress < 0.10 THEN 'okay'
        WHEN d.progress < 0.28 THEN
          CASE WHEN d.day_index % 9 = 0 THEN 'okay' ELSE 'good' END
        WHEN d.progress < 0.62 THEN
          CASE WHEN d.day_index % 14 = 0 THEN 'okay' ELSE 'good' END
        WHEN d.progress < 0.88 THEN
          CASE WHEN d.day_index % 18 = 0 THEN 'good' ELSE 'great' END
        ELSE
          CASE WHEN d.day_index % 24 = 0 THEN 'good' ELSE 'great' END
      END AS feeling
    FROM date_span d
    WHERE extract(isodow FROM d.day) IN (1, 3, 5, 7)
  ) entries
),
supplement_logs AS (
  SELECT coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', format('supplement-%s-%s', to_char(day, 'YYYYMMDD'), item_code),
        'logged_at', logged_at,
        'name', supplement_name,
        'dose', dose_value,
        'unit', unit_name
      )
      ORDER BY logged_at
    ),
    '[]'::jsonb
  ) AS payload
  FROM (
    SELECT
      d.day,
      s.item_code,
      public.seed_local_iso(d.day, s.log_time) AS logged_at,
      s.supplement_name,
      s.dose_value,
      s.unit_name
    FROM date_span d
    JOIN (
      VALUES
        ('b12', time '08:55', 'Vitamin B12', '1000', 'mcg'),
        ('d3', time '08:56', 'Vitamin D3', '2000', 'IU'),
        ('mag', time '21:00', 'Magnesium', '400', 'mg')
    ) AS s(item_code, log_time, supplement_name, dose_value, unit_name)
      ON (
        s.item_code = 'b12'
        OR (s.item_code = 'd3' AND extract(isodow FROM d.day) IN (1, 4, 7))
        OR (s.item_code = 'mag' AND extract(isodow FROM d.day) IN (1, 3, 5, 7))
      )
  ) entries
),
dose_logs AS (
  SELECT coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', format('dose-%s', to_char(day, 'YYYYMMDD')),
        'logged_at', logged_at,
        'created_at', logged_at,
        'method', 'injection',
        'medication', 'Wegovy',
        'dose', dose_label,
        'injection_site', injection_site,
        'notes', notes
      )
      ORDER BY logged_at
    ),
    '[]'::jsonb
  ) AS payload
  FROM (
    SELECT
      dd.day,
      public.seed_local_iso(dd.day, time '10:00') AS logged_at,
      CASE
        WHEN dd.week_index < 4 THEN '0.25 mg'
        WHEN dd.week_index < 8 THEN '0.5 mg'
        WHEN dd.week_index < 16 THEN '1.0 mg'
        WHEN dd.week_index < 28 THEN '1.7 mg'
        WHEN dd.week_index < 40 THEN '2.4 mg'
        WHEN dd.week_index < 48 THEN '1.7 mg'
        ELSE '1.0 mg'
      END AS dose_label,
      (
        ARRAY[
          'abdomen_upper_left',
          'abdomen_upper_right',
          'abdomen_lower_right',
          'abdomen_lower_left',
          'thigh_upper_left',
          'thigh_upper_right',
          'thigh_lower_right',
          'thigh_lower_left',
          'arm_upper_left',
          'arm_upper_right',
          'buttocks_upper_left',
          'buttocks_upper_right'
        ]
      )[1 + (dd.dose_index % 12)] AS injection_site,
      CASE
        WHEN dd.week_index = 0 THEN 'First logged dose'
        WHEN dd.week_index IN (4, 8, 16, 28) THEN 'Dose increase week'
        WHEN dd.week_index IN (40, 48) THEN 'Dose reduction week'
        ELSE NULL
      END AS notes
    FROM dose_days dd
  ) entries
)
INSERT INTO records (
  user_id,
  water,
  exercise,
  weight,
  meals,
  symptoms,
  mood,
  supplements,
  doses
)
SELECT
  p.user_id,
  w.payload,
  e.payload,
  wt.payload,
  m.payload,
  s.payload,
  mo.payload,
  su.payload,
  d.payload
FROM params p
CROSS JOIN water_logs w
CROSS JOIN exercise_logs e
CROSS JOIN weight_logs wt
CROSS JOIN meal_logs m
CROSS JOIN symptom_logs s
CROSS JOIN mood_logs mo
CROSS JOIN supplement_logs su
CROSS JOIN dose_logs d
ON CONFLICT (user_id) DO UPDATE SET
  water = EXCLUDED.water,
  exercise = EXCLUDED.exercise,
  weight = EXCLUDED.weight,
  meals = EXCLUDED.meals,
  symptoms = EXCLUDED.symptoms,
  mood = EXCLUDED.mood,
  supplements = EXCLUDED.supplements,
  doses = EXCLUDED.doses;
