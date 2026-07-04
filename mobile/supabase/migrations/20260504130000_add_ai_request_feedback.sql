alter table public.ai_requests
  add column if not exists feedback jsonb;

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'ai_requests_feedback_valid'
      and conrelid = 'public.ai_requests'::regclass
  ) then
    alter table public.ai_requests
      add constraint ai_requests_feedback_valid
      check (
        feedback is null or (
          jsonb_typeof(feedback) = 'object'
          and feedback ? 'value'
          and feedback->>'value' in ('positive', 'negative')
          and (
            not (feedback ? 'reason')
            or jsonb_typeof(feedback->'reason') = 'string'
          )
        )
      );
  end if;
end;
$$;
