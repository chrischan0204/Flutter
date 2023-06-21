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
          Text(
            '$label:',
            style: textSemiBold14.copyWith(
              color: primaryColor,
            ),
          ),
          spacerx50,
          Text(
            content,
            style: textNormal14,
          )
        ],
      ),
    );
  }
}
