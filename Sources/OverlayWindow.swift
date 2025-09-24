import AppKit

final class OverlayWindow: NSWindow {
    private let overlayView = OverlayView()

    init(screen: NSScreen) {
        let frame = screen.frame
        super.init(contentRect: frame, styleMask: .borderless, backing: .buffered, defer: false)
        isOpaque = false
        backgroundColor = .clear
        ignoresMouseEvents = true
        hasShadow = false
        collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        level = .screenSaver
        contentView = overlayView
        makeKeyAndOrderFront(nil)
        orderFrontRegardless()
    }

    func updateFrame(to screen: NSScreen) {
        setFrame(screen.frame, display: true)
    }

    func showRipple(at point: NSPoint, color: NSColor) {
        overlayView.showRipple(at: point, color: color)
    }

    func clearRipples() {
        overlayView.clearRipples()
    }
}

