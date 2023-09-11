import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.onNavigateAButton,
    this.onNavigateBButton,
    this.onNavigateOutButton,
  });

  final VoidCallback? onNavigateAButton;
  final VoidCallback? onNavigateBButton;
  final VoidCallback? onNavigateOutButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                onNavigateAButton?.call();
              },
              child: const Text('Aページ遷移'),
            ),
            ElevatedButton(
              onPressed: () {
                onNavigateBButton?.call();
              },
              child: const Text('Bページ遷移'),
            ),
            ElevatedButton(
              onPressed: () {
                onNavigateOutButton?.call();
              },
              child: const Text('topTabのトレインへ遷移'),
            ),
          ],
        ),
      ),
    );
  }
}
