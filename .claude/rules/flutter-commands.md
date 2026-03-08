---
description: Flutterコマンドに関するルール。fvmの使用を強制する。
---

# Flutterコマンドのルール

- **必ず `fvm flutter` を使う**。素の `flutter` コマンドは絶対に使わない
  - 正: `fvm flutter pub get`
  - 正: `fvm flutter analyze`
  - 正: `fvm flutter run`
  - 誤: `flutter pub get`

- **コード変更後は必ず `fvm flutter analyze` を実行**し、警告・エラーをすべて修正してから作業完了とする
