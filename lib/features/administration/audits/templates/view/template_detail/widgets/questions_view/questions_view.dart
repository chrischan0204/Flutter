import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionsView extends StatelessWidget {
  const QuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        QuestionsHeaderView(),
        CustomDivider(),
        QuestionItemView(
          first: true,
          feedbackForOption: 'No',
          question:
              'Q1. Are there any loose hanging wires from the ceiling that are visible?',
          scale: 'Yes No',
          category: 'Electric Inspection',
          questionScore: 3,
          maxScore: 4,
        ),
        QuestionItemView(
          question:
              'Q2. Are there any loose hanging wires from the ceiling that are visible?',
          scale: 'Yes No',
          category: 'Electric Inspection',
          questionScore: 3,
          maxScore: 4,
        ),
        QuestionItemView(
          feedbackForOption: 'No',
          l2FeedbackForOption: 'Yes',
          question:
              'Q3. Are there any visible signs of damage to the circuit box?',
          scale: 'Yes No',
          category: 'Electric Inspection',
          questionScore: 3,
          maxScore: 4,
        ),
      ],
    );
  }
}