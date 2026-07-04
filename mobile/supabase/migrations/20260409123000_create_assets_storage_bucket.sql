insert into storage.buckets (id, name, public)
values ('assets', 'assets', false)
on conflict (id) do nothing;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Assets objects are insertable by owner'
  ) then
    create policy "Assets objects are insertable by owner"
      on storage.objects
      for insert
      to authenticated
      with check (
        bucket_id = 'assets'
        and (storage.foldername(name))[1] = auth.uid()::text
      );
  end if;
end;
$$;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Assets objects are readable by owner'
  ) then
    create policy "Assets objects are readable by owner"
      on storage.objects
      for select
      to authenticated
      using (
        bucket_id = 'assets'
        and (storage.foldername(name))[1] = auth.uid()::text
      );
  end if;
end;
$$;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Assets objects are deletable by owner'
  ) then
    create policy "Assets objects are deletable by owner"
      on storage.objects
      for delete
      to authenticated
      using (
        bucket_id = 'assets'
        and (storage.foldername(name))[1] = auth.uid()::text
      );
  end if;
end;
$$;
