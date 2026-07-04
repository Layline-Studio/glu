# Testing Guide

## Purpose By Test Layer

### `Flutter static + app tests`
- Purpose: app correctness in Dart and Flutter UI/state logic.
- Folders:
  - `test/` for unit and widget tests
  - `integration_test/` for device and simulator integration tests
- Current state:
  - the folder structure exists, but most suites are still scaffolding placeholders

### `Supabase deterministic tests`
- Purpose: deterministic backend logic for edge functions and shared parsers.
- Folder: `supabase/test/`
- These tests do not evaluate model quality.
- Current suite:
  - `supabase/test/snap-macro/index.test.ts`

### `Eval tests (LLM quality)`
- Purpose: validate real LLM behavior against broad expectations from fixtures.
- Folder: `eval/test/`
- Uses fixtures from `eval/inputs/`
- These tests are not deterministic and require a running local Supabase function environment.
- Current suite:
  - `eval/test/snap-macro.ts`

## Quick Commands

### Flutter analysis
```bash
flutter analyze
```

### Flutter unit/widget tests
```bash
flutter test
```

### Flutter integration tests
```bash
# run all integration tests
flutter test integration_test/*.dart

# run a single integration test on a specific device
flutter test -d <device-id> integration_test/<test_file>.dart
```

## Supabase Deterministic Tests (`supabase/test`)

### Type-check the current deterministic suite
```bash
deno check supabase/test/snap-macro/index.test.ts
```

### Run the current deterministic suite
```bash
deno test --allow-read supabase/test/snap-macro/index.test.ts
```

## Eval Tests (`eval/test`)

Eval tests make real model-backed function calls and validate response shape and broad expectations.

### Setup
```bash
# 1. Start local Supabase
supabase start

# 2. Reset/apply migrations if needed
supabase db reset

# 3. Serve edge functions in a separate terminal
supabase functions serve --env-file supabase/.env --no-verify-jwt
```

### `snap-macro` evals

Add local image fixtures under:
```bash
eval/inputs/snap-macro/images/
```

These image files are intentionally gitignored. The committed JSON fixtures point at local image paths such as:
```bash
eval/inputs/snap-macro/images/basic-salad.jpg
```

Run the eval suite:
```bash
deno test --no-check --allow-read --allow-write --allow-net --allow-env eval/test/snap-macro.ts
```

Outputs are saved to:
```bash
eval/outputs/<timestamp>/snap-macro/
```

### `generate-insights` evals

Run the eval suite:
```bash
deno test --no-check --allow-read --allow-write --allow-net --allow-env eval/test/generate-insights.ts
```

Outputs are saved to:
```bash
eval/outputs/<timestamp>/generate-insights/
```

## Practical Notes

- Use `supabase/test/` for parser and validation logic that should be deterministic.
- Use `eval/test/` when you need to inspect real Gemini behavior and prompt quality.
- For `snap-macro`, avoid exact macro-value assertions in evals. Prefer broad checks like:
  - success vs failure
  - required fields present
  - non-negative macro values
  - reasonable calorie bounds for the fixture

## iOS Simulator Helpers

```bash
# list simulators
xcrun simctl list devices

# boot a simulator by UUID
xcrun simctl boot <simulator-uuid>
open -a Simulator

# list Flutter devices
flutter devices
```
