import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '/constants/color.dart';

class CustomSwitch extends StatefulWidget {
  final String label;
  final bool switchValue;
  final String trueString;
  final String falseString;
  final bool onlySwitch;
  final Color textColor;
  final bool active;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    this.label = '',
    required this.switchValue,
    required this.onChanged,
    this.trueString = 'Deactivated',
    this.falseString = '',
    this.onlySwitch = false,
    this.textColor = Colors.red,
    this.active = true,
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
          activeColor: widget.active ? Colors.blue : Colors.blue.shade200,
          inactiveColor: Colors.transparent,
          inactiveSwitchBorder: Border.all(
            width: 2,
            color: grey,
          ),
          activeSwitchBorder: Border.all(
            width: 2,
            color: widget.active ? Colors.blue : Colors.blue.shade200,
          ),
          showOnOff: false,
          onToggle: (val) {
            if (widget.active) {
              widget.onChanged(val);
            }
          },
        ),
        widget.onlySwitch
            ? Container()
            : const SizedBox(
                width: 10,
              ),
        widget.onlySwitch
            ? Container()
            : Text(
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
