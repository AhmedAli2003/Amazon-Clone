import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/auth_screen.dart';
import '../../features/home/screens/home_screen.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

class AppRouter {
  // ignore: unused_field
  final Ref _ref;

  AppRouter(this._ref);

  GoRouter get router => _router;

  final _router = GoRouter(
    initialLocation: AppRoutes.auth.path,
    routes: [
      GoRoute(
        path: AppRoutes.auth.path,
        name: AppRoutes.auth.name,
        pageBuilder: (context, state) => NoTransitionPage(
          name: AppRoutes.auth.name,
          child: const AuthScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        pageBuilder: (context, state) => NoTransitionPage(
          name: AppRoutes.home.name,
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}
