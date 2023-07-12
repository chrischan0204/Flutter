import '/common_libraries.dart';
import 'widgets/widget.dart';

class QuestionsListView extends StatelessWidget {
  const QuestionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, state) {
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
                  question: state.auditQuestionList[i].question,
                  status: state.auditQuestionList[i].questionStatus == 0
                      ? 'Unanswered'
                      : 'Answered',
                  responseList: state.auditQuestionList[i].responseScaleItems
                      ,
                )
            ],
          ),
        );
      },
    );
  }
}
