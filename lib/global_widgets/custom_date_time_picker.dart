import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '/constants/color.dart';

class CustomDateTimePicker extends StatelessWidget {
  final DateTimePickerType dateTimePickerType;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<DateTime> onChange;
  final double height;
  const CustomDateTimePicker({
    super.key,
    this.dateTimePickerType = DateTimePickerType.dateTime,
    this.controller,
    required this.onChange,
    this.initialValue,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DateTimePicker(
        type: dateTimePickerType,
        dateMask: dateTimePickerType == DateTimePickerType.dateTime
            ? 'd MMMM, yyyy - hh:mm a'
            : null,
        initialValue: initialValue ?? DateTime.now().toString(),
        controller: controller,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        icon: const Icon(Icons.event),
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: dateTimePickerType == DateTimePickerType.dateTime
              ? 'Select date and time'
              : dateTimePickerType == DateTimePickerType.date
                  ? 'Select Date'
                  : 'Select Time',
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
        dateLabelText: 'Date Time',
        use24HourFormat: false,
        locale: const Locale('en', 'US'),
        onChanged: (val) {
          onChange(DateTime.parse(val));
        },
        validator: (val) {
          return null;
        },
        onSaved: (val) {},
      ),
    );
  }
}
