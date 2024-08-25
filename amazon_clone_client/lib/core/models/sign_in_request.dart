import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request.g.dart';

@JsonSerializable()
class SignInRequest {
  final String email;
  final String password;

  const SignInRequest({
    required this.email,
    required this.password,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) => _$SignInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);

  @override
  bool operator ==(covariant SignInRequest other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() => 'SignUpRequest(email: $email, password: $password)';
}
