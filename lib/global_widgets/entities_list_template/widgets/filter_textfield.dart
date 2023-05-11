import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/global_widgets/global_widget.dart';

class FilterTextField extends StatefulWidget {
  final String hintText;
  final String label;
  final ValueChanged<bool> filterIconClick;
  final ValueChanged<String> onChange;
  final bool canFilter;

  const FilterTextField({
    super.key,
    required this.hintText,
    required this.label,
    required this.filterIconClick,
    required this.onChange,
    this.canFilter = false,
  });

  @override
  State<FilterTextField> createState() => _FilterTextFieldState();
}

class _FilterTextFieldState extends State<FilterTextField> {
  bool filtered = false;
  TextEditingController filterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: widget.hintText,
      onChanged: (val) {
        widget.onChange(val);
      },
      controller: filterController,
      suffixIconData:
          filtered ? PhosphorIcons.arrowCounterClockwise : PhosphorIcons.funnel,
      suffixIconColor: filtered ? Colors.red : const Color(0xff0c81ff),
      onSuffixIconClick: () async {
        if (filterController.text.trim().length > 1 || widget.canFilter) {
          setState(() {
            filtered = !filtered;
          });
          widget.filterIconClick(filtered);
          if (filtered) {
            filterController.text =
                "Showing ${widget.label} matching '${filterController.text}' below.";
          } else {
            filterController.clear();
          }
        }
      },
    );
  }
}
