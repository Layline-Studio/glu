# PRD: Push Notifications (FCM)

## Summary

A server-driven push notification system that allows users to schedule reminders for doses, water, meals, exercise, and other health events. Reminders are configured per-type in the user profile and executed via a lightweight delayed-job queue backed by FCM.

## Context

The app already has a "next dose reminder" screen that saves reminder settings to the user profile, but nothing triggers an actual push notification. Users rely on memory to track recurring medication and health habits. FCM is already a dependency (`firebase_messaging` added), and Firebase is initialized at app startup.

## Goals

- Deliver push notifications reliably for any reminder type the user configures
- Support recurring reminders using rrule (daily, weekly, custom cadences)
- Keep the pipeline generic — adding a new notification type requires no backend changes
- Notifications fire even when the app is closed or the device has been restarted

## Non-Goals

- In-app notification inbox
- Real-time or sub-minute precision
- Notification analytics / open tracking (v1)
- Email or SMS fallback

## User Stories

- As a user, I want to receive a push notification when my next dose is due so I don't miss it
- As a user, I want to set recurring reminders for water, meals, and exercise so I stay on track
- As a user, I want to disable or change a reminder at any time and have it take effect immediately
- As a user, I want reminders to keep firing on schedule without having to reopen the app

## UX Overview

### Entry Points

- Settings → Next dose reminder (existing screen)
- Settings → Reminders (future screen per type: water, meals, exercise, etc.)

### Happy Path

1. User opens a reminder settings screen
2. User enables reminder and configures schedule (time, recurrence)
3. App writes `profiles.reminders` and upserts a row in `scheduled_notifications` with `scheduled_for = DTSTART`
4. Scheduled Edge Function fires every minute, picks up due rows
5. Edge Function joins `profiles` for FCM token and reminder payload, sends via FCM
6. Edge Function computes next occurrence from rrule and updates `scheduled_for`

### Error States

- FCM token missing → skip send, log warning, no reschedule disruption
- FCM send fails → log error, leave row in queue (retried next minute)
- rrule produces no future date (series ended) → delete row from queue
- User disables reminder mid-cycle → app deletes row from `scheduled_notifications` immediately

## Functional Requirements

- Users can enable/disable per-type reminders independently
- Each reminder type stores an rrule and a payload (title, body) in `profiles.reminders`
- Flutter writes `profiles.reminders` and syncs `scheduled_notifications` directly (upsert on save, delete on disable)
- Scheduled Edge Function (`config.toml`) polls `scheduled_notifications` every minute for due rows
- A single Edge Function handles: fetching due rows, sending FCM, rescheduling
- One-shot reminders (`UNTIL` = `DTSTART`) are deleted after send
- Recurring reminders with an `UNTIL` date are deleted once that date is passed
- Recurring reminders update `scheduled_for` to the next rrule occurrence after send
- Notifications overdue by more than 30 minutes are skipped (rescheduled only, not sent)
- FCM token is read fresh from `profiles` at send time (never stored in the queue)
- Reminder payload (title, body) is read fresh from `profiles.reminders` at send time

## Non-Functional Requirements

- **Performance:** Edge Function processes due rows with `Promise.all` (parallel FCM sends). Polling interval is 1 minute.
- **Reliability:** Failed sends remain in queue and are retried on the next poll cycle. No message is deleted before a successful send.
- **Idempotency:** Each `scheduled_notifications` row has a unique ID; concurrent executions should not double-send (use `SELECT ... FOR UPDATE SKIP LOCKED`).
- **Security:** FCM tokens are PII — never logged, never exposed in Edge Function responses. RLS on `scheduled_notifications` allows authenticated users to manage their own rows only; Edge Function accesses via service role.
- **Offline:** Reminder configuration is saved locally (optimistic UI) and synced to Supabase when connectivity resumes.

## Data Model Changes

### `profiles` (existing table)

Add columns:

```sql
reminders jsonb not null default '{}'::jsonb
fcm_token  text
```

`settings` (existing jsonb column) — add `timezone` key:

```json
{ "timezone": "America/New_York" }
```

