import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/auth_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'app_routes.dart';

part 'transition_details.dart';
part 'transitions.dart';
part 'page_transitions.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

class AppRouter {
  // ignore: unused_field
  final Ref _ref;

  AppRouter(this._ref);

  GoRouter get router => _router;

  final _router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        pageBuilder: (context, state) => NoTransitionPage(
          name: AppRoutes.splash.name,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.auth.path,
        name: AppRoutes.auth.name,
        pageBuilder: (context, state) {
          return getCustomTransition(
            TransitionDetails(
              transition: Transitions.slideLeftToRight,
              page: const AuthScreen(),
              duration: const Duration(milliseconds: 2000),
              name: AppRoutes.auth.name,
              context: context,
              state: state,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        pageBuilder: (context, state) {
          return getCustomTransition(
            TransitionDetails(
              context: context,
              page: const HomeScreen(),
              transition: Transitions.slideLeftToRight,
              duration: const Duration(milliseconds: 2000),
              name: AppRoutes.home.name,
              state: state,
            ),
          );
        },
      ),
    ],
  );
}
