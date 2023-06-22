import '/common_libraries.dart';

class AssessmentDetailItemView extends StatelessWidget {
  final String label;
  final String content;
  final bool twoLines;
  final Color color;
  const AssessmentDetailItemView({
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
          CustomBottomBorderContainer(
            padding: inset10,
            child: Text(
              label,
              style: textSemiBold14,
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
        child: Row(
          children: [
            Expanded(
              child: Text(label, style: textSemiBold14),
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
