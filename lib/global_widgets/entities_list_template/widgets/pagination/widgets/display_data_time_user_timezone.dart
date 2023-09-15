import 'package:flutter/material.dart';
import 'package:safety_eta/common_libraries.dart';
import 'package:intl/intl.dart';


class displayDateTime extends StatefulWidget {
  const displayDateTime ({super.key});

  @override
  State<displayDateTime > createState() => _displayDateTimeState();
}

class _displayDateTimeState extends State<displayDateTime > {
  String getTimeInTimeZone(String timezone) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now.toUtc());
    
    // Create a timezone object
    final timeZone = now.timeZoneName;
    
    // Format the time in the specified timezone
    String formattedTimeInTimeZone = DateFormat('HH:mm:ss').format(now.toUtc().toLocal());
    
    return formattedTimeInTimeZone;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var TimeZone = now.timeZoneName;
    String currentTimeInTimeZone = getTimeInTimeZone(TimeZone);
    return Container( 
      child: Text(
        '$currentTimeInTimeZone'
      ),
    );
  }
}