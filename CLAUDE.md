# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ClickPulse is a lightweight macOS menu bar application that displays visual ripple effects at mouse click locations. The app is written in Swift and uses native macOS frameworks (AppKit, QuartzCore) without any external dependencies.

## Build Commands

Build the application:
```bash
chmod +x scripts/build.sh
./scripts/build.sh
```

This creates `ClickPulse.app` in the project root. The build script:
- Compiles all Swift sources using `xcrun swiftc`
- Creates a proper .app bundle with Info.plist
- Links against AppKit and QuartzCore frameworks

Run the application:
```bash
open ClickPulse.app
```

## Architecture

The application uses a multi-window overlay system to display click effects across all displays:

### Core Components

- **main.swift** - Application entry point, creates NSApplication and AppDelegate
- **AppDelegate.swift** - Main application controller, manages menu bar item and global mouse event monitoring
- **OverlayManager.swift** - Coordinates overlay windows across multiple displays, handles screen configuration changes
- **OverlayWindow.swift** - Transparent, always-on-top windows positioned over each display
- **OverlayView.swift** - Custom NSView that hosts CALayer animations for ripple effects
- **RippleLayer.swift** - CALayer subclass that implements the animated ripple effect using Core Animation

### Key Design Patterns

- **Global Event Monitoring**: Uses `NSEvent.addGlobalMonitorForEvents` to capture mouse clicks system-wide without requiring accessibility permissions
- **Multi-Display Support**: Creates one overlay window per display, automatically adapts to screen configuration changes
- **Background App**: Configured as `LSUIElement` in Info.plist to run without dock icon
- **Color-Coded Clicks**: Left clicks = yellow, right clicks = blue, other clicks = pink

### Event Flow

1. Global mouse monitor captures click events
2. AppDelegate determines click type and converts screen coordinates
3. OverlayManager finds appropriate display and window
4. OverlayView creates and animates RippleLayer at click location
5. Animation auto-removes after 0.4 seconds

## Development Notes

- No testing framework is configured - this is a simple GUI application
- No linting tools are set up - uses standard Swift with xcrun compiler
- Color/size/timing constants are hardcoded in OverlayView.swift and AppDelegate.swift
- Minimum macOS version: 10.15 (configured in Info.plist)
- Uses SF Symbols for menu bar icon on macOS 11+, fallback text on older versions