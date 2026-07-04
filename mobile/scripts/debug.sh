#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./debug.sh virtual android <emulator_id_or_avd_name>  # Android emulator
#   ./debug.sh virtual ios <simulator_id>                 # iPhone simulator
#   ./debug.sh physical android <physical_id>             # Android physical
#   ./debug.sh physical ios <physical_id>                 # iPhone physical

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ENV_FILE="$ROOT_DIR/supabase/.env"
SUPABASE_DIR="$ROOT_DIR/supabase"
FUNCTIONS_ENV_FILE=""

show_usage() {
  echo "Usage: ./debug.sh <type> <platform> <device_id>"
  echo ""
  echo "  virtual android <emulator_id_or_avd_name>  - Run on Android emulator"
  echo "  virtual ios <simulator_id>                  - Run on iPhone simulator"
  echo "  physical android <physical_id>              - Run on Android physical"
  echo "  physical ios <physical_id>                  - Run on iPhone physical"
  echo ""
  echo "Examples:"
  echo "  ./debug.sh virtual android Pixel"
  echo "  ./debug.sh virtual android android-short-height"
  echo "  ./debug.sh virtual android android-narrow-width"
  echo "  ./debug.sh virtual android emulator-5554"
  echo "  ./debug.sh virtual ios 'iPhone 14'"
  echo "  ./debug.sh physical android 1A2B3C4D"
  echo "  ./debug.sh physical ios 00008110-001A19D92120A01E"
  exit 1
}

if [[ $# -lt 3 ]]; then
  show_usage
fi

TYPE="$1"
PLATFORM="$2"
DEVICE_ID="$3"

case "$DEVICE_ID" in
  ipad) DEVICE_ID="iPad Pro 13-inch (M5)" ;;
  iphone) DEVICE_ID="iPhone 14" ;;
  Pixel|pixel|android|android15) DEVICE_ID="Pixel_9_API_35" ;;
  android-short-height) DEVICE_ID="Android_35_Pixel_9_Pro_Fold" ;;
  android-narrow-width) DEVICE_ID="Android_35_Small_Phone" ;;
esac

if [[ "$TYPE" != "virtual" && "$TYPE" != "physical" ]]; then
  echo "Error: Invalid type '$TYPE'. Must be 'virtual' or 'physical'." >&2
  show_usage
fi

if [[ "$PLATFORM" != "android" && "$PLATFORM" != "ios" ]]; then
  echo "Error: Invalid platform '$PLATFORM'. Must be 'android' or 'ios'." >&2
  show_usage
fi

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
else
  echo "No supabase/.env found. Falling back to local Supabase CLI values where possible."
fi

AUTH_REDIRECT_URL="${AUTH_REDIRECT_URL:-glu://login-callback}"

generate_localizations() {
  echo "Generating Flutter localizations..."
  flutter gen-l10n
}

cleanup() {
  if [[ -n "${FUNCTIONS_PID:-}" ]]; then
    kill "$FUNCTIONS_PID" >/dev/null 2>&1 || true
  fi
  if [[ -n "${FUNCTIONS_ENV_FILE:-}" && -f "$FUNCTIONS_ENV_FILE" ]]; then
    rm -f "$FUNCTIONS_ENV_FILE" >/dev/null 2>&1 || true
  fi
  (cd "$ROOT_DIR" && supabase stop >/dev/null 2>&1) || true
  if [[ -n "${BOOTED_SIMULATOR_ID:-}" ]]; then
    xcrun simctl shutdown "$BOOTED_SIMULATOR_ID" >/dev/null 2>&1 || true
  fi
}

trap cleanup EXIT INT TERM

echo "Starting local Supabase stack..."
(cd "$ROOT_DIR" && supabase start)

