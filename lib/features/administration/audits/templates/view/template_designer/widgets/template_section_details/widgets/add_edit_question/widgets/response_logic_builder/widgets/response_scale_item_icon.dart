import '/common_libraries.dart';

class ResponseScaleItemIcon extends StatefulWidget {
  final bool include;
  final IconData iconData;
  final String label;
  final Color activeColor;
  final ValueChanged<bool>? onClick;
  final bool active;
  const ResponseScaleItemIcon({
    super.key,
    this.include = true,
    required this.iconData,
    required this.label,
    required this.activeColor,
    this.onClick,
    required this.active,
  });

  @override
  State<ResponseScaleItemIcon> createState() => _ResponseScaleItemIconState();
}

class _ResponseScaleItemIconState extends State<ResponseScaleItemIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            if (widget.include) {
              if (widget.onClick != null) {
                widget.onClick!(!widget.active);
              }
            } else {
              CustomAlert(
                context: context,
                width: MediaQuery.of(context).size.width / 4,
                title: 'Notification',
                description: 'Please enable row before invoking responses.',
                btnOkText: 'OK',
                btnOkOnPress: () {},
                dialogType: DialogType.info,
              ).show();
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: widget.active
                ? widget.activeColor
                : const Color.fromRGBO(153, 153, 153, 1),
          ),
          child: Icon(
            widget.iconData,
            size: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          widget.label,
          style: const TextStyle(
            color: Color.fromRGBO(36, 114, 151, 1),
            fontSize: 11,
          ),
        )
      ],
    );
  }
}
