import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditQuestionView extends StatelessWidget {
  final TemplateSectionItem templateSectionItem;
  final bool childQuestion;
  const AddEditQuestionView({
    super.key,
    this.childQuestion = false,
    required this.templateSectionItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionTextField(
              question: templateSectionItem.question?.name,
            ),
            const SizedBox(width: 5),
            PossibleAnswersToQuestion(
              childQuestion: childQuestion,
              templateSectionItemId: templateSectionItem.id ?? emptyGuid,
            ),
          ],
        ),
        const SizedBox(height: 30),
        ResponseLogicBuilder(
          childQuestion: childQuestion,
          templateSectionItemList: templateSectionItem.children,
        ),
        const SizedBox(height: 20),
        childQuestion
            ? Container()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SaveQuestionButton(),
                  const SizedBox(width: 10),
                  templateSectionItem.question == null
                      ? const CancelCreateQuestionButton()
                      : const MinimizeQuestionButton(),
                ],
              ),
      ],
    );
  }
}
