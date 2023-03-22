import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomSingleSelect extends StatefulWidget {
  final Map<String, String> items;
  final String? selectedValue;
  final String hint;
  final ValueChanged<String> onChanged;
  final bool isDisabled;

  const CustomSingleSelect({
    super.key,
    required this.items,
    this.selectedValue,
    required this.hint,
    required this.onChanged,
    this.isDisabled = false,
  });

  @override
  State<CustomSingleSelect> createState() => _CustomSingleSelectState();
}

class _CustomSingleSelectState extends State<CustomSingleSelect> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          widget.isDisabled ? widget.selectedValue! : widget.hint,
          style: TextStyle(
            fontSize: 14,
            color: darkTeal,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
        items: (widget.isDisabled
                ? <String>[]
                : widget.items.keys.map((entry) => entry).toList())
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
            )
            .toList(),
        value: widget.selectedValue,
        onChanged: (value) {
          widget.onChanged(widget.items[value] as String);
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          // width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: grey,
            ),
            color: widget.isDisabled ? lightTeal : Colors.transparent,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
