import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: grey,
      thickness: 1,
      height: 24,
    );
  }
}
