alter table public.records
  add column if not exists glowup jsonb not null default '[]'::jsonb;

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
    'glowup',
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
