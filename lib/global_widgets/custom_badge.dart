import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String label;
  final Color color;
  const CustomBadge({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
      padding: const EdgeInsets.all(5),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
