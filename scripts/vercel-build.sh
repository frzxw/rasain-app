#!/usr/bin/env bash
# Builds the Flutter web demo for Vercel. No GitHub Actions required.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

FLUTTER_VERSION="${FLUTTER_VERSION:-3.29.3}"
FLUTTER_ROOT="${FLUTTER_ROOT:-$HOME/flutter}"

if ! command -v flutter >/dev/null 2>&1; then
  if [ ! -x "$FLUTTER_ROOT/bin/flutter" ]; then
    mkdir -p "$(dirname "$FLUTTER_ROOT")"
    TMP="$(mktemp -d)"
    curl -fsSL -o "$TMP/flutter.tar.xz" \
      "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
    tar -xJf "$TMP/flutter.tar.xz" -C "$(dirname "$FLUTTER_ROOT")"
    rm -rf "$TMP"
    if [ "$(dirname "$FLUTTER_ROOT")/flutter" != "$FLUTTER_ROOT" ]; then
      mv "$(dirname "$FLUTTER_ROOT")/flutter" "$FLUTTER_ROOT"
    fi
  fi
  export PATH="$FLUTTER_ROOT/bin:$PATH"
fi

flutter config --enable-web --no-analytics >/dev/null
flutter --version

if [ ! -f .env ]; then
  cp .env.example .env
fi

flutter pub get
flutter build web --release --dart-define=DEMO_MODE=true
