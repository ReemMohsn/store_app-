import 'package:stor_app/core/constants/app_strings.dart';

abstract final class AppValidator {
  static String? signInUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterUsername;
    }
    return null;
  }

  static String? signInPassword(String? value) {
    if (value == null || value.length < 4) {
      return AppStrings.enterAValidPassword;
    }
    return null;
  }

  static String? fullName(String? value) {
    final error = requiredField(value, field: AppStrings.fullNameField);
    if (error != null) return error;
    final length = value!.trim().length;
    if (length < 2) return AppStrings.enterYourFullName;
    if (length > 80) return AppStrings.fullNameMustBeAtMost80Characters;
    return null;
  }

  static String? requiredField(
    String? value, {
    String field = AppStrings.thisField,
  }) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField(field);
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = requiredField(value, field: AppStrings.email);
    if (requiredError != null) return requiredError;

    final emailPattern = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$",
    );
    if (!emailPattern.hasMatch(value!.trim())) {
      return AppStrings.enterAValidEmailAddress;
    }
    return null;
  }

  static String? username(String? value) {
    final requiredError = requiredField(value, field: AppStrings.username);
    if (requiredError != null) return requiredError;
    if (value!.trim().length < 3) {
      return AppStrings.usernameMustBeAtLeast3Characters;
    }
    return null;
  }

  static String? phone(String? value) {
    final requiredError = requiredField(value, field: AppStrings.phoneNumber);
    if (requiredError != null) return requiredError;

    final normalized = value!.replaceAll(RegExp(r'[\s()-]'), '');
    if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(normalized)) {
      return AppStrings.enterAValidPhoneNumber;
    }
    return null;
  }

  static String? password(String? value) {
    final requiredError = requiredField(value, field: AppStrings.password);
    if (requiredError != null) return requiredError;

    final password = value!;

    if (password.length < 8) {
      return AppStrings.passwordMustBeAtLeast8Characters;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return AppStrings.passwordMustContainAtLeastOneUppercaseLetter;
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return AppStrings.passwordMustContainAtLeastOneLowercaseLetter;
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return AppStrings.passwordMustContainAtLeastOneNumber;
    }
    if (!RegExp(
      r'''[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\;/~`']''',
    ).hasMatch(password)) {
      return AppStrings.passwordMustContainAtLeastOneSpecialCharacter;
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final requiredError = requiredField(
      value,
      field: AppStrings.confirmPassword,
    );
    if (requiredError != null) return requiredError;
    if (value != password) return AppStrings.passwordsDoNotMatch;
    return null;
  }
}
