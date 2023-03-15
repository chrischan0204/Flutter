import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:safety_eta/features/theme/view/widgets/sidebar/sidebar_style.dart';

class CustomSelect extends StatefulWidget {
  final List<String> items;
  final String hint;

  const CustomSelect({
    super.key,
    required this.items,
    required this.hint,
  });

  @override
  State<CustomSelect> createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          widget.hint,
          style: TextStyle(
            fontSize: 14,
            color: sidebarColor,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
        items: widget.items
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
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          // width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color(0xffd1d5db),
            ),
          ),
          // padding: const EdgeInsets.symmetric(
          //   horizontal: 16,
          // ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
