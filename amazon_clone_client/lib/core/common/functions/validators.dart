import '../../constants/app_constants.dart';

String? validatePassword(String? password) {
  if (password == null || (password = password.trim()).isEmpty) {
    return AppConstants.passwordValidationMessage;
  }

  // Regular expression to check if the password contains:
  // At least one uppercase letter, one lowercase letter, one number, and one special character
  final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  if (passwordRegex.hasMatch(password)) {
    return null;
  }
  return AppConstants.passwordValidationMessage;
}

String? validateEmail(String? email) {
  if (email == null || (email = email.trim()).isEmpty) {
    return AppConstants.emailValidationMessage;
  }

  // Regular expression for validating an email address
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');

  if (emailRegex.hasMatch(email)) {
    return null;
  }
  return AppConstants.emailValidationMessage;
}

String? validateUsername(String? username) {
  if (username == null || (username = username.trim()).isEmpty) {
    return AppConstants.usernameValidationMessage;
  }

  // Regular expression for validating the username
  final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,}$');

  if (usernameRegex.hasMatch(username)) {
    return null;
  }
  return AppConstants.usernameValidationMessage;
}
