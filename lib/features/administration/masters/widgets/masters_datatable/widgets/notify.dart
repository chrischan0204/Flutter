import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safety_eta/features/theme/view/widgets/sidebar/sidebar_style.dart';

enum NotifyType {
  success,
  good,
  failture,
}

class Notify extends StatefulWidget {
  final NotifyType type;
  final String content;
  const Notify({
    super.key,
    required this.content,
    this.type = NotifyType.success,
  });

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  bool isHover = false;
  bool isClosed = false;
  @override
  Widget build(BuildContext context) {
    Color borderColor = const Color(0xff82cbb4);
    Color backgroundColor = const Color(0xffe6f5f0);
    Color color = const Color(0xff04694a);
    switch (widget.type) {
      case NotifyType.success:
        break;
      case NotifyType.failture:
        backgroundColor = const Color(0xfffdecec);
        color = const Color(0xffa73030);
        borderColor = const Color(0xfff7a2a2);
        break;
      case NotifyType.good:
        backgroundColor = const Color(0xffe6f5f7);
        color = const Color(0xff036c79);
        borderColor = const Color(0xff82cdd6);
        break;
    }
    return isClosed
        ? Container()
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: backgroundColor,
              border: Border.all(
                color: borderColor,
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.content,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'OpenSans',
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onHover: (event) => setState(() {
                    isHover = true;
                  }),
                  onExit: (event) => setState(() {
                    isHover = false;
                  }),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isClosed = true;
                      });
                    },
                    child: Icon(
                      PhosphorIcons.x,
                      size: 18,
                      color: isHover ? Colors.black : sidebarColor,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
