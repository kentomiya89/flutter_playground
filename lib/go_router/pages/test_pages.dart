import 'package:flutter/material.dart';

class APage extends StatelessWidget {
  const APage({super.key, this.onNavigate});

  final VoidCallback? onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Aページ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                onNavigate?.call();
              },
              child: const Text('b画面遷移'),
            ),
          ],
        ),
      ),
    );
  }
}

class BPage extends StatelessWidget {
  const BPage({super.key, this.onNavigate});

  final VoidCallback? onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bページ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                onNavigate?.call();
              },
              child: const Text('前画面に戻る'),
            ),
          ],
        ),
      ),
    );
  }
}

class CarPage extends StatelessWidget {
  const CarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Car'));
  }
}

class TrainPage extends StatelessWidget {
  const TrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('TrainPage'));
  }
}
