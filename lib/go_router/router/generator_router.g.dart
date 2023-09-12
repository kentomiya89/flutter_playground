// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainShellRoute,
    ];

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
      navigatorContainerBuilder: MainShellRoute.$navigatorContainerBuilder,
      factory: $MainShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          navigatorKey: BranchHomeData.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/home',
              name: 'home',
              factory: $HomeRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'a',
                  name: 'APage',
                  factory: $ARouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'b',
                      name: 'BPage',
                      parentNavigatorKey: BRoute.$parentNavigatorKey,
                      factory: $BRouteExtension._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: BranchTopTabData.$navigatorKey,
          routes: [
            StatefulShellRouteData.$route(
              navigatorContainerBuilder:
                  TopTabShellRoute.$navigatorContainerBuilder,
              factory: $TopTabShellRouteExtension._fromState,
              branches: [
                StatefulShellBranchData.$branch(
                  navigatorKey: BranchCarData.$navigatorKey,
                  routes: [
                    GoRouteData.$route(
                      path: '/top_tab/car',
                      name: 'carPage',
                      factory: $CarRouteExtension._fromState,
                    ),
                  ],
                ),
                StatefulShellBranchData.$branch(
                  navigatorKey: BranchTrainData.$navigatorKey,
                  routes: [
                    GoRouteData.$route(
                      path: '/top_tab/train',
                      name: 'trainPage',
                      factory: $TrainRouteExtension._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ARouteExtension on ARoute {
  static ARoute _fromState(GoRouterState state) => const ARoute();

  String get location => GoRouteData.$location(
        '/home/a',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BRouteExtension on BRoute {
  static BRoute _fromState(GoRouterState state) => const BRoute();

  String get location => GoRouteData.$location(
        '/home/a/b',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TopTabShellRouteExtension on TopTabShellRoute {
  static TopTabShellRoute _fromState(GoRouterState state) =>
      const TopTabShellRoute();
}

extension $CarRouteExtension on CarRoute {
  static CarRoute _fromState(GoRouterState state) => const CarRoute();

  String get location => GoRouteData.$location(
        '/top_tab/car',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TrainRouteExtension on TrainRoute {
  static TrainRoute _fromState(GoRouterState state) => const TrainRoute();

  String get location => GoRouteData.$location(
        '/top_tab/train',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
