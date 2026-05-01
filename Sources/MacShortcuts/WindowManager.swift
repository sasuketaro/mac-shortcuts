import Cocoa
import ApplicationServices

class WindowManager {
    static let shared = WindowManager()

    private init() {}

    func positionThisApp(window: NSWindow) {
        guard let screen = NSScreen.main else { return }
        let vf = screen.visibleFrame
        let width = floor(vf.width / 4)
        let frame = NSRect(x: vf.maxX - width, y: vf.minY, width: width, height: vf.height)
        window.setFrame(frame, display: true, animate: false)
    }

    func positionTargetApp(_ app: NSRunningApplication) {
        attempt(app, remaining: 4, delay: 0)
    }

    private func attempt(_ app: NSRunningApplication, remaining: Int, delay: TimeInterval) {
        guard remaining > 0 else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self else { return }
            if !self.applyFrame(to: app) {
                self.attempt(app, remaining: remaining - 1, delay: 0.6)
            }
        }
    }

    @discardableResult
    private func applyFrame(to app: NSRunningApplication) -> Bool {
        guard let screen = NSScreen.main else { return false }

        let axApp = AXUIElementCreateApplication(app.processIdentifier)
        var ref: CFTypeRef?
        guard AXUIElementCopyAttributeValue(axApp, kAXWindowsAttribute as CFString, &ref) == .success,
              let windows = ref as? [AXUIElement],
              let window = windows.first else { return false }

        let sf = screen.frame
        let vf = screen.visibleFrame

        // AX uses top-left origin; convert from NSScreen bottom-left origin
        let menuBarH = sf.height - vf.maxY

        var pos  = CGPoint(x: 0, y: menuBarH)
        var size = CGSize(width: floor(sf.width * 3 / 4), height: vf.height)

        guard let posVal  = AXValueCreate(.cgPoint, &pos),
              let sizeVal = AXValueCreate(.cgSize,  &size) else { return false }

        AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, posVal)
        AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString,     sizeVal)
        return true
    }
}
