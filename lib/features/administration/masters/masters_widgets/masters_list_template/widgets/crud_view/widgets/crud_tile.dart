import 'package:flutter/material.dart';

class CrudTitle extends StatelessWidget {
  const CrudTitle({
    super.key,
    required this.label,
    this.type = 'Add new',
  });

  final String label;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: Text(
        '$type $label',
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
