import '/common_libraries.dart';

class QuestionItemRowItem extends StatelessWidget {
  final String title;
  final String content;
  final double fontSize;
  const QuestionItemRowItem({
    super.key,
    required this.title,
    required this.content,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title:   ',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: content,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
