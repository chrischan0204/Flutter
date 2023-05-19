import 'package:flutter/material.dart';

class TemplateSectionHeader extends StatelessWidget {
  const TemplateSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        'Template Sections',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
