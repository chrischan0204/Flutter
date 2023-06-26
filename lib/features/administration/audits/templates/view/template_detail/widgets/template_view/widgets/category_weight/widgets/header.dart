import 'package:flutter/material.dart';

class CategoryWeightHeaderView extends StatelessWidget {
  const CategoryWeightHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Section Weight',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }
}
