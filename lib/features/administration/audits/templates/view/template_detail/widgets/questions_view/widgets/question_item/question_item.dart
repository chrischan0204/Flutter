import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionItemView extends StatelessWidget {
  final bool first;
  final String? feedbackForOption;
  final String? l2FeedbackForOption;
  final String question;
  final String scale;
  final String category;
  final double questionScore;
  final double maxScore;
  final int level;
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
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (first) const ParallelLineView(),
        Padding(
          padding: insetx20y10,
          child: QuestionItemRowItem(
            title: level > 0 ? 'L$level Question' : 'Question',
            fontSize: 18,
            content: question,
          ),
        ),
        const CustomDivider(
          height: 1,
          color: Colors.white,
        ),
        Padding(
          padding: insetx20y10,
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
                    if (level == 0)
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
      ],
    );
  }
}
