update public.profiles
set goals = jsonb_build_object(
  'water', jsonb_set(
    coalesce(goals->'water', '{"history": []}'::jsonb),
    '{enabled}',
    'true'::jsonb,
    true
  ),
  'exercise', jsonb_set(
    coalesce(goals->'exercise', '{"history": []}'::jsonb),
    '{enabled}',
    'true'::jsonb,
    true
  ),
  'meals', jsonb_set(
    coalesce(goals->'meals', '{"history": []}'::jsonb),
    '{enabled}',
    'true'::jsonb,
    true
  ),
  'protein', jsonb_set(
    coalesce(goals->'protein', '{"history": []}'::jsonb),
    '{enabled}',
    'true'::jsonb,
    true
  ),
  'fiber', jsonb_set(
    coalesce(goals->'fiber', '{"history": []}'::jsonb),
    '{enabled}',
    'true'::jsonb,
    true
  ),
  'weight', jsonb_set(
    coalesce(goals->'weight', '{"history": []}'::jsonb),
    '{enabled}',
    'true'::jsonb,
    true
  )
);
