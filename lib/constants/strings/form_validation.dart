import 'package:strings/strings.dart';

class FormValidationMessage {
  final String fieldName;
  final int? maxLength;
  FormValidationMessage({
    required this.fieldName,
    this.maxLength,
  });

  String get capitalizedFieldName => camelize(fieldName);

  String get requiredAndNotBlankMessage =>
      '$capitalizedFieldName is required and cannot be blank.';

  String get requiredMessage => '$capitalizedFieldName is required.';

  String get alphanumbericWithAllowSpecialCharMessage =>
      '$capitalizedFieldName should be alphanumeric with allow special char.';

  String get alphabeticMessage => '$fieldName should be only alphabetic.';

  String get alphanumericMessage => '$fieldName should be only alphanumeric.';

  String get maxLengthValidationMessage =>
      '$capitalizedFieldName cannot be more than $maxLength characters.';

  static const String phoneValidationMessage =
      'It should be phone number format.';

  static const String einNumberValidationMessage =
      'EIN Number can have only Number and Dahses in the format XX-XXXXXXX.';
}
