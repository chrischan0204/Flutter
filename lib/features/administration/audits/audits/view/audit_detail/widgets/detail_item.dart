import '/common_libraries.dart';

class AuditDetailItemView extends StatelessWidget {
  final String label;
  final String content;
  final bool twoLines;
  final Color color;
  const AuditDetailItemView({
    super.key,
    required this.label,
    required this.content,
    this.twoLines = false,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    if (twoLines) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(color: grey))),
            padding: insetx10y20,
            child: Text(
              label,
              style: textSemiBold14.copyWith(
                color: primaryColor,
              ),
              maxLines: 3,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(color: grey))),
            padding: insetx10y20,
            child: Text(
              content,
              style: textNormal14,
              maxLines: 3,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      );
    } else {
      return Container(
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: grey))),
        padding: insetx10y20,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: textSemiBold14.copyWith(
                  color: primaryColor,
                ),
              ),
            ),
            spacerx20,
            Expanded(
              child: Text(
                content,
                style: textNormal14,
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
  }
}
