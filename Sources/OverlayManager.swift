import AppKit

final class OverlayManager {
    private var windows: [NSScreen: OverlayWindow] = [:]

    func start() {
        rebuildWindows()
    }

    func stop() {
        windows.values.forEach { $0.orderOut(nil) }
        windows.removeAll()
    }

    func rebuildWindows() {
        let screens = NSScreen.screens

        // Remove missing screens
        for (screen, window) in windows where !screens.contains(screen) {
            window.close()
            windows.removeValue(forKey: screen)
        }

        // Create/update for current screens
        for screen in screens {
            if let window = windows[screen] {
                window.updateFrame(to: screen)
            } else {
                windows[screen] = OverlayWindow(screen: screen)
            }
        }
    }

    func showRipple(atScreenPoint p: NSPoint, color: NSColor) {
        guard let screen = screenContaining(p), let window = windows[screen] else { return }
        let local = NSPoint(x: p.x - screen.frame.origin.x, y: p.y - screen.frame.origin.y)
        window.showRipple(at: local, color: color)
    }

    func clearAllRipples() {
        windows.values.forEach { $0.clearRipples() }
    }

    private func screenContaining(_ p: NSPoint) -> NSScreen? {
        for s in NSScreen.screens { if s.frame.contains(p) { return s } }
        return NSScreen.screens.first
    }
}

