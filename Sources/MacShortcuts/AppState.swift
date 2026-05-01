// ─────────────────────────────────────────────
// AppState.swift
// アプリ全体で共有する「状態」を管理するクラス。
// 対象アプリが変わると、SwiftUI の画面が自動的に再描画される仕組みを持つ。
// ─────────────────────────────────────────────
import Cocoa
import Combine

// ObservableObject : 変数が変わったときに SwiftUI へ「変わったよ」と通知できるクラス
class AppState: ObservableObject {

    // shared : アプリ内でただ一つのインスタンスを共有するパターン（シングルトン）
    static let shared = AppState()

    // @Published : この変数が変わると、参照している SwiftUI の View が自動で再描画される
    // ?: オプショナル型。値がない（まだ選ばれていない）場合は nil になる
    @Published var targetApp: NSRunningApplication?

    // 表示するショートカットグループの配列（最初は空）
    @Published var shortcutGroups: [ShortcutGroup] = []

    // private init : このクラスは外部から new できない（shared 経由でのみ使う）
    private init() {}

    // ─── 対象アプリが切り替わったときに呼ばれる ───
    func updateTargetApp(_ app: NSRunningApplication) {
        // 対象アプリの情報を更新
        targetApp = app
        // そのアプリに対応するショートカット一覧をデータベースから取得して更新
        shortcutGroups = ShortcutsDatabase.shared.shortcuts(for: app)
    }
}
