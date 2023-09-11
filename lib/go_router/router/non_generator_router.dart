import 'package:flutter/material.dart';
import 'package:flutter_playground/go_router/pages/home_page.dart';
import 'package:flutter_playground/go_router/pages/test_pages.dart';
import 'package:flutter_playground/go_router/widget/custom_scafolld.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rootNavigationKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (_) => GlobalKey<NavigatorState>(debugLabel: 'RootNavigator'),
);

final homeNavigationKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (_) => GlobalKey<NavigatorState>(debugLabel: 'HomeNavigator'),
);

final topTabNavigationKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (_) => GlobalKey<NavigatorState>(debugLabel: 'TopTabNavigator'),
);

final carTopTabNavigationKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (_) => GlobalKey<NavigatorState>(debugLabel: 'CarTopTabNavigation'),
);

final trainTopTabNavigationKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (_) => GlobalKey<NavigatorState>(debugLabel: 'TrainTopTabNavigation'),
);

final nonGenerateRouterProvider = Provider<GoRouter>(
  (ref) {
    final rootKey = ref.watch(rootNavigationKeyProvider);
    return GoRouter(
      initialLocation: '/home',
      navigatorKey: rootKey,
      routes: [
        StatefulShellRoute(
          builder: (context, state, navigationShell) => navigationShell,
          navigatorContainerBuilder: (context, navigationShell, children) =>
              ScafolldWithNaviBar(
            navigationShell: navigationShell,
            children: children,
          ),
          branches: [
            ref.watch(_homeRouteProvider),
            ref.watch(_topTabProvider),
          ],
        ),
      ],
    );
  },
);

final _homeRouteProvider = Provider<StatefulShellBranch>(
  (ref) => StatefulShellBranch(
    navigatorKey: ref.watch(homeNavigationKeyProvider),
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => HomePage(
          // どのページに遷移するかは外側から変更しやすいようにコールバックで渡す
          onNavigateAButton: () => context.goNamed('APage'),
          onNavigateBButton: () => context.goNamed('BPage'),
          onNavigateOutButton: () => context.goNamed('trainPage'),
        ),
        routes: [
          GoRoute(
            path: 'a',
            name: 'APage',
            builder: (context, state) => APage(
              onNavigate: () => context.goNamed('BPage'),
            ),
            routes: [
              GoRoute(
                path: 'b',
                name: 'BPage',
                // 途中で親のNavigatorで表示するパターン
                parentNavigatorKey: ref.watch(rootNavigationKeyProvider),
                pageBuilder: (context, state) => MaterialPage(
                  fullscreenDialog: true,
                  child: BPage(
                    onNavigate: () => context.pop(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);

final _topTabProvider = Provider<StatefulShellBranch>(
  (ref) => StatefulShellBranch(
    navigatorKey: ref.watch(topTabNavigationKeyProvider),
    routes: [
      StatefulShellRoute(
        builder: (context, state, navigationShell) => navigationShell,
        navigatorContainerBuilder: (context, navigationShell, children) =>
            ScafolldWithTabBarView(
          navigationShell: navigationShell,
          children: children,
        ),
        branches: [
          ref.watch(_carTopTabProvider),
          ref.watch(_trainTopTabProvider),
        ],
      ),
    ],
  ),
);

final _carTopTabProvider = Provider<StatefulShellBranch>(
  (ref) => StatefulShellBranch(
    navigatorKey: ref.watch(carTopTabNavigationKeyProvider),
    routes: [
      GoRoute(
        path: '/top_tab/car',
        name: 'carPage',
        builder: (context, state) => const CarPage(),
      ),
    ],
  ),
);

final _trainTopTabProvider = Provider<StatefulShellBranch>(
  (ref) => StatefulShellBranch(
    navigatorKey: ref.watch(trainTopTabNavigationKeyProvider),
    routes: [
      GoRoute(
        path: '/top_tab/train',
        name: 'trainPage',
        builder: (context, state) => const TrainPage(),
      ),
    ],
  ),
);
