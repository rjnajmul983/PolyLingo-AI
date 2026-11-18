#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if [ -x ./gradlew ]; then
  GRADLE=./gradlew
elif command -v gradle >/dev/null 2>&1; then
  GRADLE=gradle
else
  echo "Missing Gradle. Use Android Studio with Gradle 8.9 or GitHub Actions (.github/workflows/android.yml)." >&2
  exit 2
fi
if [ -z "${ANDROID_HOME:-${ANDROID_SDK_ROOT:-}}" ]; then
  echo "Android SDK location not set (ANDROID_HOME or ANDROID_SDK_ROOT)." >&2
  exit 3
fi
"$GRADLE" --no-daemon --stacktrace testDebugUnitTest assembleDebug
APK=app/build/outputs/apk/debug/app-debug.apk
[ -s "$APK" ] || { echo "Build did not produce APK: $APK" >&2; exit 4; }
mkdir -p dist
cp "$APK" dist/PolyLingo_AI_v0.1.1-debug.apk
(cd dist && sha256sum PolyLingo_AI_v0.1.1-debug.apk > SHA256SUMS.txt)
echo "APK: dist/PolyLingo_AI_v0.1.1-debug.apk"
