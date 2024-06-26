

import 'package:architecture_ptc/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/features/cache/presentation/pages/details_user_page.dart';
import '../../src/features/core/presentation/pages/emty_page.dart';
import '../../src/features/core/presentation/pages/navbar_page.dart';
import '../../src/features/core/presentation/pages/splash_page.dart';
import '../data/enums/key_parameter_route_enum.dart';


enum AppRoute {
  noThing,
  empty,
  splash,
  navbar,
  detailsUser,
  login,

}
final Map<AppRoute, dynamic> routes = {
  ///Location
  AppRoute.noThing: (context, state) =>const SizedBox.shrink(),
  AppRoute.empty: (context, state) =>const EmptyPage(),
  AppRoute.navbar: (context, state) =>const NavbarPage(),
  AppRoute.login: (context, state) => const LoginPage(),
  AppRoute.detailsUser: (context, state) => DetailsUserPage(id: state.extra[KeyParameterRoute.id.name]),
};
final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  // errorBuilder: (context, state) => const NoFoundPage(),
  routes:
  [
    /// [Splash Page].
    GoRoute(
        path: '/',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
        routes:
        routes.entries
            .map((entry) =>
            GoRoute(
              path: entry.key.name,
              name:entry.key.name,
              builder: (context,state) {
                return entry.value(context,state);
              },
            ))
            .toList()),

  ],
);
