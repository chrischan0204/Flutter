import 'package:flutter/material.dart';
import 'package:safety_eta/constants/color.dart';

class DetailItem extends StatelessWidget {
  final String? label;
  final Widget? content;
  final bool isTwoLine;
  const DetailItem({
    super.key,
    this.label,
    this.content,
    this.isTwoLine = false,
  });

  @override
  Widget build(BuildContext context) {
    // if (isTwoLine) {
    //   return Column(
    //     children: [
    //       DetailItem(
    //         label: label,
    //       ),
    //       DetailItem(
    //         content: content,
    //       )
    //     ],
    //   );
    // } else {

    // }
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
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
              label!,
              style: TextStyle(
                color: darkTeal,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: content!,
          )
        ],
      ),
    );
  }
}
