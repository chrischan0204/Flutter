import '/common_libraries.dart';

class QuestionItemView extends StatelessWidget {
  final TemplateSectionQuestion question;
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
          onTap: () => context.read<TemplateDesignerBloc>().add(
              TemplateDesignerQuestionDetailLoaded(
                  id: question.id, itemTypeId: 1)),
          leading: Icon(
            PhosphorIcons.regular.dotsThreeVertical,
            size: 20,
            color: primaryColor,
          ),
          title: Text(
            question.title,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          trailing: const Text(
            '10 + 3',
            style: TextStyle(fontSize: 14),
          ),
        ),
        const CustomDivider(height: 1),
      ],
    );
  }
}
