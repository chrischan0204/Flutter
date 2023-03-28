import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:star_menu/star_menu.dart';
import '/constants/color.dart';

class CustomColorPicker extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onChanged;
  const CustomColorPicker({
    super.key,
    this.color = const Color(0xffffffff),
    required this.onChanged,
  });

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color pickerColor = const Color(0xff443a49);
  void changeColor(Color color) {
    widget.onChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return StarMenu(
      params: StarMenuParameters.dropdown(context).copyWith(
          centerOffset: Offset(MediaQuery.of(context).size.width / 3.5, 0)),
      items: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: FittedBox(
              child: ColorPicker(
                pickerAreaBorderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                displayThumbColor: true,
                hexInputBar: true,
                labelTypes: const [ColorLabelType.rgb],
                pickerColor: widget.color,
                onColorChanged: changeColor,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
          ),
        ),
      ],
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
