#!/usr/bin/env bash
set -euo pipefail

APP_NAME="ClickPulse"
BUILD_DIR="build"
APP_DIR="$APP_NAME.app"

rm -rf "$BUILD_DIR" "$APP_DIR"
mkdir -p "$BUILD_DIR"

echo "Compiling sources…"
xcrun swiftc \
  -O \
  -framework AppKit \
  -framework QuartzCore \
  Sources/main.swift \
  Sources/AppDelegate.swift \
  Sources/OverlayManager.swift \
  Sources/OverlayWindow.swift \
  Sources/OverlayView.swift \
  Sources/RippleLayer.swift \
  -o "$BUILD_DIR/$APP_NAME"

echo "Bundling .app…"
mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources"
cp Resources/Info.plist "$APP_DIR/Contents/Info.plist"
cp "$BUILD_DIR/$APP_NAME" "$APP_DIR/Contents/MacOS/$APP_NAME"
chmod +x "$APP_DIR/Contents/MacOS/$APP_NAME"

echo "Done: $APP_DIR"

