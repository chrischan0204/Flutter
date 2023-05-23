import 'package:flutter/material.dart';

class ExistingTemplateSectionHeader extends StatelessWidget {
  const ExistingTemplateSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        'Existing template sections',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
