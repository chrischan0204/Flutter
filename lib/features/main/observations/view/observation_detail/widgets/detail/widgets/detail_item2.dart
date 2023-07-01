import '/common_libraries.dart';

class DetailItemView2 extends StatelessWidget {
  final String rightLabel;
  final String rightContent;
  final String leftLabel;
  final String leftContent;
  const DetailItemView2({
    super.key,
    required this.rightContent,
    required this.rightLabel,
    required this.leftLabel,
    required this.leftContent,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: insetx20y10,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '$leftLabel:',
                    style: textSemiBold14.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    leftContent,
                    style: textNormal14,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '$rightLabel:',
                    style: textSemiBold14.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    rightContent,
                    style: textNormal14,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
