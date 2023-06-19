import '/common_libraries.dart';
import '../../question_item/widgets/widgets.dart';

class FeedbackOptionView extends StatelessWidget {
  final bool l2;
  final String feedbackForOption;
  final String scale;
  final double questionScore;
  final bool comment;
  final bool actionItem;
  final bool followUp;
  const FeedbackOptionView({
    super.key,
    this.l2 = false,
    required this.feedbackForOption,
    required this.scale,
    required this.questionScore,
    required this.comment,
    required this.followUp,
    required this.actionItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Icon(
              //   PhosphorIcons.regular.caretCircleRight,
              //   color: Colors.red,
              // ),
              // const SizedBox(width: 5),
              // if (l2)
              //   Icon(
              //     PhosphorIcons.regular.caretCircleRight,
              //     color: Colors.red,
              //   ),
              // if (l2) const SizedBox(width: 5),
              Text(
                'Feedback for option = $feedbackForOption',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const CustomDivider(
          height: 1,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
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
                  title: 'Comment',
                  content: comment.asString(),
                ),
              ),
              Expanded(
                child: QuestionItemRowItem(
                  title: 'Action Item',
                  content: actionItem.asString(),
                ),
              ),
              Expanded(
                child: QuestionItemRowItem(
                  title: 'Follow Up',
                  content: followUp.asString(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
