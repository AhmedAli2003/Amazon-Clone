import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../../app/common/utils/dio_provider.dart';
import '../../../app/constants/app_urls.dart';
import '../../../app/models/auth_response.dart';
import '../../../app/models/sign_in_request.dart';
import '../../../app/models/sign_up_request.dart';

part 'auth_service.g.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(dioProvider));
});

@RestApi(baseUrl: AppUrls.authUrl)
abstract class AuthService {
  factory AuthService(Dio dio, {String? baseUrl}) = _AuthService;

  @POST(AppUrls.signUpPath)
  Future<AuthResponse> signUp(@Body() SignUpRequest signUpRequest);

  @POST(AppUrls.signInPath)
  Future<AuthResponse> signIn(@Body() SignInRequest signUpRequest);
}
