import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionItemView extends StatelessWidget {
  final bool first;
  final String? feedbackForOption;
  final String? l2FeedbackForOption;
  final String question;
  final String scale;
  final String category;
  final int questionScore;
  final int maxScore;
  const QuestionItemView({
    super.key,
    this.first = false,
    required this.question,
    required this.scale,
    required this.category,
    required this.questionScore,
    required this.maxScore,
    this.feedbackForOption,
    this.l2FeedbackForOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (first) const ParallelLineView(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            question,
            style: TextStyle(
              color: darkGreyAccent,
              fontSize: 18,
            ),
          ),
        ),
        const CustomDivider(height: 1),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: QuestionItemRowItem(
                  title: 'Category',
                  content: category,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: QuestionItemRowItem(
                        title: 'Scale',
                        content: scale,
                      ),
                    ),
                    Expanded(
                      child: QuestionItemRowItem(
                        title: 'Question Score',
                        content: '$questionScore pts',
                      ),
                    ),
                    Expanded(
                      child: QuestionItemRowItem(
                        title: 'Max Score',
                        content: '$maxScore pts',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        FeedbackOptionView(
          feedbackForOption: feedbackForOption,
          scale: 'Yes/No',
          questionScore: 1,
        ),
        FeedbackOptionView(
          l2: true,
          feedbackForOption: l2FeedbackForOption,
          scale: 'Yes/No',
          questionScore: 1,
        ),
        const ParallelLineView(),
      ],
    );
  }
}
