import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '/constants/color.dart';

class CustomSingleSelect extends StatefulWidget {
  final Map<String, dynamic> items;
  final String? selectedValue;
  final String? hint;
  final ValueChanged<MapEntry<String, dynamic>> onChanged;
  final bool disabled;
  final bool isSearchable;
  final double width;

  const CustomSingleSelect({
    super.key,
    required this.items,
    this.selectedValue,
    this.hint,
    required this.onChanged,
    this.disabled = false,
    this.isSearchable = true,
    this.width = double.infinity,
  });

  @override
  State<CustomSingleSelect> createState() => _CustomSingleSelectState();
}

class _CustomSingleSelectState<T> extends State<CustomSingleSelect> {
  final TextEditingController textEditingController = TextEditingController();
  String? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          dropdownSearchData: widget.isSearchable
              ? DropdownSearchData<String>(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 40,
                  searchInnerWidget: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        hintText: 'Search...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
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
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
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
            textEditingController.clear();
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
      ),
    );
  }
}
