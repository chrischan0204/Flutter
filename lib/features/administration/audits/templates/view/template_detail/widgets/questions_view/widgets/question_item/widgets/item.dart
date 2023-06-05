import '/common_libraries.dart';

class QuestionItemRowItem extends StatelessWidget {
  final String title;
  final String content;
  const QuestionItemRowItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title:   ',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(text: content, style: TextStyle(color: darkGreyAccent))
        ],
      ),
    );
  }
}
