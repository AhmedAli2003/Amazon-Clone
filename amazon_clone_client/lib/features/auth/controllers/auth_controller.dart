import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/common/utils/ui_functions.dart';
import '../../../app/models/sign_up_request.dart';
import '../../../app/models/user.dart';
import '../../../app/router/app_routes.dart';
import '../repos/auth_repo.dart';

final authControllerProvider = Provider<AuthController>(
  (ref) => AuthController(
    ref,
    ref.read(authRepoProvider),
  ),
);

final userProvider = StateProvider<User?>((ref) => null);

final authLoadingProvider = StateProvider<bool>((ref) => false);

class AuthController {
  final AuthRepo authRepo;
  final Ref ref;
  const AuthController(this.ref, this.authRepo);

  Future<void> signUp({
    required SignUpRequest request,
    required BuildContext context,
  }) async {
    ref.read(authLoadingProvider.notifier).state = true;
    final response = await authRepo.signUp(request);
    ref.read(authLoadingProvider.notifier).state = false;
    if (response.$2 == null) {
      if (context.mounted) {
        showSnackBar(context, response.$1!.message);
      }
      return;
    }
    ref.read(userProvider.notifier).state = response.$2!.data;
    if (context.mounted) {
      GoRouter.of(context).goNamed(AppRoutes.home.name);
    }
  }
}
