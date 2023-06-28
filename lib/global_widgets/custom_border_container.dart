import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomBottomBorderContainer extends Container {
  final Color? backgroundColor;
  CustomBottomBorderContainer({
    super.key,
    super.padding,
    super.child,
    this.backgroundColor,
    super.foregroundDecoration,
  }) : super(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: grey,
                width: 0.5,
              ),
            ),
            color: backgroundColor,
          ),
        );
}
