import 'package:flutter/material.dart';
import 'package:safety_eta/constants/color.dart';

class CustomDataCell extends StatelessWidget {
  final dynamic data;
  const CustomDataCell({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    String content = data.toString();
    if (data is bool) {
      content = data ? 'Yes' : 'No';
    } else if (data is Color) {
      return Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        width: double.infinity,
        height: 20,
        decoration: BoxDecoration(
          color: data,
          border: Border.all(
            color: data == Colors.white ? grey : Colors.transparent,
            width: 1,
          ),
        ),
      );
    } else if (data is List) {
      content = data.join(', ');
    }

    return Text(
      content,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xff1f2937),
        fontWeight: FontWeight.w400,
        fontFamily: 'OpenSans',
      ),
      maxLines: 3,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
