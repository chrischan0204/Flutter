import '/common_libraries.dart';

class QuestionItemView extends StatelessWidget {
  final String name;
  final String score;
  const QuestionItemView({
    super.key,
    required this.name,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(
            PhosphorIcons.regular.dotsThreeVertical,
            size: 20,
            color: primaryColor,
          ),
          title: Text(
            name,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          trailing: Text(
            score,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const CustomDivider(height: 1),
      ],
    );
  }
}
