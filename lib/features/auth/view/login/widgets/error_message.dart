import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String validationMessage;
  const ErrorMessage({
    super.key,
    required this.validationMessage,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width / 40,
      child: Text(
        validationMessage,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
      ),
    );
  }
}
