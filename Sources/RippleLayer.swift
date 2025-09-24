import AppKit
import QuartzCore

final class RippleLayer: CAShapeLayer {
    init(center: NSPoint, radius: CGFloat, lineWidth: CGFloat, color: NSColor) {
        super.init()

        // このレイヤのフレームをリング領域に合わせる
        let frameRect = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
        self.frame = frameRect

        // パスはレイヤのbounds基準
        let inset = lineWidth / 2.0
        self.path = CGPath(ellipseIn: self.bounds.insetBy(dx: inset, dy: inset), transform: nil)

        self.fillColor = NSColor.clear.cgColor
        self.strokeColor = color.cgColor
        self.lineWidth = lineWidth
        self.opacity = 0.9
        self.masksToBounds = false
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func animateAndRemove(after duration: CFTimeInterval) {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 0.8
        scale.toValue = 1.15
        scale.duration = duration
        scale.timingFunction = CAMediaTimingFunction(name: .easeOut)

        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.8
        fade.toValue = 0.0
        fade.duration = duration
        fade.timingFunction = CAMediaTimingFunction(name: .easeOut)

        let group = CAAnimationGroup()
        group.animations = [scale, fade]
        group.duration = duration
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.removeFromSuperlayer()
        }
        add(group, forKey: "ripple")
        CATransaction.commit()
    }
}

