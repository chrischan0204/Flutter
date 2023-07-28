import '../../execute_audit/widgets/audit_questions/widgets/header/widgets/question_view_option_select_box.dart';
import '/common_libraries.dart';

class QuestionSelectorForFocusMode extends StatelessWidget {
  final VoidCallback onStart;
  const QuestionSelectorForFocusMode({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: insetx12y24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomBottomBorderContainer(
              padding: inset30,
              child: Column(
                children: [
                  Text(
                    'Audit Questions Selector',
                    style: textNormal18,
                  ),
                  spacery10,
                  Text(
                    'Select the questions to be presented in focused mode',
                    style: textNormal18,
                  )
                ],
              ),
            ),
            spacery30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const QuestionViewOptionSelectBox(),
                ),
                spacerx100,
                BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.selectedQuestionViewOption == null
                          ? null
                          : state.selectedQuestionViewOption!.name!
                                  .contains('----')
                              ? null
                              : () {
                                  if (state.auditQuestionList.isEmpty) {
                                    CustomNotification(
                                      context: context,
                                      notifyType: NotifyType.info,
                                      content: 'There is no question.',
                                    ).showNotification();
                                    return;
                                  }

                                  onStart();
                                },
                      style: ElevatedButton.styleFrom(
                        padding: insetx24y12,
                        backgroundColor: primaryColor,
                      ),
                      child: Text(
                        'Start',
                        style: textNormal14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