Written by Flutter on first launch (and on change) using `flutter_timezone`. Used by Flutter when constructing rrule strings with `TZID`.

`reminders` shape — each rrule carries `DTSTART` (set by Flutter at save time) to anchor the first occurrence and all subsequent ones. `TZID` on `DTSTART` handles DST. Each key maps to one row in `scheduled_notifications`.

`DTSTART` format: `DTSTART;TZID=<tz>:<YYYYMMDDTHHMMSS>`

```json
{
  "dose": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T080000\nFREQ=WEEKLY;BYDAY=MO;BYHOUR=8;BYMINUTE=0",
    "payload": { "title": "Time for your dose", "body": "Semaglutide 0.5mg · Left thigh", "route": "/log/dose" },
    "metadata": {
      "medication": "Semaglutide",
      "dose_mg": "0.5",
      "injection_site": "Left thigh"
    }
  },

  "water_morning": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T080000\nFREQ=DAILY;BYHOUR=8;BYMINUTE=0",
    "payload": { "title": "Drink water", "body": "Start your day hydrated", "route": "/log/water" }
  },
  "water_midday": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T120000\nFREQ=DAILY;BYHOUR=12;BYMINUTE=0",
    "payload": { "title": "Drink water", "body": "Midday hydration check", "route": "/log/water" }
  },
  "water_evening": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T180000\nFREQ=DAILY;BYHOUR=18;BYMINUTE=0",
    "payload": { "title": "Drink water", "body": "Evening hydration check", "route": "/log/water" }
  },

  "meals_breakfast": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T073000\nFREQ=DAILY;BYHOUR=7;BYMINUTE=30",
    "payload": { "title": "Log breakfast", "body": "What did you have this morning?", "route": "/log/meals" }
  },
  "meals_lunch": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T123000\nFREQ=DAILY;BYHOUR=12;BYMINUTE=30",
    "payload": { "title": "Log lunch", "body": "Don't forget to log your meal", "route": "/log/meals" }
  },
  "meals_dinner": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T190000\nFREQ=DAILY;BYHOUR=19;BYMINUTE=0",
    "payload": { "title": "Log dinner", "body": "Log your evening meal", "route": "/log/meals" }
  },

  "weight": {
    "rrule": "DTSTART;TZID=America/New_York:20260413T070000\nFREQ=WEEKLY;BYDAY=MO;BYHOUR=7;BYMINUTE=0",
    "payload": { "title": "Weekly weigh-in", "body": "Log your weight to track progress", "route": "/log/weight" }
  },

  "exercise": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T070000\nFREQ=WEEKLY;BYDAY=MO,WE,FR;BYHOUR=7;BYMINUTE=0",
    "payload": { "title": "Exercise reminder", "body": "Time for your workout", "route": "/log/exercise" }
  },

  "symptoms": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T200000\nFREQ=DAILY;BYHOUR=20;BYMINUTE=0",
    "payload": { "title": "How are you feeling?", "body": "Log any symptoms from today", "route": "/log/symptoms" }
  },

  "supplements": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T080000\nFREQ=DAILY;BYHOUR=8;BYMINUTE=0",
    "payload": { "title": "Take your supplements", "body": "Don't forget your daily supplements", "route": "/log/supplements" }
  },

  "daily_morning": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T080000\nFREQ=DAILY;BYHOUR=8;BYMINUTE=0",
    "payload": { "title": "Morning check-in", "body": "Start your day on track", "route": "/" }
  },
  "daily_midday": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T120000\nFREQ=DAILY;BYHOUR=12;BYMINUTE=0",
    "payload": { "title": "Midday check-in", "body": "How's your day going?", "route": "/" }
  },
  "daily_evening": {
    "rrule": "DTSTART;TZID=America/New_York:20260407T200000\nFREQ=DAILY;BYHOUR=20;BYMINUTE=0",
    "payload": { "title": "Evening check-in", "body": "Log how your day went", "route": "/" }
  }
}
```

