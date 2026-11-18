#!/usr/bin/env bash
# PolyLingo AI: download a pinned Android build toolchain and build a debug APK.
# Requires Linux x86_64, Java 17+, curl, unzip, sha256sum, and working internet.
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLS="$ROOT/.build-tools"
SDK="$TOOLS/android-sdk"
DL="$TOOLS/downloads"
GRADLE_VERSION="8.9"
GRADLE_SHA256="d725d707bfabd4dfdc958c624003b3c80accc03f7037b5122c4b1d0ef15cecab"
CMDLINE_BUILD="15859902"
CMDLINE_SHA256="4e4c464f145a7512b57d088ac6c278c03c9eea610886b35a5e0804e74eedf583"

fail() { echo "ERROR: $*" >&2; exit 1; }
need() { command -v "$1" >/dev/null 2>&1 || fail "Required command missing: $1"; }
need java
need curl
need unzip
need sha256sum

JAVA_BIN="$(readlink -f "$(command -v java)")"
JAVA_HOME_DETECTED="$(dirname "$(dirname "$JAVA_BIN")")"
JAVA_MAJOR="$("$JAVA_BIN" -version 2>&1 | awk -F '[\".]' '/version/ {print $2; exit}')"
[[ "${JAVA_MAJOR:-0}" -ge 17 ]] || fail "JDK 17 or newer is required. Detected Java ${JAVA_MAJOR:-unknown}."
export JAVA_HOME="${JAVA_HOME:-$JAVA_HOME_DETECTED}"
export PATH="$JAVA_HOME/bin:$PATH"

mkdir -p "$DL" "$SDK/cmdline-tools" "$TOOLS/gradle"
cd "$DL"

echo "[1/6] Downloading Android command-line tools..."
CMD_ZIP="commandlinetools-linux-${CMDLINE_BUILD}_latest.zip"
if [[ ! -s "$CMD_ZIP" ]]; then
  curl --fail --location --retry 3 --retry-delay 2 \
    "https://dl.google.com/android/repository/${CMD_ZIP}" -o "$CMD_ZIP"
fi
echo "${CMDLINE_SHA256}  ${CMD_ZIP}" | sha256sum --check --status \
  || fail "Android command-line tools checksum mismatch."
TMP_CMD="$TOOLS/cmdline-tools-unpack"
rm -rf "$TMP_CMD"
mkdir -p "$TMP_CMD"
unzip -q -o "$CMD_ZIP" -d "$TMP_CMD"
[[ -x "$TMP_CMD/cmdline-tools/bin/sdkmanager" ]] \
  || fail "Unexpected Android command-line tools archive layout."
rm -rf "$SDK/cmdline-tools/latest"
mv "$TMP_CMD/cmdline-tools" "$SDK/cmdline-tools/latest"
rm -rf "$TMP_CMD"

echo "[2/6] Downloading Gradle ${GRADLE_VERSION}..."
GRADLE_ZIP="gradle-${GRADLE_VERSION}-bin.zip"
if [[ ! -s "$GRADLE_ZIP" ]]; then
  curl --fail --location --retry 3 --retry-delay 2 \
    "https://services.gradle.org/distributions/${GRADLE_ZIP}" -o "$GRADLE_ZIP"
fi
echo "${GRADLE_SHA256}  ${GRADLE_ZIP}" | sha256sum --check --status \
  || fail "Gradle distribution checksum mismatch."
unzip -q -o "$GRADLE_ZIP" -d "$TOOLS/gradle"
GRADLE="$TOOLS/gradle/gradle-${GRADLE_VERSION}/bin/gradle"
[[ -x "$GRADLE" ]] || fail "Gradle installation did not complete."

echo "[3/6] Preparing Android SDK environment..."
export ANDROID_HOME="$SDK"
export ANDROID_SDK_ROOT="$SDK"
export PATH="$SDK/cmdline-tools/latest/bin:$SDK/platform-tools:$PATH"
SDKMANAGER="$SDK/cmdline-tools/latest/bin/sdkmanager"

echo "[4/6] Accepting Android SDK licenses and installing build packages..."
yes | "$SDKMANAGER" --sdk_root="$SDK" --licenses >/dev/null
"$SDKMANAGER" --sdk_root="$SDK" --install \
  "platform-tools" \
  "platforms;android-35" \
  "build-tools;35.0.0"

echo "[5/6] Running project checks and Android build..."
python3 "$ROOT/scripts/check_project.py"
cd "$ROOT"
"$GRADLE" --no-daemon --stacktrace --warning-mode all \
  testDebugUnitTest assembleDebug

APK="$ROOT/app/build/outputs/apk/debug/app-debug.apk"
[[ -s "$APK" ]] || fail "Gradle finished but APK was not found: $APK"

echo "[6/6] Copying and hashing APK..."
mkdir -p "$ROOT/dist"
cp "$APK" "$ROOT/dist/PolyLingo_AI_v0.1.1-debug.apk"
(cd "$ROOT/dist" && sha256sum PolyLingo_AI_v0.1.1-debug.apk > SHA256SUMS.txt)

echo
echo "BUILD SUCCESS"
echo "APK: $ROOT/dist/PolyLingo_AI_v0.1.1-debug.apk"
echo "SHA256: $(sha256sum "$ROOT/dist/PolyLingo_AI_v0.1.1-debug.apk" | awk '{print $1}')"
