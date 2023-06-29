import '/common_libraries.dart';

class QuestionItemView extends StatelessWidget {
  final TemplateQuestion question;
  const QuestionItemView({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () => context
              .read<TemplateDesignerBloc>()
              .add(TemplateDesignerQuestionDetailLoaded(question: question)),
          title: Row(
            children: [
              Icon(
                PhosphorIcons.regular.dotsThreeVertical,
                size: 20,
                color: primaryColor,
              ),
              spacerx10,
              Text(
                question.title,
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          trailing: Text(
            '${question.maxScore} + ${question.questionScorePoint}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const CustomDivider(height: 1),
      ],
    );
  }
}