if [[ -z "${SUPABASE_URL:-}" || -z "${SUPABASE_ANON_KEY:-}" || -z "${SUPABASE_SERVICE_ROLE_KEY:-}" || -z "${SUPABASE_SECRET_KEY:-}" ]]; then
  echo "Resolving local Supabase URL, anon key, service role key, and secret key from CLI status..."
  while IFS='=' read -r key value; do
    case "$key" in
      API_URL)
        if [[ -z "${SUPABASE_URL:-}" ]]; then
          SUPABASE_URL="$value"
        fi
        ;;
      ANON_KEY)
        if [[ -z "${SUPABASE_ANON_KEY:-}" ]]; then
          SUPABASE_ANON_KEY="$value"
        fi
        ;;
      SERVICE_ROLE_KEY)
        if [[ -z "${SUPABASE_SERVICE_ROLE_KEY:-}" ]]; then
          SUPABASE_SERVICE_ROLE_KEY="$value"
        fi
        ;;
      SECRET_KEY)
        if [[ -z "${SUPABASE_SECRET_KEY:-}" ]]; then
          SUPABASE_SECRET_KEY="$value"
        fi
        ;;
    esac
  done < <(cd "$ROOT_DIR" && supabase status -o env)
fi

if [[ -z "${SUPABASE_URL:-}" || -z "${SUPABASE_ANON_KEY:-}" || -z "${SUPABASE_SERVICE_ROLE_KEY:-}" || -z "${SUPABASE_SECRET_KEY:-}" ]]; then
  echo "Could not resolve SUPABASE_URL, SUPABASE_ANON_KEY, SUPABASE_SERVICE_ROLE_KEY, and SUPABASE_SECRET_KEY." >&2
  echo "Set them in supabase/.env or ensure 'supabase start' completed successfully." >&2
  exit 1
fi

# Local Supabase auth admin endpoints expect the newer secret key format
# (`sb_secret_...`). Reuse it as the function admin credential so edge
# functions can call auth.admin APIs reliably during local debug runs.
if [[ -n "${SUPABASE_SECRET_KEY:-}" ]]; then
  SUPABASE_SERVICE_ROLE_KEY="$SUPABASE_SECRET_KEY"
fi

APP_SUPABASE_URL="$SUPABASE_URL"

if [[ "$TYPE" == "virtual" && "$PLATFORM" == "android" ]]; then
  APP_SUPABASE_URL="${SUPABASE_URL/127.0.0.1/10.0.2.2}"
  APP_SUPABASE_URL="${APP_SUPABASE_URL/localhost/10.0.2.2}"
fi

resolve_host_ip_for_ios_physical() {
  local explicit_ip="${IOS_PHYSICAL_HOST_IP:-}"
  local default_interface=""
  local detected_ip=""

  if [[ -n "$explicit_ip" ]]; then
    echo "$explicit_ip"
    return 0
  fi

  default_interface="$(
    route -n get default 2>/dev/null | awk '/interface:/{print $2; exit}'
  )"

  if [[ -n "$default_interface" ]]; then
    detected_ip="$(ipconfig getifaddr "$default_interface" 2>/dev/null || true)"
  fi

  if [[ -z "$detected_ip" ]]; then
    detected_ip="$(
      ifconfig 2>/dev/null | awk '
        /^[a-z0-9]/ { iface=$1; sub(":", "", iface) }
        /inet / && $2 != "127.0.0.1" && iface !~ /^(lo0|utun|awdl|llw|bridge)/ {
          print $2
          exit
        }
      '
    )"
  fi

  if [[ -n "$detected_ip" ]]; then
    echo "$detected_ip"
    return 0
  fi

  return 1
}

if [[ "$TYPE" == "physical" && "$PLATFORM" == "ios" ]]; then
  if [[ "$SUPABASE_URL" == *"127.0.0.1"* || "$SUPABASE_URL" == *"localhost"* ]]; then
    IOS_HOST_IP="$(resolve_host_ip_for_ios_physical || true)"
    if [[ -z "${IOS_HOST_IP:-}" ]]; then
      echo "Error: Could not resolve this Mac's LAN IP for a physical iPhone run." >&2
      echo "Set IOS_PHYSICAL_HOST_IP=<your-mac-lan-ip> and rerun the script." >&2
      exit 1
    fi

    APP_SUPABASE_URL="${SUPABASE_URL/127.0.0.1/$IOS_HOST_IP}"
    APP_SUPABASE_URL="${APP_SUPABASE_URL/localhost/$IOS_HOST_IP}"

    echo "Using LAN-accessible Supabase URL for physical iPhone: $APP_SUPABASE_URL"
    echo "Make sure the iPhone and this Mac are on the same network."
  fi
