# ClickPulse (macOS)

[English](README.md) | 日本語

クリック時に目立つリングを表示する、メニューバー常駐の軽量macOSアプリです。

機能
- 左/右/その他のクリック時に、クリック位置へリングを0.4秒表示
- 左クリック=黄色、右クリック=青、その他=ピンク
- 複数ディスプレイ対応（各画面に透明オーバーレイウィンドウ）
- メニューバーから有効/無効の切り替え、終了
- 追加の権限不要（`NSEvent`のグローバルモニタを使用）

要件
- macOS 10.15 以降（推奨: 11+）
- Xcode コマンドラインツール（`xcrun` と `swiftc`）

ビルド
```
chmod +x scripts/build.sh
./scripts/build.sh
```
生成物: `ClickPulse.app`

起動
```
open ClickPulse.app
```

初回起動時の注意
- Apple未署名のためGatekeeper警告が表示される場合は、右クリック→「開く」を選択してください。

設定変更（任意）
- 初期の色/サイズ/アニメ時間はコードに定数で記載しています。変更したい場合は `Sources/OverlayView.swift` と `Sources/AppDelegate.swift` を調整し再ビルドしてください。

構成
- `Sources/main.swift` — アプリのエントリーポイント
- `Sources/AppDelegate.swift` — メニューバー、イベント監視の制御
- `Sources/OverlayManager.swift` — 各ディスプレイのオーバーレイ管理
- `Sources/OverlayWindow.swift` — 透明ウィンドウ（最前面）
- `Sources/OverlayView.swift` — リング表示の実体
- `Sources/RippleLayer.swift` — CALayerアニメーション
- `Resources/Info.plist` — App Bundle 設定（`LSUIElement`でDock非表示）
- `scripts/build.sh` — ビルド＆.app作成スクリプト

アンインストール
- フォルダを削除するだけでOKです。

