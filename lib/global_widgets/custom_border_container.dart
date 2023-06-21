import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomBottomBorderContainer extends Container {
  final Color? color;
  CustomBottomBorderContainer({
    super.key,
    super.padding,
    super.child,
    this.color,
  }) : super(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: grey),
            ),
            color: color,
          ),
        );
}
