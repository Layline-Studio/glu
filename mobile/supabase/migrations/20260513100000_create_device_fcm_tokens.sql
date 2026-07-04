create table public.device_fcm_tokens (
  user_id uuid not null references auth.users(id) on delete cascade,
  token text not null,
  platform text not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, token)
);

alter table public.device_fcm_tokens enable row level security;

create policy "Users can manage their own FCM tokens"
  on public.device_fcm_tokens
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
