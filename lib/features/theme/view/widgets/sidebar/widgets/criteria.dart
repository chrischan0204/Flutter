import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '/constants/color.dart';

class Criteria extends StatelessWidget {
  const Criteria({
    super.key,
    required this.isSidebarExtended,
    required this.label,
  });

  final bool isSidebarExtended;
  final String label;

  @override
  Widget build(BuildContext context) {
    return isSidebarExtended
        ? Container(
            margin: const EdgeInsets.only(
              left: 20,
              top: 10,
              bottom: 10,
            ),
            child: Text(
              label,
              style: TextStyle(
                color: grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Icon(
              PhosphorIcons.dotsThree,
              size: 25,
              color: lightTeal,
            ),
          );
  }
}
