import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// 可能な限りDockを表示しない（LSUIElementと併用）
app.setActivationPolicy(.accessory)

app.run()

