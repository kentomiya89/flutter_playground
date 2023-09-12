import 'package:flutter/material.dart';
import 'package:flutter_playground/go_router/pages/home_page.dart';
import 'package:flutter_playground/go_router/pages/test_pages.dart';
import 'package:flutter_playground/go_router/widget/custom_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'generator_router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'RootNavigator');
final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'HomeNavigator');
final topTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'TopTabNavigator');
final carNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'CarNavigator');
final trainNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'TrainNavigator');

final generateRouterProvider = Provider<GoRouter>(
  (_) => GoRouter(
    initialLocation: '/home',
    navigatorKey: rootNavigatorKey,
    routes: $appRoutes,
  ),
);

@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch<BranchHomeData>(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: '/home',
          name: 'home',
          routes: [
            TypedGoRoute<ARoute>(
              path: 'a',
              name: 'APage',
              routes: [
                TypedGoRoute<BRoute>(
                  path: 'b',
                  name: 'BPage',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<BranchTopTabData>(
      routes: [
        TypedStatefulShellRoute<TopTabShellRoute>(branches: [
          TypedStatefulShellBranch<BranchCarData>(
            routes: [
              TypedGoRoute<CarRoute>(
                path: '/top_tab/car',
                name: 'carPage',
              ),
            ],
          ),
          TypedStatefulShellBranch<BranchTrainData>(
            routes: [
              TypedGoRoute<TrainRoute>(
                path: '/top_tab/train',
                name: 'trainPage',
              ),
            ],
          ),
        ]),
      ],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return ScaffoldWithNaviBar(
      navigationShell: navigationShell,
      children: children,
    );
  }
}

class BranchHomeData extends StatefulShellBranchData {
  const BranchHomeData();

  static final GlobalKey<NavigatorState> $navigatorKey = homeNavigatorKey;
}

class BranchTopTabData extends StatefulShellBranchData {
  const BranchTopTabData();

  static final GlobalKey<NavigatorState> $navigatorKey = topTabNavigatorKey;
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage(
      // どのページに遷移するかは外側から変更しやすいようにコールバックで渡す
      onNavigateAButton: () => const ARoute().go(context),
      onNavigateBButton: () => const BRoute().go(context),
      onNavigateOutButton: () => const TrainRoute().go(context),
    );
  }
}

class ARoute extends GoRouteData {
  const ARoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return APage(
      onNavigate: () => const BRoute().go(context),
    );
  }
}

class BRoute extends GoRouteData {
  const BRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      fullscreenDialog: true,
      child: BPage(
        onNavigate: () => context.pop(),
      ),
    );
  }
}

class TopTabShellRoute extends StatefulShellRouteData {
  const TopTabShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return ScaffoldWithTabBarView(
      navigationShell: navigationShell,
      children: children,
    );
  }
}

class BranchCarData extends StatefulShellBranchData {
  const BranchCarData();

  static final GlobalKey<NavigatorState> $navigatorKey = carNavigatorKey;
}

class CarRoute extends GoRouteData {
  const CarRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CarPage();
  }
}

class BranchTrainData extends StatefulShellBranchData {
  const BranchTrainData();

  static final GlobalKey<NavigatorState> $navigatorKey = trainNavigatorKey;
}

class TrainRoute extends GoRouteData {
  const TrainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TrainPage();
  }
}
