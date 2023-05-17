// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '/constants/color.dart';
import 'dropdown_button2/dropdown_button2.dart';

class CustomSingleSelect extends StatefulWidget {
  final Map<String, dynamic> items;
  final String? selectedValue;
  final String? hint;
  final ValueChanged<MapEntry<String, dynamic>> onChanged;
  final bool disabled;
  final bool isSearchable;

  const CustomSingleSelect({
    super.key,
    required this.items,
    this.selectedValue,
    this.hint,
    required this.onChanged,
    this.disabled = false,
    this.isSearchable = true,
  });

  @override
  State<CustomSingleSelect> createState() => _CustomSingleSelectState();
}

class _CustomSingleSelectState<T> extends State<CustomSingleSelect> {
  final TextEditingController textEditingController = TextEditingController();
  String? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        dropdownSearchData: widget.isSearchable
            ? DropdownSearchData<String>(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return (item.value
                      .toString()
                      .toLowerCase()
                      .contains(searchValue.toLowerCase()));
                },
              )
            : null,
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
        // value: value,
        onChanged: (val) {
          MapEntry<String, dynamic> entry =
              MapEntry<String, dynamic>(val!, widget.items[val]! as dynamic);
          widget.onChanged(entry);
          // setState(() {
          //   value = val;
          // });
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