**Key naming convention:** `{type}` for single reminders, `{type}_{slot}` for multi-time types. Each key = one row in `scheduled_notifications`. Adding or removing a key is handled directly by Flutter.

**Flutter responsibility:** when the user saves a reminder, Flutter constructs the full rrule string including `DTSTART` set to the first intended fire time in the user's local timezone. Flutter also writes the initial `scheduled_for` (= `DTSTART` converted to UTC) directly to `scheduled_notifications`. The backend never infers a start date.

### `scheduled_notifications` (new table)

```sql
create table scheduled_notifications (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid not null references profiles(user_id) on delete cascade,
  reminder_type  text not null,
  scheduled_for  timestamptz not null,
  created_at     timestamptz not null default now(),
  unique (user_id, reminder_type)
);

create index on scheduled_notifications (scheduled_for)
  where scheduled_for <= now();
```

The unique constraint on `(user_id, reminder_type)` is required for Flutter to upsert queue rows safely.

## Backend Requirements

### Edge Function: `send-notifications`

- Scheduled every minute via `config.toml`
- Queries `scheduled_notifications WHERE scheduled_for <= now()` using `FOR UPDATE SKIP LOCKED`
- Joins `profiles` for `fcm_token` and `reminders->reminder_type`
- Sends FCM via HTTP v1 API using `Promise.all`
- Before send: if `now() - scheduled_for > 30 minutes` → skip send, go straight to reschedule
- On success: compute `next = rrule.after(now())` (not `after(scheduled_for)` — always anchors to current time to guarantee a future occurrence)
  - `next` is null → `UNTIL` passed → `DELETE` row
  - `next === scheduled_for` → no future occurrences beyond this one → `DELETE` row
  - otherwise → `UPDATE scheduled_for = next`
- Channel ID derived from reminder type: `reminderType.split('_')[0]` → set as `android.notification.channel_id` in FCM payload. Pattern `water*` matches both `water` and `water_morning`, `water_midday`, etc.
- `route` from payload included as FCM data field for deep linking on notification tap
- On FCM failure (`UNREGISTERED` / `NOT_FOUND`): delete row — user is gone, no reschedule
- On other FCM failure: log error, leave row untouched (natural retry)

### RLS

- `scheduled_notifications` — authenticated users can insert/update/delete their own rows (`user_id = auth.uid()`); service role used by Edge Function bypasses RLS automatically
- `profiles.fcm_token` — readable and writable by authenticated user (own row only)

> The service role key must never be embedded in the Flutter app. Flutter uses the anon key with RLS to scope writes to the authenticated user's own rows.

## Frontend Requirements

### Token registration (`main.dart` / auth flow)

- After sign-in: `FirebaseMessaging.instance.getToken()` → upsert `profiles.fcm_token`
- `FirebaseMessaging.instance.onTokenRefresh` → update `profiles.fcm_token`
- Request notification permission as part of the reminder save flow
- If permission denied → show explanation, abort save, do not write to `profiles.reminders`
- Save button is gated behind FCM token availability — if no token, prompt user to enable notifications before allowing save

### Notification channels (Android)

Created once at app startup via `flutter_local_notifications`, one per reminder type prefix:

```dart
const channels = [
  AndroidNotificationChannel('dose',        'Dose reminders',        importance: Importance.high),
  AndroidNotificationChannel('water',       'Water reminders',       importance: Importance.defaultImportance),
  AndroidNotificationChannel('meals',       'Meal reminders',        importance: Importance.defaultImportance),
  AndroidNotificationChannel('weight',      'Weight reminders',      importance: Importance.defaultImportance),
  AndroidNotificationChannel('exercise',    'Exercise reminders',    importance: Importance.defaultImportance),
  AndroidNotificationChannel('symptoms',    'Symptom check-ins',     importance: Importance.defaultImportance),
  AndroidNotificationChannel('supplements', 'Supplement reminders',  importance: Importance.defaultImportance),
  AndroidNotificationChannel('daily',       'Daily reminders',        importance: Importance.defaultImportance),
];
```

Users can silence individual reminder types in system settings without affecting others.

### Receiving notifications

