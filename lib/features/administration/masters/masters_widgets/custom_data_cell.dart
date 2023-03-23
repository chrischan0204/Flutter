import 'package:flutter/material.dart';

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
        width: double.infinity,
        height: 25,
        decoration: BoxDecoration(color: data),
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
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
