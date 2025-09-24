# ClickPulse (macOS)

English | [日本語](README.ja.md)

A lightweight macOS menu bar app that shows a clear ring at the cursor when you click.

Features
- Shows a ring at the click position for 0.4 seconds on left/right/other clicks
- Left click = yellow, right click = blue, other = pink
- Supports multiple displays (transparent overlay window on each screen)
- Toggle enable/disable and quit from the menu bar
- No extra permissions required (uses `NSEvent` global monitor)

Requirements
- macOS 10.15 or later (recommended: 11+)
- Xcode Command Line Tools (`xcrun` and `swiftc`)

Build
```
chmod +x scripts/build.sh
./scripts/build.sh
```
Output: `ClickPulse.app`

Run
```
open ClickPulse.app
```

First Launch Note
- Because the app is not signed/notarized by Apple, Gatekeeper may show a warning. To proceed, right‑click the app and choose “Open”.

Customization (optional)
- Initial color/size/animation duration are defined as constants in code. If you want to change them, edit `Sources/OverlayView.swift` and `Sources/AppDelegate.swift`, then rebuild.

Structure
- `Sources/main.swift` — Application entry point
- `Sources/AppDelegate.swift` — Menu bar and event monitoring control
- `Sources/OverlayManager.swift` — Manages overlays per display
- `Sources/OverlayWindow.swift` — Transparent always-on-top window
- `Sources/OverlayView.swift` — Ring drawing/animation implementation
- `Sources/RippleLayer.swift` — CALayer animation
- `Resources/Info.plist` — App bundle settings (`LSUIElement` hides Dock)
- `scripts/build.sh` — Build and .app packaging script

Uninstall
- Simply delete the folder.