- `FirebaseMessaging.onMessage` (foreground) → display via `flutter_local_notifications` using channel derived from `reminder_type` prefix
- Background / killed state → FCM renders `notification` payload automatically using `channel_id` from FCM message

### Deep linking

- Notification tap (background) → `FirebaseMessaging.onMessageOpenedApp` → app navigates to home, then opens the relevant log sheet for `data.route`
- Notification tap (killed state) → `FirebaseMessaging.getInitialMessage()` on startup → same behaviour after app is fully initialised
- `route` is passed as a FCM data field alongside the `notification` payload
- Navigation always lands on home first to ensure a valid navigation stack; the log sheet opens on top of it

### Reminder settings (Flutter)

- On save: write `profiles.reminders` + upsert `scheduled_notifications` with `scheduled_for = DTSTART` (converted to UTC); `DTSTART` is always today at the configured time
- On edit: new rrule uses today as `DTSTART`; upsert overwrites existing queue row via unique constraint
- On disable/delete: remove key from `profiles.reminders` + delete row from `scheduled_notifications`
- Flutter uses the Dart `rrule` package to construct and validate rrule strings before saving
- `onBackgroundMessage` handler must be a top-level function (not a class method) — Flutter/FCM requirement

## Edge Cases

- User uninstalls and reinstalls → new FCM token written on next launch; old token silently fails FCM and is ignored
- rrule with `UNTIL` already passed → Flutter should not insert a queue row; Edge Function deletes if encountered
- User changes timezone → Flutter updates `profiles.settings.timezone`, rewrites rrules with new `TZID`, and upserts `scheduled_notifications` with recomputed `scheduled_for`
- DST transitions → handled automatically by the rrule library since `TZID` is embedded in the rrule; `scheduled_for` is always stored as UTC
- Multiple devices → `profiles.fcm_token` stores one token (last registered wins); multi-device support deferred to v2 (requires `profile_devices` one-to-many table)
- User denies notification permission → reminder save is aborted; no queue row is created
- Supabase downtime during send → rows remain in queue; on recovery, rows overdue by >30 minutes are rescheduled only (not sent), rows overdue by ≤30 minutes are sent normally

## Dependencies

- `firebase_messaging` (already added)
- `flutter_local_notifications` (new Flutter dep)
- `rrule` npm package (Deno-compatible, used in Edge Function)
- Supabase scheduled Edge Functions via `config.toml` (no pg_cron needed)
- FCM HTTP v1 API — service account JSON base64-encoded as a single secret: `FCM_SERVICE_ACCOUNT_B64`

  **How to download:**
  1. Firebase Console → Project Settings → Service Accounts
  2. Find the existing `firebase-adminsdk-*` service account → click "Generate new private key" → downloads a `.json` file
  3. Base64-encode it:
     ```bash
     base64 -i service-account.json | tr -d '\n'
     ```
  4. Store the output as a Supabase Edge Function secret:
     ```bash
     supabase secrets set FCM_SERVICE_ACCOUNT_B64=<output>
     ```
  5. Delete the local `.json` file — never commit it

  **How to use in Edge Function:**
  ```ts
  const serviceAccount = JSON.parse(atob(Deno.env.get('FCM_SERVICE_ACCOUNT_B64')!))
  ```
- `rrule` Dart package (used in Flutter for computing initial `scheduled_for`)
- `flutter_timezone` Dart package (used to read device timezone and write to `profiles.settings.timezone`)

## Decisions

