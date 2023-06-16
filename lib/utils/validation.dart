import 'package:email_validator/email_validator.dart';

class Validation {
  static bool isEmpty(String? text) {
    return text == null || (text.isEmpty || text.trim().isEmpty);
  }

  static bool isNotEmpty(String? text) {
    return !isEmpty(text);
  }

  static bool checkAlphanumeric(String str) {
    final alphpanumeric = RegExp(r'^[0-9a-zA-Z ]+$');
    return alphpanumeric.hasMatch(str);
  }

  static bool checkAlphabetic(String str) {
    final alphabetic = RegExp(r'^[a-zA-Z ]+$');
    return alphabetic.hasMatch(str);
  }

  static bool isEmail(String str) {
    return EmailValidator.validate(str);
  }

  static bool isMobilePhone(String str) {
    final mobile = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    // final mobile = RegExp(r'^[0-9]+.()-$');
    return mobile.hasMatch(str);
  }

  static bool isAlphanumbericWithSpecialChars(String str) {
    final reg = RegExp(r'^[ A-Za-z0-9_@./#&+-]*$');

    return reg.hasMatch(str);
  }
}
