import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/common/utils/internet_checker.dart';
import '../../../app/common/utils/shared_preferences_manager.dart';
import '../../../app/errors/exception.dart';
import '../../../app/errors/failure.dart';
import '../../../app/models/auth_response.dart';
import '../../../app/models/sign_in_request.dart';
import '../../../app/models/sign_up_request.dart';
import '../services/auth_service.dart';

final authRepoProvider = Provider<AuthRepo>(
  (ref) => AuthRepo(
    ref,
    ref.watch(authServiceProvider),
  ),
);

class AuthRepo {
  final AuthService authService;
  final Ref ref;
  const AuthRepo(this.ref, this.authService);

  Future<(Failure?, AuthResponse?)> signUp(SignUpRequest signUpRequest) async {
    try {
      if (!(await ref.read(internetCheckerProvider).hasConnection)) {
        throw NoInternetException();
      }
      final response = await authService.signUp(signUpRequest);
      if (response.success) {
        await ref.read(sharedPreferencesManagerProvider).storeAccessToken(response.accessToken);
        await ref.read(sharedPreferencesManagerProvider).storeExpiresIn(response.expiresIn);
        return (null, response);
      }
      throw Exception();
    } catch (e, _) {
      return (Failure.fromException(e), null);
    }
  }

  Future<(Failure?, AuthResponse?)> signIn(SignInRequest signInRequest) async {
    try {
      if (!(await ref.read(internetCheckerProvider).hasConnection)) {
        throw NoInternetException();
      }
      final response = await authService.signIn(signInRequest);
      if (response.success) {
        await ref.read(sharedPreferencesManagerProvider).storeAccessToken(response.accessToken);
        await ref.read(sharedPreferencesManagerProvider).storeExpiresIn(response.expiresIn);
        return (null, response);
      }
      throw Exception();
    } catch (e) {
      return (Failure.fromException(e), null);
    }
  }
}
