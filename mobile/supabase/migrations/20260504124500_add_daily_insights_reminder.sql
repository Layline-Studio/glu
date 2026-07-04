update public.profiles
set reminders = jsonb_set(
  jsonb_set(
    coalesce(reminders, '{}'::jsonb),
    '{daily,enabled}',
    'true'::jsonb,
    true
  ),
  '{daily,items}',
  case
    when jsonb_typeof(coalesce(reminders->'daily'->'items', '[]'::jsonb)) <> 'array' then
      jsonb_build_array(
        jsonb_build_object(
          'id', 'insights',
          'enabled', true,
          'schedule', jsonb_build_object(
            'type', 'daily',
            'time_of_day', '19:00',
            'days_of_week', '[]'::jsonb,
            'scheduled_at', null,
            'interval_days', null,
            'start_date', null,
            'end_date', null,
            'timezone', null
          ),
          'content', jsonb_build_object(
            'title', 'Your daily insight is ready',
            'body', 'See what today''s logs reveal about your progress',
            'redirect_to', '/home'
          ),
          'metadata', jsonb_build_object(
            'slot', 'insights'
          )
        )
      )
    when exists (
      select 1
      from jsonb_array_elements(coalesce(reminders->'daily'->'items', '[]'::jsonb)) as item
      where item->>'id' = 'insights'
    ) then coalesce(reminders->'daily'->'items', '[]'::jsonb)
    else coalesce(reminders->'daily'->'items', '[]'::jsonb) || jsonb_build_array(
      jsonb_build_object(
        'id', 'insights',
        'enabled', true,
        'schedule', jsonb_build_object(
          'type', 'daily',
        'time_of_day', '19:00',
          'days_of_week', '[]'::jsonb,
          'scheduled_at', null,
          'interval_days', null,
          'start_date', null,
          'end_date', null,
          'timezone', null
        ),
        'content', jsonb_build_object(
          'title', 'Your daily insight is ready',
          'body', 'See what today''s logs reveal about your progress',
          'redirect_to', '/home'
        ),
        'metadata', jsonb_build_object(
          'slot', 'insights'
        )
      )
    )
  end,
  true
);
