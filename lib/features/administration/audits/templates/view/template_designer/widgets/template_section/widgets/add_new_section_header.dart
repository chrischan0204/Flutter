import 'package:flutter/material.dart';

class AddNewSectionHeader extends StatelessWidget {
  const AddNewSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        'Add new section',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
