do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Assets objects are updatable by owner'
  ) then
    create policy "Assets objects are updatable by owner"
      on storage.objects
      for update
      to authenticated
      using (
        bucket_id = 'assets'
        and (storage.foldername(name))[1] = auth.uid()::text
      )
      with check (
        bucket_id = 'assets'
        and (storage.foldername(name))[1] = auth.uid()::text
      );
  end if;
end;
$$;
