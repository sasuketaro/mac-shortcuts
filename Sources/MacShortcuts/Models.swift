// ─────────────────────────────────────────────
// Models.swift
// アプリで使うデータの「型（型定義）」をまとめたファイル。
// ショートカット1件と、カテゴリごとのグループを定義している。
// ─────────────────────────────────────────────
import Foundation

// ─── 1件のショートカットを表す型 ───
// struct : 値をまとめた設計図（クラスより軽量で変更されにくい）
// Identifiable : ForEach などのリスト表示で「これとこれは別の要素だ」と識別するために必要
struct Shortcut: Identifiable {
    // UUID : 世界で一意な ID を自動生成。リスト内で重複しないように使う
    let id = UUID()
    let command: String     // 例: "⌘T"
    let description: String // 例: "新規タブ"
}

// ─── ショートカットをカテゴリごとにまとめた型 ───
// 例: category = "スクロール"、shortcuts = [Space→下スクロール, ⇧Space→上スクロール, ...]
struct ShortcutGroup: Identifiable {
    let id = UUID()
    let category: String          // カテゴリ名（"スクロール" など）
    let shortcuts: [Shortcut]     // そのカテゴリに属するショートカットの配列
}
