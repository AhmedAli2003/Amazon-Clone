import 'exception.dart';

class Failure {
  final String message;
  const Failure(this.message);

  factory Failure.fromException(Object e) {
    if (e is AppException) {
      return switch (e.type) {
        ExceptionType.noInternet => const Failure('Check your Internet connection'),
      };
    }
    return Failure(e.toString());
  }
}
