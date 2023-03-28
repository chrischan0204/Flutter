import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  const CustomDivider({
    super.key,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: grey,
      thickness: 1,
      height: height,
    );
  }
}
