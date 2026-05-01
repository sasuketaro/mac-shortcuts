import Cocoa
import Combine

class AppState: ObservableObject {
    static let shared = AppState()

    @Published var targetApp: NSRunningApplication?
    @Published var shortcutGroups: [ShortcutGroup] = []

    private init() {}

    func updateTargetApp(_ app: NSRunningApplication) {
        targetApp = app
        shortcutGroups = ShortcutsDatabase.shared.shortcuts(for: app)
    }
}
