abstract class AppException implements Exception {
  final ExceptionTypes type;
  const AppException(this.type);
}

class NoInternetException extends AppException {
  const NoInternetException() : super(ExceptionTypes.noInternet);
}

class AccessTokenIsNotStoredException extends AppException {
  const AccessTokenIsNotStoredException() : super(ExceptionTypes.accessTokenIsNotStored);
}

class InvalidAccessTokenException extends AppException {
  const InvalidAccessTokenException() : super(ExceptionTypes.invalidAccessToken);
}

enum ExceptionTypes {
  noInternet,
  accessTokenIsNotStored,
  invalidAccessToken,
}
