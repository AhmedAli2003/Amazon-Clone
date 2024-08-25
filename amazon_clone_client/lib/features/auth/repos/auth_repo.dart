import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/utils/internet_checker.dart';
import '../../../core/common/utils/shared_preferences_manager.dart';
import '../../../core/errors/exception.dart';
import '../../../core/errors/failure.dart';
import '../../../core/models/api_response.dart';
import '../../../core/models/auth_response.dart';
import '../../../core/models/empty.dart';
import '../../../core/models/sign_in_request.dart';
import '../../../core/models/sign_up_request.dart';
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
        throw const NoInternetException();
      }
      final response = await authService.signUp(signUpRequest);
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

  Future<(Failure?, AuthResponse?)> signIn(SignInRequest signInRequest) async {
    try {
      if (!(await ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
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

  Future<(Failure?, ApiResponse<Empty>?)> checkAccessToken() async {
    try {
      final accessToken = ref.read(sharedPreferencesManagerProvider).getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw const AccessTokenIsNotStoredException();
      }
      if (!(await ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final bearerAccessToken = 'Bearer $accessToken';
      final response = await ref.read(authServiceProvider).checkAccessToken(bearerAccessToken);
      if (!response.success) {
        throw const InvalidAccessTokenException();
      }
      return (null, response);
    } catch (e) {
      return (Failure.fromException(e), null);
    }
  }
}
