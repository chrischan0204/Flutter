class Validation {
  static bool isEmpty(String? text) {
    return text == null || (text.isEmpty || text.trim().isEmpty);
  }

  static bool checkAlphanumeric(String str) {
    final alphpanumeric = RegExp(r'^[0-9a-zA-Z ]+$');
    return alphpanumeric.hasMatch(str);
  }
}
