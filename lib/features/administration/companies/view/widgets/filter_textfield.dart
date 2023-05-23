import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/global_widgets/global_widget.dart';

class TextFieldWithIcon extends StatefulWidget {
  final String hintText;
  final String label;
  final TextEditingController filterController;
  final ValueChanged<bool> onIconClicked;
  final ValueChanged<String> onChange;
  final bool canFilter;

  const TextFieldWithIcon({
    super.key,
    required this.hintText,
    required this.label,
    required this.filterController,
    required this.onIconClicked,
    required this.onChange,
    this.canFilter = false,
  });

  @override
  State<TextFieldWithIcon> createState() => _TextFieldWithIconState();
}

class _TextFieldWithIconState extends State<TextFieldWithIcon> {
  bool filtered = false;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: widget.hintText,
      onChanged: (value) => widget.onChange(value),
      controller: widget.filterController,
      suffixIconData:
          filtered ? PhosphorIcons.arrowCounterClockwise : PhosphorIcons.funnel,
      suffixIconColor: filtered ? Colors.red : const Color(0xff0c81ff),
      onSuffixIconClick: () async {
        if (widget.filterController.text.trim().length > 1 ||
            widget.canFilter) {
          setState(() {
            filtered = !filtered;
          });
          widget.onIconClicked(filtered);
          if (filtered) {
            widget.filterController.text =
                "Showing ${widget.label} matching '${widget.filterController.text}' below.";
          } else {
            widget.filterController.clear();
          }
        }
      },
    );
  }
}
