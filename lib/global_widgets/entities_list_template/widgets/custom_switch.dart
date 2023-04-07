import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '/constants/color.dart';

class CustomSwitch extends StatefulWidget {
  final String label;
  final bool switchValue;
  final String trueString;
  final String falseString;
  final Color textColor;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    this.label = '',
    required this.switchValue,
    required this.onChanged,
    this.trueString = 'Deactivated',
    this.falseString = '',
    this.textColor = Colors.red,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlutterSwitch(
          width: 40,
          height: 20,
          toggleSize: 15.0,
          value: widget.switchValue,
          borderRadius: 15.0,
          padding: 2.0,
          // toggleColor: Colors.transparent,
          activeToggleColor: Colors.white,
          inactiveToggleColor: Colors.grey,
          activeColor: Colors.blue,
          inactiveColor: Colors.transparent,
          inactiveSwitchBorder: Border.all(
            width: 2,
            color: grey,
          ),
          activeSwitchBorder: Border.all(
            width: 2,
            color: primaryColor,
          ),
          showOnOff: false,
          onToggle: (val) {
            widget.onChanged(val);
          },
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.switchValue ? widget.trueString : widget.falseString,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 11,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
