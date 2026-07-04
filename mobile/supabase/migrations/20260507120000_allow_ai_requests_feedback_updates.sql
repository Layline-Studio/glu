do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'ai_requests'
      and policyname = 'AI requests are updatable by owner'
  ) then
    create policy "AI requests are updatable by owner"
      on public.ai_requests
      for update
      to authenticated
      using (user_id = auth.uid())
      with check (user_id = auth.uid());
  end if;
end;
$$;
