import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Color(0xffd1d5db),
      thickness: 1,
      height: 24,
    );
  }
}
