---
description: 新しいFlutterサンプルを追加するときの手順と規約。
---

# 新しいサンプルを追加するときのルール

新しいサンプル (`lib/main_<name>.dart`) を追加するときは、**必ず以下の3ステップすべてを実行**する：

1. `lib/main_<name>.dart` を作成する
2. `.vscode/launch.json` の `inputs[0].options` 配列に `"lib/main_<name>.dart"` を追加する
3. `CLAUDE.md` の「サンプル一覧」セクションにそのサンプルの箇条書きを追加する

## Dartファイルのテンプレート

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('<タイトル>')),
      body: const Center(child: Text('<内容>')),
    );
  }
}
```

## ウィジェット階層のパターン

```
MyApp (StatelessWidget) — MaterialApp のルート
└── MyHome (StatelessWidget) — エントリーポイント
    └── <機能ウィジェット> (StatefulWidget) — コントローラーや状態が必要な場合
        ├── <表示ウィジェット A> (StatelessWidget)
        └── <表示ウィジェット B> (StatelessWidget)
```

## launch.json の更新例

```json
"options": [
    "lib/main_qr.dart",
    "lib/main_<name>.dart"   // ← 追加
]
```
