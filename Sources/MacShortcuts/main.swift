// ─────────────────────────────────────────────
// main.swift
// アプリの「一番最初に実行される」エントリポイント。
// ここで NSApplication（macOS アプリの本体）を起動し、
// AppDelegate に処理を引き渡す。
// ─────────────────────────────────────────────
import Cocoa

// NSApplication.shared : このプロセスが動かす macOS アプリのシングルトン
let app = NSApplication.shared

// .regular : ドックにアイコンを表示する通常アプリとして動作させる設定
app.setActivationPolicy(.regular)

// AppDelegate のインスタンスを作り、アプリに「管理担当者」として登録する
let delegate = AppDelegate()
app.delegate = delegate

// アプリを前面に表示する（他のアプリより手前に出す）
app.activate(ignoringOtherApps: true)

// アプリのイベントループを開始。ここで処理が止まり、
// ユーザー操作や通知を受け取り続ける（アプリが終了するまで戻ってこない）
app.run()
