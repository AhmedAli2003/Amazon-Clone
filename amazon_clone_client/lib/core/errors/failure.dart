import 'exception.dart';

class Failure {
  final String message;
  final int code;
  const Failure(this.message, this.code);

  factory Failure.fromException(Object e) {
    if (e is AppException) {
      return switch (e.type) {
        ExceptionTypes.noInternet => const Failure('Check your Internet connection', 1),
        ExceptionTypes.accessTokenIsNotStored => const Failure('Access token is not stored', -1),
        ExceptionTypes.invalidAccessToken => const Failure('Invalid access token', -2),
      };
    }
    return Failure(e.toString(), 0);
  }

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}
