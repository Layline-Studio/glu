drop policy if exists "Users can manage their own FCM tokens"
  on public.device_fcm_tokens;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'device_fcm_tokens'
      and policyname = 'Device FCM tokens are insertable by owner'
  ) then
    create policy "Device FCM tokens are insertable by owner"
      on public.device_fcm_tokens
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
      and tablename = 'device_fcm_tokens'
      and policyname = 'Device FCM tokens are readable by owner'
  ) then
    create policy "Device FCM tokens are readable by owner"
      on public.device_fcm_tokens
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
      and tablename = 'device_fcm_tokens'
      and policyname = 'Device FCM tokens are updatable by owner'
  ) then
    create policy "Device FCM tokens are updatable by owner"
      on public.device_fcm_tokens
      for update
      using (user_id = auth.uid())
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
      and tablename = 'device_fcm_tokens'
      and policyname = 'Device FCM tokens are deletable by owner'
  ) then
    create policy "Device FCM tokens are deletable by owner"
      on public.device_fcm_tokens
      for delete
      using (user_id = auth.uid());
  end if;
end;
$$;
