---
description: Scaffold a new Flutter sample file and register it in launch.json and CLAUDE.md. Usage: /new-sample <name>
---

引数 `$ARGUMENTS` を使って新しいFlutterサンプルを作成してください。以下の手順をすべて実行してください：

1. `lib/main_$ARGUMENTS.dart` を作成する
   - 以下のテンプレートをベースにする：
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
           appBar: AppBar(title: const Text('$ARGUMENTS')),
           body: const Center(child: Text('$ARGUMENTS sample')),
         );
       }
     }
     ```

2. `.vscode/launch.json` の `options` 配列に `"lib/main_$ARGUMENTS.dart"` を追加する

3. `CLAUDE.md` の Samples リストに新しいサンプルの箇条書きを追加する
   - 例: `- \`lib/main_$ARGUMENTS.dart\` — <サンプルの概要>`

4. `fvm flutter analyze` を実行してエラーがないことを確認する

すべて完了したら、作成したファイルのパスと変更したファイルを報告してください。
