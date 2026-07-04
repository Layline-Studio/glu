alter table public.ai_requests
  add column if not exists request jsonb not null default '{}'::jsonb,
  add column if not exists response jsonb,
  add column if not exists status text not null default 'pending',
  add column if not exists completed_at timestamptz;

alter table public.ai_requests
  alter column model drop not null,
  alter column input_tokens drop not null,
  alter column output_tokens drop not null,
  alter column cost_usd drop not null;

alter table public.ai_requests
  alter column request drop default;
