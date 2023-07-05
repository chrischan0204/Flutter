import '../../../../../../add_edit_template/widgets/template_items/widgets/section_questions/widgets/add_new_question/widgets/response_scale_item_list/widgets/futher_action_item.dart';
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
  final String optionName;
  const FeedbackOptionView({
    super.key,
    this.l2 = false,
    required this.feedbackForOption,
    required this.scale,
    required this.questionScore,
    required this.comment,
    required this.followUp,
    required this.actionItem,
    this.optionName = 'Scale Option',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: insetx20y10,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$optionName = $feedbackForOption',
              style: textSemiBold16,
            ),
          ),
          Expanded(
            child: QuestionItemRowItem(
              title: 'Score',
              content: '$questionScore pts',
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutherActionItemView(
                  active: comment,
                  onClick: (_) {},
                  disabled: true,
                  title: 'Comment',
                  activeColor: primaryColor,
                ),
                FutherActionItemView(
                  active: actionItem,
                  onClick: (_) {},
                  disabled: true,
                  title: 'Action Item',
                  activeColor: primaryColor,
                ),
                FutherActionItemView(
                  active: followUp,
                  onClick: (_) {},
                  disabled: true,
                  title: 'Follow Up',
                  activeColor: warnColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
