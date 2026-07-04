alter table public.records
  add column if not exists mood jsonb not null default '[]'::jsonb;

update public.records r
set
  mood = coalesce(r.mood, '[]'::jsonb) || coalesce(
    (
      select jsonb_agg(
        jsonb_build_object(
          'id',
          coalesce(elem->>'id', gen_random_uuid()::text),
          'logged_at',
          elem->>'logged_at',
          'feeling',
          elem->>'feeling'
        )
        order by ord
      )
      from jsonb_array_elements(coalesce(r.symptoms, '[]'::jsonb))
        with ordinality as t(elem, ord)
      where coalesce(elem->>'feeling', '') <> ''
        and coalesce(elem->>'logged_at', '') <> ''
    ),
    '[]'::jsonb
  ),
  symptoms = coalesce(
    (
      select jsonb_agg(elem - 'feeling' order by ord)
      from jsonb_array_elements(coalesce(r.symptoms, '[]'::jsonb))
        with ordinality as t(elem, ord)
    ),
    '[]'::jsonb
  )
where exists (
  select 1
  from jsonb_array_elements(coalesce(r.symptoms, '[]'::jsonb)) as elem
  where coalesce(elem->>'feeling', '') <> ''
);

create or replace function public.load_timeseries(
  p_column text,
  p_start timestamptz,
  p_end timestamptz
)
returns table (entry jsonb)
language plpgsql
security definer
set search_path = public
as $$
declare
  allowed_columns constant text[] := array[
    'water',
    'exercise',
    'weight',
    'meals',
    'symptoms',
    'mood',
    'supplements',
    'doses'
  ];
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  if not (p_column = any(allowed_columns)) then
    raise exception 'Unsupported record column: %', p_column;
  end if;

  return query execute format(
    $sql$
      select elem
      from public.records r,
      jsonb_array_elements(r.%I) as elem
      where r.user_id = auth.uid()
        and (elem->>'logged_at')::timestamptz >= $1
        and (elem->>'logged_at')::timestamptz < $2
      order by (elem->>'logged_at')::timestamptz asc
    $sql$,
    p_column
  )
  using p_start, p_end;
end;
$$;

grant execute on function public.load_timeseries(text, timestamptz, timestamptz)
  to authenticated;
