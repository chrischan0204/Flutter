import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool isDisabled;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.isDisabled = false,
    required this.controller,
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
      child: TextField(
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
        ),
        cursorColor: darkTeal,
        cursorWidth: 1,
      ),
    );
  }
}
