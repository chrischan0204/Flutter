import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/images/logo-login.png',
        height: 50,
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
