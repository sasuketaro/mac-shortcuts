// ─────────────────────────────────────────────
// ContentView.swift
// アプリの画面（UI）を定義するファイル。
// ・上部：対象アプリのアイコンと名前を表示するヘッダー
// ・中部：ショートカット一覧のリスト（カテゴリごとに区切り表示）
// ・空時：案内メッセージを表示
// ─────────────────────────────────────────────
import SwiftUI
import AppKit

// View : SwiftUI で「画面の部品」を定義するためのプロトコル
struct ContentView: View {

    // @EnvironmentObject : 親から受け取った共有状態。変わると自動で再描画される
    @EnvironmentObject var state: AppState

    // body : 実際に画面に表示する内容を定義するプロパティ（必須）
    var body: some View {
        // VStack : 子要素を縦に並べるコンテナ
        VStack(spacing: 0) {
            header    // ヘッダー部分
            Divider() // 区切り線
            if state.shortcutGroups.isEmpty {
                emptyState    // ショートカットがまだない場合の案内画面
            } else {
                shortcutList  // ショートカット一覧
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 画面いっぱいに広げる
        .background(Color(NSColor.controlBackgroundColor)) // macOS 標準の背景色
    }

    // ─── ヘッダー：対象アプリのアイコンと名前 ───
    private var header: some View {
        // HStack : 子要素を横に並べるコンテナ
        HStack(spacing: 8) {
            // アイコンが取得できた場合のみ表示（if let = オプショナルのアンラップ）
            if let icon = state.targetApp?.icon {
                Image(nsImage: icon)
                    .resizable()           // サイズを変更可能にする
                    .frame(width: 18, height: 18)
            }
            // アプリ名。対象アプリが未選択なら "Mac Shortcuts" を表示
            Text(state.targetApp?.localizedName ?? "Mac Shortcuts")
                .font(.headline)
                .lineLimit(1) // 1行で収める（はみ出したら省略）
            Spacer() // 残りのスペースを埋めて左揃えにする
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(NSColor.windowBackgroundColor))
    }

    // ─── 空状態：まだ対象アプリが選ばれていない場合の案内 ───
    private var emptyState: some View {
        VStack(spacing: 10) {
            Spacer()
            // SF Symbols（macOS 標準のアイコン）を使用
            Image(systemName: "keyboard")
                .font(.system(size: 36))
                .foregroundColor(.secondary) // 薄いグレー色
            Text("別のアプリをアクティブにすると\nショートカットが表示されます")
                .font(.callout)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center) // 複数行を中央揃え
            Spacer()
        }
        .padding()
    }

    // ─── ショートカット一覧 ───
    private var shortcutList: some View {
        // ScrollView : 内容が多い場合にスクロールできるようにする
        ScrollView {
            // LazyVStack : 画面に見えている部分だけ描画するパフォーマンス最適化版 VStack
            // pinnedViews : スクロールしてもセクションヘッダーが上部に固定される
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                // ForEach : 配列の要素分だけ繰り返し View を生成する
                ForEach(state.shortcutGroups) { group in
                    // Section : ヘッダー付きのグループ
                    Section(header: sectionHeader(group.category)) {
                        ForEach(group.shortcuts) { s in
                            ShortcutRow(shortcut: s) // 1行分の表示
                            Divider().padding(.leading, 12) // 行の区切り線
                        }
                    }
                }
            }
        }
    }

    // ─── カテゴリのセクションヘッダー（例：「スクロール」） ───
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

// ─────────────────────────────────────────────
// ShortcutRow
// ショートカット 1 件を「コマンド → 説明」の形で表示する行部品。
// マウスを乗せると薄くハイライトする。
// ─────────────────────────────────────────────
struct ShortcutRow: View {
    let shortcut: Shortcut

    // @State : この View 内だけで使うローカルな状態変数
    // マウスが乗っているかどうかを記憶する
    @State private var hovered = false

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            // コマンド部分：等幅フォントで見やすく表示
            Text(shortcut.command)
                .font(.system(.callout, design: .monospaced)) // monospaced = 等幅フォント
                .fontWeight(.semibold)
                .foregroundColor(.accentColor) // macOS のアクセントカラー（通常は青）
                .frame(minWidth: 84, alignment: .leading) // 最低幅を確保して縦揃えにする

            Text("→")
                .font(.caption)
                .foregroundColor(.secondary)

            // 説明部分
            Text(shortcut.description)
                .font(.callout)
                .lineLimit(1) // 1行に収める

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        // hovered が true なら薄くハイライト、false なら透明
        .background(hovered ? Color.accentColor.opacity(0.08) : Color.clear)
        // マウスが乗った・離れた瞬間に hovered を更新する
        .onHover { hovered = $0 }
    }
}