fi

if [[ "$PLATFORM" == "android" || "$PLATFORM" == "ios" ]]; then
  AUTH_REDIRECT_URL="glu://login-callback"
fi

FUNCTIONS_ENV_FILE="$(mktemp /tmp/glu-functions-env.XXXXXX)"
if [[ -f "$ENV_FILE" ]]; then
  cp "$ENV_FILE" "$FUNCTIONS_ENV_FILE"
else
  : > "$FUNCTIONS_ENV_FILE"
fi

SUPABASE_URL="$SUPABASE_URL" \
SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY" \
SUPABASE_SERVICE_ROLE_KEY="$SUPABASE_SERVICE_ROLE_KEY" \
SUPABASE_SECRET_KEY="$SUPABASE_SECRET_KEY" \
SECRET_KEY="$SUPABASE_SECRET_KEY" \
python3 - "$FUNCTIONS_ENV_FILE" <<'PY'
import sys
import os
from pathlib import Path

path = Path(sys.argv[1])
existing = {}
if path.exists():
    for line in path.read_text().splitlines():
        if "=" in line and not line.lstrip().startswith("#"):
            key, value = line.split("=", 1)
            existing[key] = value

updates = {
    "SUPABASE_URL": os.environ["SUPABASE_URL"],
    "SUPABASE_ANON_KEY": os.environ["SUPABASE_ANON_KEY"],
    "SUPABASE_SERVICE_ROLE_KEY": os.environ["SUPABASE_SERVICE_ROLE_KEY"],
    "SUPABASE_SECRET_KEY": os.environ["SUPABASE_SECRET_KEY"],
    "SECRET_KEY": os.environ["SECRET_KEY"],
}
existing.update(updates)
path.write_text("".join(f"{k}={v}\n" for k, v in existing.items()))
PY

wait_for_supabase_auth() {
  local url="${SUPABASE_URL}/auth/v1/health"
  local timeout_seconds=30
  local waited=0
  echo "Waiting for Supabase auth to be ready..."
  while (( waited < timeout_seconds )); do
    if curl -sf "$url" >/dev/null 2>&1; then
      echo "Supabase auth is ready."
      return 0
    fi
    sleep 1
    waited=$((waited + 1))
  done
  echo "Warning: Supabase auth did not respond within ${timeout_seconds}s. Continuing anyway." >&2
}

wait_for_supabase_auth

echo "Starting edge functions..."
(
  cd "$SUPABASE_DIR"
  if [[ -f "$FUNCTIONS_ENV_FILE" ]]; then
    supabase functions serve --env-file "$FUNCTIONS_ENV_FILE" --no-verify-jwt
  else
    supabase functions serve --no-verify-jwt
  fi
) &
FUNCTIONS_PID=$!

boot_simulator() {
  local simulator_id="$1"
  xcrun simctl boot "$simulator_id" >/dev/null 2>&1 || true
  open -a Simulator >/dev/null 2>&1 || true
  BOOTED_SIMULATOR_ID="$simulator_id"
  echo "Waiting for simulator $simulator_id to finish booting..."
  xcrun simctl bootstatus "$simulator_id" -b >/dev/null 2>&1 || true
  echo "Simulator ready."
}

