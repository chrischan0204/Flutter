import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color? color;
  const CustomDivider({
    super.key,
    this.height = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? grey,
      thickness: 1,
      height: height,
    );
  }
}
