import '/common_libraries.dart';
import 'widgets/widgets.dart';

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

        if (state.auditQuestionList.isEmpty) {
          return Padding(
            padding: insety40,
            child: Text(
              'There is no question.',
              style: textNormal14,
            ),
          );
        }

        return Padding(
          padding: inset12,
          child: Column(
            children: [
              for (int i = 0; i < state.auditQuestionList.length; i++)
                BlocProvider(
                  create: (context) => ExecuteAuditQuestionBloc(
                    context: context,
                    auditId: auditId,
                    auditQuestion: state.auditQuestionList[i],
                  ),
                  child: QuestionItemView(
                    questionIndex: i,
                    auditId: auditId,
                    context: context,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
