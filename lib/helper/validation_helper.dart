import 'package:flutter/cupertino.dart';
import 'regex.dart';
import 'package:mecazone/helper/string_helper.dart';

class ValidationHelper {
  static checkEmailValidation(BuildContext context, String value) {
    if (value.isEmpty) {
      return "emailValidation".translate();
    } else if (value.isNotEmpty && !Regex.email.hasMatch(value.trim())) {
      return "emailValidValidation".translate();
    } else {
      return null;
    }
  }

  static checkMobileNoValidation(BuildContext context, String value, {String? validationMsg}) {
    if (value.isEmpty) {
      return validationMsg ?? "phoneNoValidation".translate();
    } else if (value.length < 8 || value.length > 12) {
      return validationMsg ?? "phoneNoValidValidation".translate();
    } else {
      return null;
    }
  }

  static checkBlankValidation(BuildContext context, String value, String errorMessageKey) {
    if (value.isEmpty) {
      return errorMessageKey.translate();
    }else {
      return null;
    }
  }

  static checkPasswordValidation(BuildContext context, String value, String errorMessageKey) {
    if (value.isEmpty ) {
      return errorMessageKey.translate();
    } else if (value.toString().trim().length < 8) {
      return "passwordMinimumValidation".translate();
    } else if (!Regex.password.hasMatch(value)) {
      return "passwordValidValidation".translate();
    } else {
      return null;
    }
  }

  static checkConfirmPasswordValidation(
      BuildContext context, String value, String passwordMatch) {
    if (value.isEmpty) {
      return "passwordMatchValidation".translate();
    } else if (value.isNotEmpty && value != passwordMatch) {
      return "passwordMatchValidation".translate();
    } else {
      return null;
    }
  }


}