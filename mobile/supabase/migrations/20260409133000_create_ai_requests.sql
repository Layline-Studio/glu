create table if not exists public.ai_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  feature_name text not null,
  model text not null,
  input_tokens int not null,
  output_tokens int not null,
  cost_usd numeric(10, 6) not null,
  created_at timestamptz not null default now()
);

create index if not exists idx_ai_requests_user_date
  on public.ai_requests(user_id, created_at);

alter table public.ai_requests enable row level security;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'ai_requests'
      and policyname = 'AI requests are readable by owner'
  ) then
    create policy "AI requests are readable by owner"
      on public.ai_requests
      for select
      to authenticated
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
      and tablename = 'ai_requests'
      and policyname = 'AI requests are insertable by owner'
  ) then
    create policy "AI requests are insertable by owner"
      on public.ai_requests
      for insert
      to authenticated
      with check (user_id = auth.uid());
  end if;
end;
$$;

grant all on public.ai_requests to service_role;
