import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';
import 'user.dart';

part 'auth_response.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createToJson: false,
)
class AuthResponse extends ApiResponse<User> {
  final String accessToken;
  final String expiresIn;

  const AuthResponse({
    required super.success,
    required super.data,
    required super.message,
    required super.statusCode,
    required super.error,
    required this.accessToken,
    required this.expiresIn,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  @override
  String toString() => 'AuthResponse(accessToken: $accessToken, expiresIn: $expiresIn)';
}
