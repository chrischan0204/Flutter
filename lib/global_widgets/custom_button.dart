import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color backgroundColor;
  final TextStyle textStyle;
  final IconData iconData;
  final Color iconColor;
  final double iconSize;
  final String text;
  final VoidCallback onClick;
  const CustomButton({
    Key? key,
    required this.backgroundColor,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    this.iconColor = Colors.white,
    required this.iconData,
    required this.text,
    required this.onClick,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (_) => setState(() {
        isHover = true;
      }),
      child: GestureDetector(
        onTap: () => widget.onClick(),
        child: FittedBox(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: widget.backgroundColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.iconData,
                  size: widget.iconSize,
                  color: widget.iconColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.text,
                  style: widget.textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
