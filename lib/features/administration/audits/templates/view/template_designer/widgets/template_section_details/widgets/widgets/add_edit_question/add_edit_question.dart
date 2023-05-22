import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditQuestion extends StatelessWidget {
  final String? question;
  final bool followUpQuestion;
  final VoidCallback? onMinimizeQuestion;
  const AddEditQuestion({
    super.key,
    this.question,
    this.followUpQuestion = false,
    this.onMinimizeQuestion,
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
            Question(question: question),
            const SizedBox(width: 5),
            const PossibleAnswersToQuestion(),
          ],
        ),
        const SizedBox(height: 30),
        ResponseLogicBuilder(followUpQuestion: followUpQuestion),
        const SizedBox(height: 20),
        followUpQuestion
            ? Container()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SaveQuestionButton(onMinimizeQuestion: onMinimizeQuestion),
                  const SizedBox(width: 10),
                  MinimizeQuestionButton(
                      onMinimizeQuestion: onMinimizeQuestion),
                ],
              )
      ],
    );
  }
}
