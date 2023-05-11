import 'package:intl/intl.dart';

class FormatDate {
  final String format;
  final String dateString;
  final bool time = false;
  FormatDate({
    required this.format,
    required this.dateString,
  });

  String get formatDate =>
      DateFormat(format, 'en_US').format(DateTime.parse(dateString));

  String get formatTime =>
      DateFormat(format, 'en_US').add_jm().format(DateTime.parse(dateString));
}
