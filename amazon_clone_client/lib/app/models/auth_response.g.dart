// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      error: json['error'],
      accessToken: json['accessToken'] as String,
      expiresIn: json['expiresIn'] as String,
    );
