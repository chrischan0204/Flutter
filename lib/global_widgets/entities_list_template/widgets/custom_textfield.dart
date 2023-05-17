import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final bool isDisabled;
  final TextEditingController? controller;
  final IconData? suffixIconData;
  final Color suffixIconColor;
  final Color suffixIconBackgroundColor;
  final double iconSize;
  final VoidCallback? onSuffixIconClick;
  const CustomTextField({
    super.key,
    this.hintText,
    this.initialValue,
    required this.onChanged,
    this.isDisabled = false,
    this.controller,
    this.suffixIconData,
    this.suffixIconColor = const Color(0xff0c81ff),
    this.suffixIconBackgroundColor = const Color(0xfff9fafb),
    this.iconSize = 20,
    this.onSuffixIconClick,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextFormField(
        key: widget.key,
        initialValue: widget.initialValue,
        controller: widget.controller,
        enabled: !widget.isDisabled,
        onChanged: (value) {
          widget.onChanged(value);
        },
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          suffixIcon: widget.suffixIconData == null
              ? null
              : GestureDetector(
                  onTap: () => widget.onSuffixIconClick!(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      border: Border.all(
                        color: grey,
                        width: 1,
                      ),
                      color: widget.suffixIconBackgroundColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Icon(
                      widget.suffixIconData,
                      color: widget.suffixIconColor,
                      size: widget.iconSize,
                    ),
                  ),
                ),
        ),
        cursorColor: darkTeal,
        cursorWidth: 1,
      ),
    );
  }
}
