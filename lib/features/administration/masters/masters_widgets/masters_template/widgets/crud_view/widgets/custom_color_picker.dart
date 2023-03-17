import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:safety_eta/constants/color.dart';

class CustomColorPicker extends StatefulWidget {
  final Color color;
  const CustomColorPicker({
    super.key,
    required this.color,
  });

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color pickerColor = Color(0xff443a49);
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      barrierColor: Colors.transparent,
      arrowColor: Colors.transparent,
      menuBuilder: () => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: grey,
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: grey,
              offset: const Offset(1, 1),
              blurRadius: 3,
            ),
          ],
          color: Colors.white,
        ),
        child: FittedBox(
          child: ColorPicker(
            pickerAreaBorderRadius: const BorderRadius.all(Radius.circular(5)),
            displayThumbColor: true,
            hexInputBar: true,
            labelTypes: const [ColorLabelType.rgb],
            pickerColor: widget.color,
            onColorChanged: changeColor,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
      ),
      // horizontalMargin: 400,
      position: PreferredPosition.bottom,
      pressType: PressType.singleClick,
      child: Container(
        width: double.infinity,
        height: 25,
        decoration: BoxDecoration(
          color: widget.color,
        ),
      ),
    );
  }
}
