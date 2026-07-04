#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT_DIR="$ROOT_DIR/releases"
ENV_FILE="$ROOT_DIR/supabase/.env.production"
PUBSPEC_FILE="$ROOT_DIR/pubspec.yaml"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing $ENV_FILE"
  echo "Create it from supabase/.env.production.example first."
  exit 1
fi

generate_localizations() {
  echo "Generating Flutter localizations..."
  flutter gen-l10n
}

set -a
source "$ENV_FILE"
set +a

if [[ -z "${SUPABASE_URL:-}" || -z "${SUPABASE_ANON_KEY:-}" ]]; then
  echo "SUPABASE_URL and SUPABASE_ANON_KEY are required in production env."
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

DART_DEFINES=(
  "--dart-define=SUPABASE_URL=${SUPABASE_URL}"
  "--dart-define=SUPABASE_ANON_KEY=${SUPABASE_ANON_KEY}"
  "--dart-define=AUTH_REDIRECT_URL=${AUTH_REDIRECT_URL:-https://myglu.health/signin-callback}"
  "--dart-define=REVENUECAT_API_KEY=${REVENUECAT_API_KEY:-}"
  "--dart-define=REVENUECAT_IOS_KEY=${REVENUECAT_IOS_KEY:-}"
  "--dart-define=REVENUECAT_ANDROID_KEY=${REVENUECAT_ANDROID_KEY:-}"
  "--dart-define=POSTHOG_API_KEY=${POSTHOG_API_KEY:-}"
  "--dart-define=POSTHOG_HOST=${POSTHOG_HOST:-https://us.i.posthog.com}"
  "--dart-define=GOOGLE_WEB_CLIENT_ID=${GOOGLE_WEB_CLIENT_ID:-}"
  "--dart-define=GOOGLE_IOS_CLIENT_ID=${GOOGLE_IOS_CLIENT_ID:-}"
)

get_current_version() {
  awk '/^version:/{print $2; exit}' "$PUBSPEC_FILE"
}

get_build_name() {
  local version
  version=$(get_current_version)
  echo "${version%%+*}"
}

get_build_number() {
  local version
  version=$(get_current_version)
  echo "${version##*+}"
}

get_version_name() {
  local version
  version=$(get_current_version)
  echo "glu-${version//+/-}"
}

bump_version() {
  local current_version
  current_version=$(get_current_version)
  local version_part="${current_version%%+*}"
  local build_part="${current_version##*+}"

  echo ""
  echo "Current version: $current_version"
  echo ""
  echo "How would you like to bump the version?"
  echo "  1) Patch (x.x.X) - bug fixes"
  echo "  2) Minor (x.X.0) - new features"
  echo "  3) Major (X.0.0) - breaking changes"
  echo "  4) Build number only (+X)"
  echo "  5) Skip - keep current version"
  echo "  6) Cancel - abort build"
  echo ""
  read -p "Select [1-6]: " -n 1 -r
  echo ""

  local major minor patch
  IFS='.' read -r major minor patch <<< "$version_part"
  local new_build=$((build_part + 1))

  case $REPLY in
    1) patch=$((patch + 1)) ;;
    2) minor=$((minor + 1)); patch=0 ;;
    3) major=$((major + 1)); minor=0; patch=0 ;;
    4) ;;
    5) echo "Keeping current version: $current_version"; return 0 ;;
    6) echo "Build cancelled."; exit 0 ;;
    *) echo "Invalid selection, keeping current version"; return 0 ;;
  esac

  local new_version="${major}.${minor}.${patch}+${new_build}"
  sed -i '' "s/^version: .*/version: $new_version/" "$PUBSPEC_FILE"
  echo "Version bumped: $current_version -> $new_version"
}

build_apk() {
  echo "Building Android APK..."
  generate_localizations
  flutter build apk --release \
    --build-name "$(get_build_name)" \
    --build-number "$(get_build_number)" \
    "${DART_DEFINES[@]}"
  cp "$ROOT_DIR/build/app/outputs/flutter-apk/app-release.apk" "$OUTPUT_DIR/$(get_version_name).apk"
  echo "Created: $OUTPUT_DIR/$(get_version_name).apk"
}

build_aab() {
  echo "Building Android App Bundle..."
  generate_localizations
  flutter build appbundle --release \
    --build-name "$(get_build_name)" \
    --build-number "$(get_build_number)" \
    "${DART_DEFINES[@]}"
  cp "$ROOT_DIR/build/app/outputs/bundle/release/app-release.aab" "$OUTPUT_DIR/$(get_version_name).aab"
  echo "Created: $OUTPUT_DIR/$(get_version_name).aab"
}

build_ipa() {
  local export_method="${1:-app-store}"
  echo "Building iOS IPA (export-method: $export_method)..."
  generate_localizations
  flutter build ipa --release \
    --build-name "$(get_build_name)" \
    --build-number "$(get_build_number)" \
    --export-method "$export_method" \
    "${DART_DEFINES[@]}"
  cp "$ROOT_DIR/build/ios/ipa/"*.ipa "$OUTPUT_DIR/$(get_version_name).ipa"
  echo "Created: $OUTPUT_DIR/$(get_version_name).ipa"
}

store_build() {
  local build_play=$1
  local build_app=$2

  echo "=== Glu Store Release ==="
  echo "Current version: $(get_current_version)"
  echo ""
  read -p "Would you like to bump the app version? (y/N) " -n 1 -r
  echo ""

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    bump_version
  fi

  echo ""
  echo "Cleaning build cache..."
  flutter clean
  echo "Fetching dependencies..."
  flutter pub get

  [[ "$build_play" == "true" ]] && build_aab
  [[ "$build_app" == "true" ]] && build_ipa app-store

  echo ""
  echo "Build complete: $(get_version_name)"
}

case "${1:-}" in
  apk)
    flutter clean && flutter pub get
    build_apk
    ;;
  ipa)
    flutter clean && flutter pub get
    build_ipa app-store
    ;;
  store-play)
    store_build true false
    ;;
  store-app)
    store_build false true
    ;;
  store|store-all)
    store_build true true
    ;;
  *)
    echo "Usage: ./scripts/release.sh {apk|ipa|store-play|store-app|store|store-all}"
    exit 1
    ;;
esac
