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
                  index: i + 1,
                  collapsed: state.collapsibleList[i],
                  auditQuestion: state.auditQuestionList[i],
                  // question: state.auditQuestionList[i].question,
                  // status: state.auditQuestionList[i].questionStatus == 0
                  //     ? 'Unanswered'
                  //     : 'Answered',
                  // responseList: state.auditQuestionList[i].responseScaleItems,
                  auditId: auditId,
                )
            ],
          ),
        );
      },
    );
  }
}