resolve_android_device_id() {
  local requested="$1"
  local serial=""
  local name=""
  local timeout_seconds=180
  local waited=0

  if [[ "$requested" =~ ^emulator-[0-9]+$ ]]; then
    echo "$requested"
    return 0
  fi

  if ! command -v emulator >/dev/null 2>&1; then
    echo "Android emulator command not found. Install Android SDK emulator tools." >&2
    return 1
  fi

  if ! command -v adb >/dev/null 2>&1; then
    echo "adb command not found. Install Android platform-tools." >&2
    return 1
  fi

  emulator -avd "$requested" >/dev/null 2>&1 &

  while (( waited < timeout_seconds )); do
    while IFS= read -r serial; do
      [[ -z "$serial" ]] && continue
      name="$(adb -s "$serial" emu avd name 2>/dev/null | tr -d '\r' | head -n 1 || true)"
      if [[ "$name" == "$requested" ]]; then
        BOOTED_ANDROID_EMULATOR_ID="$serial"
        echo "$serial"
        return 0
      fi
    done < <(adb devices | awk '/^emulator-[0-9]+\tdevice$/{print $1}')

    sleep 2
    waited=$((waited + 2))
  done

  echo "Timed out waiting for Android emulator AVD '$requested' to become ready." >&2
  return 1
}

wake_and_unlock_android() {
  local device_id="$1"
  adb -s "$device_id" shell input keyevent 224 >/dev/null 2>&1 || true
  sleep 1
  adb -s "$device_id" shell wm dismiss-keyguard >/dev/null 2>&1 || true
  sleep 1
}

warn_if_api36_user_build() {
  local device_id="$1"
  local api_level build_type
  api_level="$(adb -s "$device_id" shell getprop ro.build.version.sdk 2>/dev/null | tr -d '\r')"
  build_type="$(adb -s "$device_id" shell getprop ro.system.build.type 2>/dev/null | tr -d '\r')"
  if [[ "$api_level" == "36" && "$build_type" == "user" ]]; then
    echo "" >&2
    echo "Error: Android 16 (API 36) 'user' build detected." >&2
    echo "Flutter debug launch is broken on this emulator: Android blocks" >&2
    echo "Flutter's debug am-start flow and reports a misleading" >&2
    echo "\"Activity class does not exist\" error." >&2
    echo "" >&2
    echo "Use the Android 15 emulator instead:" >&2
    echo "  ./debug.sh virtual android android15" >&2
    echo "" >&2
    return 1
  fi
}

resolve_ios_simulator_id() {
  local name="$1"
  local udid
  udid="$(xcrun simctl list devices --json 2>/dev/null | python3 -c "
import json, sys
name = '$name'
data = json.load(sys.stdin)
for runtime, devices in data.get('devices', {}).items():
    for d in devices:
        if d.get('name') == name and d.get('isAvailable', False):
            print(d['udid'])
            sys.exit(0)
sys.exit(1)
" 2>/dev/null || true)"
  if [[ -z "$udid" ]]; then
    echo "Error: Could not find an available iOS simulator named '$name'." >&2
    echo "       Run 'xcrun simctl list devices' to see available simulators." >&2
    return 1
  fi
  echo "$udid"
}

enable_arm64_simulator_builds() {
  local generated_xcconfig="$ROOT_DIR/ios/Flutter/Generated.xcconfig"
  local pods_support_dir="$ROOT_DIR/ios/Pods/Target Support Files"

  if [[ "$(uname -m)" != "arm64" ]]; then
    return 0
  fi

  echo "Allowing arm64 iOS simulator builds on Apple Silicon..."
  python3 - "$generated_xcconfig" "$pods_support_dir" <<'PY'
from pathlib import Path
import re
import sys

generated_path = Path(sys.argv[1])
pods_support_dir = Path(sys.argv[2])

if generated_path.exists():
    text = generated_path.read_text()
    text = re.sub(
        r'^EXCLUDED_ARCHS\[sdk=iphonesimulator\*\]=i386 arm64$',
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]=i386',
        text,
        flags=re.MULTILINE,
    )
    generated_path.write_text(text)

