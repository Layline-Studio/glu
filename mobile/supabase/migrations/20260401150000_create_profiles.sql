create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  subscription_tier text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  timezone text,
  settings jsonb not null default '{}'::jsonb
);

create index if not exists idx_profiles_onboarding_completed_at
on public.profiles ((settings->>'onboarding_completed_at'));

do $$
begin
  if not exists (
    select 1
    from pg_trigger
    where tgname = 'set_profiles_updated_at'
  ) then
    create trigger set_profiles_updated_at
    before update on public.profiles
    for each row
    execute procedure public.set_updated_at();
  end if;
end;
$$;

alter table public.profiles enable row level security;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'profiles'
      and policyname = 'Profiles are insertable by owner'
  ) then
    create policy "Profiles are insertable by owner"
      on public.profiles
      for insert
      with check (id = auth.uid());
  end if;
end;
$$;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'profiles'
      and policyname = 'Profiles are readable by owner'
  ) then
    create policy "Profiles are readable by owner"
      on public.profiles
      for select
      using (id = auth.uid());
  end if;
end;
$$;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'profiles'
      and policyname = 'Profiles are updatable by owner'
  ) then
    create policy "Profiles are updatable by owner"
      on public.profiles
      for update
      using (id = auth.uid())
      with check (id = auth.uid());
  end if;
end;
$$;
