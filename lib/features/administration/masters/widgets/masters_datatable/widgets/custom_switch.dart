import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  final String label;

  const CustomSwitch({
    super.key,
    required this.label,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlutterSwitch(
          width: 40,
          height: 20,
          toggleSize: 15.0,
          value: switchValue,
          borderRadius: 15.0,
          padding: 2.0,
          // toggleColor: Colors.transparent,
          activeToggleColor: Colors.white,
          inactiveToggleColor: Colors.grey,
          activeColor: Colors.blue,
          inactiveColor: Colors.transparent,
          // switchBorder: ,
          inactiveSwitchBorder: Border.all(
            width: 2,
            color: const Color(0xffd1d5db),
          ),
          activeSwitchBorder: Border.all(
            width: 2,
            color: Colors.blue,
          ),
          showOnOff: false,
          onToggle: (val) {
            setState(() {
              switchValue = val;
            });
          },
        ),
        const SizedBox(
          width: 10,
        ),
        switchValue
            ? const Text(
                'Deactivated',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 11,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w400,
                ),
              )
            : Container(),
      ],
    );
  }
}
