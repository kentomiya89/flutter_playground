import 'package:flutter/material.dart';
import 'package:flutter_playground/go_router/router/generator_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: GenerateRouterApp()));
}

class GenerateRouterApp extends HookConsumerWidget {
  const GenerateRouterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: ref.watch(generateRouterProvider),
    );
  }
}
