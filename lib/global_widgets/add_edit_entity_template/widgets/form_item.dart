import 'package:flutter/material.dart';
import 'package:safety_eta/common_libraries.dart';

import '/constants/color.dart';

class FormItem extends StatelessWidget {
  final String label;
  final Widget content;
  final String message;
  final Widget? sideContent;
  final Border? border;

  /// if true, validation message will be displayed on the right of content
  /// if false, it will be displayed below content
  final bool validationMessagePosition;
  const FormItem({
    super.key,
    required this.label,
    required this.content,
    this.border,
    this.message = '',
    this.sideContent,
    this.validationMessagePosition = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget labelText = Text(
      '$label:',
      style: textSemiBold12,
    );

    var validationMessage = Padding(
      padding: const EdgeInsets.only(
        left: 50.0,
        right: 20,
      ),
      child: sideContent ??
          Text(
            message,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 11,
              fontFamily: 'OpenSans',
            ),
          ),
    );

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
      child: validationMessagePosition
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: labelText,
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: content,
                ),
                Flexible(
                  flex: 7,
                  child: validationMessage,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: labelText,
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: content,
                    ),
                  ],
                ),
                if (message.isNotEmpty) validationMessage,
              ],
            ),
    );
  }
}
