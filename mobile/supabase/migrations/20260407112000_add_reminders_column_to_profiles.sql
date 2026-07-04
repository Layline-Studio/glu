alter table public.profiles
add column if not exists reminders jsonb not null default '{}'::jsonb;
