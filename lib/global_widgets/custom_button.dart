import '/common_libraries.dart';

class CustomButton extends StatefulWidget {
  final Color backgroundColor;
  final Color hoverBackgroundColor;
  final TextStyle textStyle;
  final IconData? iconData;
  final Color iconColor;
  final double iconSize;
  final String text;
  final VoidCallback? onClick;
  final bool disabled;
  final Widget? body;
  final EdgeInsets padding;
  final double borderRadius;
  final bool isOnlyIcon;
  const CustomButton({
    Key? key,
    required this.backgroundColor,
    required this.hoverBackgroundColor,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    this.borderRadius = 3,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 12,
    ),
    this.iconColor = Colors.white,
    this.iconData,
    this.text = '',
    this.onClick,
    this.iconSize = 20,
    this.disabled = false,
    this.body,
    this.isOnlyIcon = false,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.disabled ? MouseCursor.defer : SystemMouseCursors.click,
      onHover: (_) => setState(() {
        if (!widget.disabled) {
          isHover = true;
        }
      }),
      onExit: (_) => setState(() {
        if (!widget.disabled) {
          isHover = false;
        }
      }),
      child: GestureDetector(
        onTap: () => widget.disabled
            ? null
            : widget.onClick == null
                ? null
                : widget.onClick!(),
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: isHover
                ? widget.hoverBackgroundColor
                : widget.disabled
                    ? widget.hoverBackgroundColor.withAlpha(150)
                    : widget.backgroundColor,
          ),
          child: widget.body ??
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.iconData == null
                      ? Container()
                      : Icon(
                          widget.iconData,
                          size: widget.iconSize,
                          color: widget.iconColor,
                        ),
                  if (widget.iconData != null && !widget.isOnlyIcon) spacerx10,
                  if (!widget.isOnlyIcon)
                    Text(
                      widget.text,
                      style: widget.textStyle,
                      softWrap: true,
                    ),
                ],
              ),
        ),
      ),
    );
  }
}
