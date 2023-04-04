import 'package:flutter/material.dart';

import '/constants/color.dart';

class FormItem extends StatelessWidget {
  final String label;
  final Widget content;
  final String message;
  const FormItem({
    super.key,
    required this.label,
    required this.content,
    this.message = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: grey,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 12,
                color: darkTeal,
                fontWeight: FontWeight.w600,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: content,
          ),
          Flexible(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
                right: 20,
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 11,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
