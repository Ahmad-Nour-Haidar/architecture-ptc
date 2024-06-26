class ValidatorManager {
  static final ValidatorManager _instance = ValidatorManager._internal();
  static ValidatorManager get instance => _instance;
  ValidatorManager._internal();
  factory ValidatorManager() {
    return _instance;
  }

  final RegularExpressions regExp = RegularExpressions();

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!regExp.emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String value) {

    if (value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!regExp.phoneRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? validatePassword(String value) {
    // Define your password criteria
    const int minLength = 8;


    // Check for empty input
    if (value.isEmpty) {
      return 'Please enter a password';
    }

    // Check for minimum length
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }

    // // Check for uppercase letters
    // if (!regExp.upperCaseRegex.hasMatch(value)) {
    //   return 'Password must contain at least one uppercase letter';
    // }
    //
    // // Check for lowercase letters
    // if (!regExp.lowerCaseRegex.hasMatch(value)) {
    //   return 'Password must contain at least one lowercase letter';
    // }

    // Check for digits
    if (!regExp.digitRegex.hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    // // Check for special characters
    // if (!regExp.specialCharRegex.hasMatch(value)) {
    //   return 'Password must contain at least one special character';
    // }

    // Password meets all criteria
    return null;
  }

  String? validateConfirmPassword(String value, String originalPassword) {
    // Check if the input is empty
    if (value.isEmpty) {
      return 'Please enter your password again';
    }

    // Check if the passwords match
    if (value != originalPassword) {
      return 'Passwords do not match';
    }

    // Passwords match
    return null;
  }


}

class RegularExpressions {
  ///Email
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  ///Phone
  final RegExp phoneRegex = RegExp(r'^\d{10}$');

  ///Password
  final RegExp upperCaseRegex = RegExp(r'[A-Z]');
  final RegExp lowerCaseRegex = RegExp(r'[a-z]');
  final RegExp digitRegex = RegExp(r'[0-9]');
  final RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
}