- **rrule stored in profile, not queue** — reminder config is user data; queue is an execution detail
- **One-shot via `UNTIL=DTSTART`** — no special one-shot flag needed; rrule with `UNTIL` equal to `DTSTART` fires once then has no next occurrence
- **30-minute skip window** — avoids flooding users with stale notifications after downtime; 30 min chosen as reasonable grace period for health reminders
- **Channel ID = type prefix** — channel is `reminderType.split('_')[0]`, so `water*` matches `water`, `water_morning`, `water_midday`, etc. all map to the same `water` channel. Single-word types like `dose` match themselves. Users control per-type muting in system settings with no extra config.
- **`route` in payload, `metadata` in reminder** — `route` is operational (used at send time); `metadata` is contextual (medication details) and never sent to FCM
- **No trigger, no second Edge Function** — Flutter uses the Dart rrule package to construct and validate the rrule string; `scheduled_for = DTSTART` converted to UTC (no rrule computation needed at save time); `send-notifications` is the only place `rrule.after(now())` is ever called
- **FCM service account as `FCM_SERVICE_ACCOUNT_B64`** — service account JSON base64-encoded into a single env secret; decoded at runtime with `JSON.parse(atob(...))`
- **FCM token gating** — save is blocked if no token; permission denied aborts save entirely; prevents orphaned queue rows with no delivery path
- **iOS APNs** — `aps-environment: production` already present in `Glu.entitlements`; no additional entitlement changes needed
- **`DTSTART` = today on every save** — editing a reminder always anchors to the current date; no ambiguity about which occurrence is "next"
- **Multi-device deferred to v2** — requires schema change (`profile_devices` table); last-registered token wins in v1
- **Stale token cleanup** — `UNREGISTERED`/`NOT_FOUND` from FCM deletes the queue row; no additional TTL or cleanup job needed
- **rrule carries `TZID`, not UTC** — preserves user intent across DST transitions; `scheduled_for` in the queue is always UTC but computed from local time
- **`timezone` in `profiles.settings`** — reuses existing jsonb settings column, no new column needed
- **Read fresh at send time** — avoids stale payloads and token duplication across queue rows
- **Flutter-driven sync** — Flutter writes both `profiles.reminders` and `scheduled_notifications` directly; no trigger needed
- **`FOR UPDATE SKIP LOCKED`** — safe concurrent execution if Edge Function ever runs overlapping instances
- **Single Edge Function** — one entry point, one log stream, easy to extend with new reminder types

## Acceptance Criteria

- [ ] User enables dose reminder → push notification arrives at the configured time
- [ ] User disables reminder → no further notifications sent
- [ ] User changes reminder schedule → next notification fires at the new time
- [ ] Recurring reminder reschedules correctly after each send
- [ ] One-shot reminder fires once, is not repeated, and does not reappear in queue
- [ ] FCM token rotation does not break delivery
- [ ] No notification is sent twice for the same scheduled row
- [ ] Notification overdue by >30 minutes is skipped but rescheduled correctly
- [ ] Tapping a notification opens the correct screen (deep link)
- [ ] Disabling all `water_*` reminders silences the water channel on Android
- [ ] Existing `next_dose_at` / `dose_reminder_enabled` data migrates correctly into `reminders.dose`

## Implementation Checklist

- [ ] Migration: add `fcm_token` and `reminders` to `profiles`
- [ ] Migration: create `scheduled_notifications` table, index, and RLS policies
- [ ] Edge Function: `send-notifications` with rrule computation and FCM send
- [ ] `config.toml`: schedule `send-notifications` every minute
- [ ] Flutter: write `profiles.settings.timezone` on launch using `flutter_timezone`
- [ ] Flutter: token registration and refresh on auth
- [ ] Flutter: `flutter_local_notifications` setup with 8 Android notification channels
- [ ] Flutter: deep link handling via `onMessageOpenedApp` and `getInitialMessage`
- [ ] Flutter: update reminder screens to write `profiles.reminders` and sync `scheduled_notifications`
- [ ] Migration: migrate existing `next_dose_at` / `dose_reminder_enabled` → `reminders.dose` with `metadata`
- [ ] QA: test on iOS and Android (foreground, background, killed)
- [ ] QA: test 30-minute skip window behavior
- [ ] QA: test deep link routing for all reminder types

## Testing Plan

- **Unit:** rrule next-occurrence computation (Dart + Edge Function)
- **Integration:** Flutter saves reminder → queue row appears → Edge Function sends → row rescheduled
- **Manual QA:**
  - iOS: foreground, background, killed state
  - Android: foreground, background, killed state, Doze mode
  - Reminder disabled mid-cycle
  - Token refresh scenario
