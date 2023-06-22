import '/common_libraries.dart';

class AuditDetailItemView extends StatelessWidget {
  final String label;
  final String content;
  final bool twoLines;
  final bool highlighted;
  const AuditDetailItemView({
    super.key,
    required this.label,
    required this.content,
    this.twoLines = false,
    this.highlighted = false,
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
              maxLines: 3,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomBottomBorderContainer(
            padding: inset10,
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
      return CustomBottomBorderContainer(
        padding: inset10,
        backgroundColor: highlighted ? lightBlueAccent : Colors.transparent,
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
