import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FilterItem extends StatelessWidget {
  final String label;
  final String content;
  final bool last;
  const FilterItem({
    super.key,
    required this.label,
    required this.content,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return content.isNotEmpty
        ? FittedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  last
                      ? Container()
                      : const SizedBox(
                          width: 3,
                        ),
                  last
                      ? Container()
                      : const Icon(
                          PhosphorIcons.plusCircle,
                          size: 20,
                          color: Color(0xff059668),
                        ),
                ],
              ),
            ),
          )
        : Container();
  }
}
