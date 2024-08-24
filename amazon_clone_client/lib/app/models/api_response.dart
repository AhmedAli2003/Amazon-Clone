import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
  createToJson: false,
)
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;
  final Object? error;

  const ApiResponse({
    required this.success,
    required this.data,
    required this.message,
    required this.statusCode,
    required this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  @override
  String toString() =>
      'ApiResponse(success: $success, data: $data, message: $message, statusCode: $statusCode, error: $error)';
}
