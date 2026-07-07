#!/usr/bin/env bash
# Generates sample doctor-report PDFs into build/report-preview and opens them.
# Usage: ./scripts/preview_report.sh [locale ...]   (default: en)
set -euo pipefail

cd "$(dirname "$0")/.."
OUT_DIR="$(pwd)/build/report-preview"

(cd supabase/functions && deno run --config deno.json --allow-read --allow-write \
  ../test/create-report/preview.ts "$OUT_DIR" "$@")

if command -v open >/dev/null; then
  open "$OUT_DIR"
fi
