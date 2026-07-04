create table if not exists public.records (
  user_id uuid primary key references auth.users(id) on delete cascade,
  water jsonb not null default '[]'::jsonb,
  exercise jsonb not null default '[]'::jsonb,
  weight jsonb not null default '[]'::jsonb,
  meals jsonb not null default '[]'::jsonb,
  symptoms jsonb not null default '[]'::jsonb,
  supplements jsonb not null default '[]'::jsonb,
  doses jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

do $$
begin
  if not exists (
    select 1
    from pg_trigger
    where tgname = 'set_records_updated_at'
  ) then
    create trigger set_records_updated_at
    before update on public.records
    for each row
    execute procedure public.set_updated_at();
  end if;
end;
$$;

alter table public.records enable row level security;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'records'
      and policyname = 'Records are insertable by owner'
  ) then
    create policy "Records are insertable by owner"
      on public.records
      for insert
      with check (user_id = auth.uid());
  end if;
end;
$$;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'records'
      and policyname = 'Records are readable by owner'
  ) then
    create policy "Records are readable by owner"
      on public.records
      for select
      using (user_id = auth.uid());
  end if;
end;
$$;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'records'
      and policyname = 'Records are updatable by owner'
  ) then
    create policy "Records are updatable by owner"
      on public.records
      for update
      using (user_id = auth.uid())
      with check (user_id = auth.uid());
  end if;
end;
$$;
