import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}
