import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomSingleSelect extends StatefulWidget {
  final Map<String, dynamic> items;
  final String? selectedValue;
  final String? hint;
  final ValueChanged<MapEntry<String, dynamic>> onChanged;
  final bool disabled;

  const CustomSingleSelect({
    super.key,
    required this.items,
    this.selectedValue,
    this.hint,
    required this.onChanged,
    this.disabled = false,
  });

  @override
  State<CustomSingleSelect> createState() => _CustomSingleSelectState();
}

class _CustomSingleSelectState<T> extends State<CustomSingleSelect> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: widget.hint == null
            ? null
            : Text(
                widget.disabled
                    ? widget.selectedValue ?? ''
                    : widget.hint ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: darkTeal,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
        dropdownStyleData: DropdownStyleData(
            maxHeight: MediaQuery.of(context).size.height / 2.5),
        items: (widget.disabled
                ? <String>[]
                : widget.items.keys.map((entry) => entry).toList())
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
            )
            .toList(),
        value: widget.selectedValue == null
            ? null
            : widget.selectedValue!.isEmpty
                ? null
                : widget.selectedValue,
        onChanged: (value) {
          MapEntry<String, dynamic> entry = MapEntry<String, dynamic>(
              value!, widget.items[value]! as dynamic);
          widget.onChanged(entry);
        },
        buttonStyleData: ButtonStyleData(
          height: 36,
          // width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: grey,
            ),
            color: widget.disabled ? const Color(0xfff9fafb) : Colors.white,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
