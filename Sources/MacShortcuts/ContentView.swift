import SwiftUI
import AppKit

struct ContentView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            if state.shortcutGroups.isEmpty {
                emptyState
            } else {
                shortcutList
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(NSColor.controlBackgroundColor))
    }

    // MARK: Header
    private var header: some View {
        HStack(spacing: 8) {
            if let icon = state.targetApp?.icon {
                Image(nsImage: icon)
                    .resizable()
                    .frame(width: 18, height: 18)
            }
            Text(state.targetApp?.localizedName ?? "Mac Shortcuts")
                .font(.headline)
                .lineLimit(1)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(NSColor.windowBackgroundColor))
    }

    // MARK: Empty
    private var emptyState: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "keyboard")
                .font(.system(size: 36))
                .foregroundColor(.secondary)
            Text("別のアプリをアクティブにすると\nショートカットが表示されます")
                .font(.callout)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }

    // MARK: List
    private var shortcutList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                ForEach(state.shortcutGroups) { group in
                    Section(header: sectionHeader(group.category)) {
                        ForEach(group.shortcuts) { s in
                            ShortcutRow(shortcut: s)
                            Divider().padding(.leading, 12)
                        }
                    }
                }
            }
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(Color(NSColor.controlBackgroundColor))
    }
}

// MARK: Row
struct ShortcutRow: View {
    let shortcut: Shortcut
    @State private var hovered = false

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            Text(shortcut.command)
                .font(.system(.callout, design: .monospaced))
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
                .frame(minWidth: 84, alignment: .leading)
            Text("→")
                .font(.caption)
                .foregroundColor(.secondary)
            Text(shortcut.description)
                .font(.callout)
                .lineLimit(1)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(hovered ? Color.accentColor.opacity(0.08) : Color.clear)
        .onHover { hovered = $0 }
    }
}
