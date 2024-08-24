import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest {
  final String name;
  final String email;
  final String password;

  const SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);

  @override
  bool operator ==(covariant SignUpRequest other) {
    if (identical(this, other)) return true;

    return other.name == name && other.email == email && other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ password.hashCode;

  @override
  String toString() => 'SignUpRequest(name: $name, email: $email, password: $password)';
}
