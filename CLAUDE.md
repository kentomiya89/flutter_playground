# CLAUDE.md

Flutter の各種技術・パッケージ・UIパターンを気軽に検証するための playground プロジェクト。`lib/main_*.dart` にサンプルを追加して、本番投入前に動作確認・実装方法の模索を行う。

## セットアップ

FVM で Flutter 3.41.1 を管理。コマンドは必ず `fvm flutter` を使う。

```bash
fvm flutter pub get
fvm flutter run
fvm flutter analyze
```

## サンプル一覧

- `lib/main_qr.dart` — カスタムオーバーレイUIつきQRコードスキャン（`mobile_scanner: ^7.2.0`）

## 新しいサンプルの追加

`/new-sample <name>` を使うと自動で3ステップ（ファイル作成・launch.json更新・このファイル更新）を実行できる。