if pods_support_dir.exists():
    for path in pods_support_dir.rglob('*.debug.xcconfig'):
        text = path.read_text()
        updated = re.sub(
            r'^VALID_ARCHS\[sdk=iphonesimulator\*\] = x86_64$',
            'VALID_ARCHS[sdk=iphonesimulator*] = $(ARCHS_STANDARD)',
            text,
            flags=re.MULTILINE,
        )
        if updated != text:
            path.write_text(updated)
PY
}

if [[ "$TYPE" == "virtual" && "$PLATFORM" == "ios" ]]; then
  DEVICE_ID="$(resolve_ios_simulator_id "$DEVICE_ID")"
  boot_simulator "$DEVICE_ID"
fi

if [[ "$TYPE" == "virtual" && "$PLATFORM" == "android" ]]; then
  DEVICE_ID="$(resolve_android_device_id "$DEVICE_ID")"
  wake_and_unlock_android "$DEVICE_ID"
  warn_if_api36_user_build "$DEVICE_ID"
fi

if [[ "$PLATFORM" == "android" ]]; then
  if [[ "$SUPABASE_URL" == *"127.0.0.1"* || "$SUPABASE_URL" == *"localhost"* ]]; then
    if command -v adb >/dev/null 2>&1; then
      adb -s "$DEVICE_ID" reverse tcp:54321 tcp:54321 >/dev/null 2>&1 || true
    fi
  fi
fi

DART_DEFINES=(
  --dart-define=SUPABASE_URL="$APP_SUPABASE_URL"
  --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
  --dart-define=AUTH_REDIRECT_URL="$AUTH_REDIRECT_URL"
  --dart-define=REVENUECAT_API_KEY="${REVENUECAT_API_KEY:-}"
  --dart-define=REVENUECAT_IOS_KEY="${REVENUECAT_IOS_KEY:-}"
  --dart-define=REVENUECAT_ANDROID_KEY="${REVENUECAT_ANDROID_KEY:-}"
  --dart-define=POSTHOG_API_KEY="${POSTHOG_API_KEY:-}"
  --dart-define=POSTHOG_HOST="${POSTHOG_HOST:-https://us.i.posthog.com}"
  --dart-define=GOOGLE_WEB_CLIENT_ID="${GOOGLE_WEB_CLIENT_ID:-}"
  --dart-define=GOOGLE_IOS_CLIENT_ID="${GOOGLE_IOS_CLIENT_ID:-}"
)

cd "$ROOT_DIR"

generate_localizations

if [[ "$TYPE" == "virtual" && "$PLATFORM" == "ios" ]]; then
  enable_arm64_simulator_builds
  flutter build ios --simulator --debug "${DART_DEFINES[@]}"

  APP_PATH="$ROOT_DIR/build/ios/iphonesimulator/Runner.app"
  if [[ ! -d "$APP_PATH" ]]; then
    echo "Error: simulator .app not found at $APP_PATH" >&2
    exit 1
  fi

  xcrun simctl install "$DEVICE_ID" "$APP_PATH"

  echo ""
  echo "  r  = hot reload  |  R = hot restart  |  q = detach (Supabase stays up)"
  echo "  After detaching, press Enter to re-attach."
  echo ""
  while true; do
    (sleep 2 && xcrun simctl launch "$DEVICE_ID" ventures.layline.glu >/dev/null 2>&1) &
    LAUNCH_PID=$!
    flutter attach -d "$DEVICE_ID" "${DART_DEFINES[@]}" || true
    kill "$LAUNCH_PID" 2>/dev/null || true
    echo ""
    echo "Flutter detached. Press Enter to re-attach, or Ctrl+C to exit..."
    read -r || break
  done
else
  echo "  r  = hot reload  |  R = hot restart  |  q = quit Flutter (Supabase stays up)"
  echo "  After quitting, press Enter to restart Flutter."
  echo ""
  while true; do
    flutter run -d "$DEVICE_ID" \
      --debug -v \
      "${DART_DEFINES[@]}" || true
    echo ""
    echo "Flutter exited. Press Enter to restart, or Ctrl+C to exit..."
    read -r || break
  done
fi
