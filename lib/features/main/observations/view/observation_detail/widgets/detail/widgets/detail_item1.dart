import '/common_libraries.dart';

class DetailItemView1 extends StatelessWidget {
  final String label;
  final String content;
  const DetailItemView1({
    super.key,
    required this.label,
    required this.content,
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
                    '$label:',
                    style: textSemiBold14.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    content,
                    style: textNormal14,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
