import 'package:flutter/material.dart';

import '/global_widgets/custom_divider.dart';

class InviteDetailItem extends StatelessWidget {
  final String label;
  final String content;
  final bool isLast;
  const InviteDetailItem({
    super.key,
    required this.label,
    required this.content,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '$label:',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        isLast ? Container() : const CustomDivider(),
      ],
    );
  }
}
