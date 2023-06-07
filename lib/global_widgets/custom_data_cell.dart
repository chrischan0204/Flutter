import '/common_libraries.dart';

class CustomDataCell extends StatefulWidget {
  final dynamic data;
  final VoidCallback? onRowClick;
  const CustomDataCell({
    super.key,
    required this.data,
    this.onRowClick,
  });

  @override
  State<CustomDataCell> createState() => _CustomDataCellState();
}

class _CustomDataCellState extends State<CustomDataCell> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    String content = widget.data.toString();
    if (widget.data is bool) {
      content = widget.data ? 'Yes' : 'No';
    } else if (widget.data is Color) {
      return Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        // width: double.infinity,
        height: 20,
        decoration: BoxDecoration(
          color: widget.data,
          border: Border.all(
            color: widget.data == Colors.white ? grey : Colors.transparent,
            width: 1,
          ),
        ),
      );
    } else if (widget.data is List) {
      content = widget.data.join(', ');
    }

    return MouseRegion(
      onEnter: (_) {
        if (widget.onRowClick != null) {
          setState(() => isHover = true);
        }
      },
      onExit: (_) {
        if (widget.onRowClick != null) {
          setState(() => isHover = false);
        }
      },
      child: GestureDetector(
        onTap: () {
          if (widget.onRowClick != null) {
            widget.onRowClick!();
          }
        },
        child: Text(
          content,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            decoration: isHover ? TextDecoration.underline : null,
            decorationStyle: isHover ? TextDecorationStyle.dotted : null,
            decorationColor: primaryColor,
            decorationThickness: 3,
          ),
          maxLines: 3,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
