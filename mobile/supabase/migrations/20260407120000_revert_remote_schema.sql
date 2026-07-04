drop extension if exists "pg_cron";

create extension if not exists "pg_net" with schema "extensions";

drop event trigger if exists ensure_rls;

drop event trigger if exists rls_auto_enable;

drop function if exists public.rls_auto_enable();
