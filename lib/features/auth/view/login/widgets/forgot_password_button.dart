import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
