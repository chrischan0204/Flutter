import 'package:flutter/material.dart';
import '/constants/color.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: darkTeal,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  }
}
