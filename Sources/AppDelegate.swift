import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var toggleItem: NSMenuItem!
    private var globalMonitor: Any?
    private let overlayManager = OverlayManager()
    private var enabled = true

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusItem()
        overlayManager.start()
        startMonitoring()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screensChanged),
            name: NSApplication.didChangeScreenParametersNotification,
            object: nil
        )
    }

    func applicationWillTerminate(_ notification: Notification) {
        stopMonitoring()
        overlayManager.stop()
    }

    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            if #available(macOS 11.0, *) {
                button.image = NSImage(systemSymbolName: "cursorarrow.rays", accessibilityDescription: "ClickPulse")
            } else {
                button.title = "◎"
                button.font = NSFont.systemFont(ofSize: 13)
            }
        }

        let menu = NSMenu()
        toggleItem = NSMenuItem(title: "Enable Click Highlighting", action: #selector(toggleEnabled(_:)), keyEquivalent: "")
        toggleItem.state = enabled ? .on : .off
        toggleItem.target = self
        menu.addItem(toggleItem)
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "Quit ClickPulse", action: #selector(quit), keyEquivalent: "q"))
        statusItem.menu = menu
    }

    @objc private func toggleEnabled(_ sender: Any?) {
        enabled.toggle()
        toggleItem.state = enabled ? .on : .off
        if enabled {
            startMonitoring()
        } else {
            stopMonitoring()
            overlayManager.clearAllRipples()
        }
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }

    private func startMonitoring() {
        stopMonitoring()
        let mask: NSEvent.EventTypeMask = [.leftMouseDown, .rightMouseDown, .otherMouseDown]
        globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: mask) { [weak self] event in
            self?.handle(event: event)
        }
    }

    private func stopMonitoring() {
        if let gm = globalMonitor {
            NSEvent.removeMonitor(gm)
            globalMonitor = nil
        }
    }

    @objc private func screensChanged() {
        overlayManager.rebuildWindows()
    }

    private func handle(event: NSEvent) {
        guard enabled else { return }

        let location = NSEvent.mouseLocation
        let color: NSColor
        switch event.type {
        case .leftMouseDown:
            color = .systemYellow
        case .rightMouseDown:
            color = .systemBlue
        case .otherMouseDown:
            color = .systemPink
        default:
            color = .systemYellow
        }

        overlayManager.showRipple(atScreenPoint: location, color: color)
    }
}

