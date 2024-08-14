import 'package:get/get.dart';

class HValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validateDiallerNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{4}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number - Insert 4 digits.';
    }

    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation_required_label'.tr;
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r"^[٠-٩\d]{1,12}$");

    if (!phoneRegExp.hasMatch(value)) {
      return 'validation_numbers_label'.tr;
    }

    return null;
  }

  static String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation_required_label'.tr;
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    //  final textRegExp = RegExp(r"(?:[\u0600-\u06FFa-zA-Z]){3,}.*$");

    // if (!textRegExp.hasMatch(value)) {
    //   return 'validation_text_label'.tr;
    // }

    return null;
  }

  static String expenseCodeValidation(int value) {
    String result;
    switch (value) {
      case (202):
        result = 'rent_label';
        break;
      case (203):
        result = 'utilities_label';
        break;
      case (204):
        result = 'salaries_label';
        break;
      case (205):
        result = 'other_label';
        break;
      default:
        result = 'medical_supplies_label';
    }
    return result;
  }

// Add more custom validators as needed for your specific requirements.

  static String serviceIdValidation(int value) {
    String result;
    switch (value) {
      case (0):
        result = 'check_label';
        break;
      case (1):
        result = 'consult_label';
        break;

      default:
        result = 'check_label';
    }
    return result;
  }

  static String statusIdValidation(int value) {
    String result;
    switch (value) {
      case (0):
        result = 'no_show_label';
        break;
      case (1):
        result = 'waiting_label';
        break;

      case (2):
        result = 'completed_label';
        break;

      case (3):
        result = 'canceled_label';
        break;

      default:
        result = 'no_show_label';
    }
    return result;
  }

  static String genderIdValidation(int value) {
    String result;
    switch (value) {
      case (1):
        result = 'male_label';
        break;
      case (2):
        result = 'female_label';
        break;

      default:
        result = 'male_label';
    }
    return result;
  }
}
