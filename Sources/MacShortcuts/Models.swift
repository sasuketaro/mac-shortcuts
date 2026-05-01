import Foundation

struct Shortcut: Identifiable {
    let id = UUID()
    let command: String
    let description: String
}

struct ShortcutGroup: Identifiable {
    let id = UUID()
    let category: String
    let shortcuts: [Shortcut]
}
