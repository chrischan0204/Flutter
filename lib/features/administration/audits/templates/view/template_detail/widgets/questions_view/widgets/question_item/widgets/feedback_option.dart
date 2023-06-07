import 'package:dotted_line/dotted_line.dart';

import '/common_libraries.dart';
import 'widgets.dart';

class FeedbackOptionView extends StatelessWidget {
  final bool l2;
  final String? feedbackForOption;
  final String scale;
  final int questionScore;
  const FeedbackOptionView({
    super.key,
    this.l2 = false,
    required this.feedbackForOption,
    required this.scale,
    required this.questionScore,
  });

  @override
  Widget build(BuildContext context) {
    return feedbackForOption != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DottedLine(dashColor: l2 ? Colors.redAccent : primaryColor),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.regular.caretCircleRight,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 5),
                    if (l2)
                      Icon(
                        PhosphorIcons.regular.caretCircleRight,
                        color: Colors.red,
                      ),
                    if (l2) const SizedBox(width: 5),
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
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'If so - are these reachable by an average adult without ladder support?',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const CustomDivider(height: 1),
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
                    const Spacer(),
                  ],
                ),
              )
            ],
          )
        : Container();
  }
}
