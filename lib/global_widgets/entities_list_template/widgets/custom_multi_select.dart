import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '/data/model/entity.dart';
import '/constants/color.dart';

class CustomMultiSelect extends StatefulWidget {
  final Map<String, Entity> items;
  final List<Entity> selectedItems;
  final String hint;
  final ValueChanged<List<Entity>> onChanged;
  const CustomMultiSelect({
    super.key,
    this.items = const <String, Entity>{},
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
            fontSize: 12,
            color: darkTeal,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
        items: widget.items.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            //disable default onTap to avoid closing menu when selecting an item
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = widget.selectedItems.indexWhere(
                        (selectedItem) => selectedItem.id == entry.value.id) !=
                    -1;
                return InkWell(
                  onTap: () {
                    menuSetState(() {});

                    setState(() {
                      isSelected
                          ? widget.selectedItems.removeWhere((selectedItem) =>
                              entry.value.id == selectedItem.id)
                          : widget.selectedItems.add(entry.value);
                    });
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
                            entry.key,
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
        value: widget.selectedItems.isEmpty
            ? null
            : widget.selectedItems.last.name,
        onChanged: (value) {},
        selectedItemBuilder: (context) {
          return widget.items.entries.map(
            (item) {
              return Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.selectedItems
                      .map((selectedItem) => selectedItem.name)
                      .join(', '),
                  style: const TextStyle(
                    fontSize: 12,
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
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
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