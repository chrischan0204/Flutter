import 'package:flutter/material.dart';

class SummaryItemView extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String content;
  const SummaryItemView({
    super.key,
    required this.backgroundColor,
    required this.content,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 35),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
