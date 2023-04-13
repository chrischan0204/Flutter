// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class FormatDate {
  final String format;
  final String dateString;
  FormatDate({
    required this.format,
    required this.dateString,
  });

  String get formatDate =>
      DateFormat(format, 'en_US').format(DateTime.parse(dateString));
}
