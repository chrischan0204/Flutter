import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '/constants/color.dart';

class CustomMultiSelect extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final String hint;
  final ValueChanged<List<String>> onChanged;
  const CustomMultiSelect({
    super.key,
    this.items = const [],
    this.selectedItems = const [],
    required this.hint,
    required this.onChanged,
  });

  @override
  State<CustomMultiSelect> createState() => _CustomMultiSelectState();
}

class _CustomMultiSelectState extends State<CustomMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          widget.hint,
          style: TextStyle(
            fontSize: 14,
            color: darkTeal,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            //disable default onTap to avoid closing menu when selecting an item
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = widget.selectedItems.contains(item);

                return InkWell(
                  onTap: () {
                    isSelected
                        ? widget.selectedItems.remove(item)
                        : widget.selectedItems.add(item);
                    menuSetState(() {});
                    widget.onChanged(widget.selectedItems);
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        isSelected
                            ? const Icon(Icons.check_box_outlined)
                            : const Icon(Icons.check_box_outline_blank),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
        value: widget.selectedItems.isEmpty ? null : widget.selectedItems.last,
        onChanged: (value) {},
        selectedItemBuilder: (context) {
          return widget.items.map(
            (item) {
              return Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.selectedItems.join(', '),
                  style: const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                ),
              );
            },
          ).toList();
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: grey,
            ),
          ),
          padding: const EdgeInsets.only(
            left: 16,
          ),
        ),

        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
