import 'package:flutter/material.dart';

import '/constants/color.dart';

class ShowItem extends StatelessWidget {
  final String label;
  final Widget content;
  const ShowItem({
    super.key,
    required this.label,
    required this.content,
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
            child: content,
          )
        ],
      ),
    );
  }
}
