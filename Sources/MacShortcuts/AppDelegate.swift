import Cocoa
import SwiftUI
import ApplicationServices

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    private var appObserver: Any?

    func applicationDidFinishLaunching(_ notification: Notification) {
        requestAccessibility()
        setupWindow()
        startMonitoring()
    }

    private func requestAccessibility() {
        let opts = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as String: true] as CFDictionary
        AXIsProcessTrustedWithOptions(opts)
    }

    private func setupWindow() {
        guard let screen = NSScreen.main else { return }
        let vf = screen.visibleFrame
        let width = floor(vf.width / 4)

        let contentView = ContentView().environmentObject(AppState.shared)

        window = NSWindow(
            contentRect: NSRect(x: vf.maxX - width, y: vf.minY, width: width, height: vf.height),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Mac Shortcuts"
        window.contentView = NSHostingView(rootView: contentView)
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .stationary]
        window.isReleasedWhenClosed = false
        window.makeKeyAndOrderFront(nil)
    }

    private func startMonitoring() {
        let ownPid = ProcessInfo.processInfo.processIdentifier

        appObserver = NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didActivateApplicationNotification,
            object: nil,
            queue: .main
        ) { notification in
            guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
                  app.processIdentifier != ownPid,
                  app.activationPolicy == .regular else { return }

            AppState.shared.updateTargetApp(app)
            WindowManager.shared.positionTargetApp(app)
        }
    }

    func applicationWillTerminate(_ notification: Notification) {
        if let obs = appObserver {
            NSWorkspace.shared.notificationCenter.removeObserver(obs)
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
}
