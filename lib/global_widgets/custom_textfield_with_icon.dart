import 'package:flutter/material.dart';

import '/global_widgets/global_widget.dart';

class CustomTextFieldWithIcon extends StatelessWidget {
  final String hintText;
  final Widget suffixWidget;
  final VoidCallback onSuffixClicked;
  final ValueChanged<String> onChange;
  final TextEditingController controller;

  const CustomTextFieldWithIcon({
    super.key,
    required this.hintText,
    required this.suffixWidget,
    required this.onSuffixClicked,
    required this.onChange,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: hintText,
      onChanged: (val) {
        onChange(val);
      },
      controller: controller,
      suffixWidget: suffixWidget,
      onSuffixIconClick: onSuffixClicked,
    );
  }
}
