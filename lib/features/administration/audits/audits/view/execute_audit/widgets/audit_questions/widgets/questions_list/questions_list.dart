import '/common_libraries.dart';
import 'widgets/widget.dart';

class QuestionsListView extends StatelessWidget {
  final String auditId;
  const QuestionsListView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, state) {
        if (state.selectedQuestionViewOption == null) {
          return Center(
            child: Padding(
              padding: insety30,
              child: Text(
                'Select option from question view to show questions.',
                style: textSemiBold18,
              ),
            ),
          );
        }

        if (state.auditQuestionListStatus.isLoading) {
          return const Center(child: Loader());
        }
        return Padding(
          padding: inset12,
          child: CustomExpansionPanelList(
            elevation: 3,
            expansionCallback: (int index, bool isExpanded) {
              context
                  .read<ExecuteAuditBloc>()
                  .add(ExecuteAuditQuestionMenuCollapsed(index: index));
            },
            children: [
              for (int i = 0; i < state.auditQuestionList.length; i++)
                QuestionItemView(
                  index: i,
                  collapsed: state.collapsibleList[i],
                  auditQuestion: state.followUpLevel2QuestionList[i] != null
                      ? state.followUpLevel2QuestionList[i]!
                      : state.followUpLevel1QuestionList[i] != null
                          ? state.followUpLevel1QuestionList[i]!
                          : state.auditQuestionList[i],
                  followUpLevel1Question: state.followUpLevel1QuestionList[i],
                  followUpLevel2Question: state.followUpLevel2QuestionList[i],
                  selectedResponse: state.followUpLevel2QuestionList[i] != null
                      ? state.selectedResponseListForFollowUpLevel2[i]
                      : state.followUpLevel1QuestionList[i] != null
                          ? state.selectedResponseListForFollowUpLevel1[i]
                          : state.selectedResponseList[i],
                  selectedResponseForLevel1:
                      state.selectedResponseListForFollowUpLevel1[i],
                  selectedResponseForLevel0: state.selectedResponseList[i],
                  auditId: auditId,
                )
            ],
          ),
        );
      },
    );
  }
}
