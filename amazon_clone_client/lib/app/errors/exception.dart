abstract class AppException implements Exception {
  final ExceptionType type;
  const AppException(this.type);
}

class NoInternetException extends AppException {
  NoInternetException() : super(ExceptionType.noInternet);
}

enum ExceptionType {
  noInternet,
}
