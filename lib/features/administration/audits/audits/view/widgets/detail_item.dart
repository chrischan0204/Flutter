import '/common_libraries.dart';

class AuditDetailItemView extends StatelessWidget {
  final String label;
  final String content;
  final bool twoLines;
  final bool highlighted;
  final VoidCallback? onClick;
  const AuditDetailItemView({
    super.key,
    required this.label,
    required this.content,
    this.twoLines = false,
    this.highlighted = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    if (twoLines) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            padding: inset10,
            child: Text(
              label,
              style: textSemiBold14.copyWith(
                color: primaryColor,
              ),
            ),
          ),
          CustomBottomBorderContainer(
            padding: inset10,
            child: Text(
              content,
              style: textNormal14,
            ),
          )
        ],
      );
    } else {
      return CustomBottomBorderContainer(
        padding: inset10,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: textSemiBold14.copyWith(color: primaryColor),
              ),
            ),
            spacerx20,
            Expanded(
              child: highlighted
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MouseRegion(
                          cursor: highlighted
                              ? SystemMouseCursors.click
                              : MouseCursor.defer,
                          child: GestureDetector(
                            onTap: highlighted ? onClick : null,
                            child: Container(
                              padding: inset0,
                              decoration: highlighted
                                  ? BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                      color: primaryColor,
                                      width: 1,
                                    )))
                                  : null,
                              child: Text(
                                content,
                                style: textNormal14.copyWith(
                                    color: highlighted ? primaryColor : null),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      content,
                      style: textNormal14,
                    ),
            ),
          ],
        ),
      );
    }
  }
}
