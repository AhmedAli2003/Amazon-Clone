import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/common/utils/dio_provider.dart';
import '../../../core/constants/app_urls.dart';
import '../../../core/models/api_response.dart';
import '../../../core/models/auth_response.dart';
import '../../../core/models/empty.dart';
import '../../../core/models/sign_in_request.dart';
import '../../../core/models/sign_up_request.dart';

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

  @POST(AppUrls.checkAccessTokenPath)
  Future<ApiResponse<Empty>> checkAccessToken(@Header(AppUrls.authorization) accessToken);
}
