import AppKit

final class OverlayView: NSView {
    // 既定値（必要に応じて調整）
    private let defaultRadius: CGFloat = 40
    private let defaultLineWidth: CGFloat = 6
    private let defaultDuration: CFTimeInterval = 0.4

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.masksToBounds = true
        layerContentsRedrawPolicy = .onSetNeedsDisplay
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showRipple(at point: NSPoint, color: NSColor) {
        guard let layer = self.layer else { return }
        let ripple = RippleLayer(center: point,
                                 radius: defaultRadius,
                                 lineWidth: defaultLineWidth,
                                 color: color)
        layer.addSublayer(ripple)
        ripple.animateAndRemove(after: defaultDuration)
    }

    func clearRipples() {
        layer?.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
}

