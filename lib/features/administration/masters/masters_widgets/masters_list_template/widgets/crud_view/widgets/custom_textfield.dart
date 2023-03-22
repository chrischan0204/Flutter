import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool isDisabled;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        enabled: !isDisabled,
        onChanged: (value) {
          onChanged(value);
        },
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
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
          
        ),
      ),
    );
  }
}
