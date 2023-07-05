import '/common_libraries.dart';
import 'widgets/feedback_option.dart';

class ResponseItemView extends StatelessWidget {
  final String scale;
  final String option;
  final double score;
  final bool comment;
  final bool actionItem;
  final bool followUp;
  const ResponseItemView({
    super.key,
    required this.scale,
    required this.option,
    required this.score,
    required this.comment,
    required this.actionItem,
    required this.followUp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: insetx20,
      child: FeedbackOptionView(
        feedbackForOption: option,
        scale: scale,
        questionScore: score,
        followUp: followUp,
        comment: comment,
        actionItem: actionItem,
      ),
    );
  }
}
