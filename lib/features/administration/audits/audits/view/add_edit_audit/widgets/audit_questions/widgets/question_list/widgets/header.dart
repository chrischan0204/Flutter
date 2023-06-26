import '/common_libraries.dart';

class QuestionListHeaderView extends StatelessWidget {
  const QuestionListHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: inset20,
      child: BlocBuilder<AuditQuestionsBloc, AuditQuestionsState>(
        builder: (context, state) {
          bool allExluded = !state.selectedSection.isIncluded;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Questions from ${state.selectedSection.name}',
                style: textSemiBold14,
              ),
              ElevatedButton(
                onPressed: () {
                  if (state.selectedSection.isIncluded) {
                    CustomAlert(
                      context: context,
                      width: MediaQuery.of(context).size.width / 4,
                      title: 'Confirm',
                      description:
                          'This will exclude all questions that are answered as well. Proceed?',
                      btnOkText: 'OK',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () => context
                          .read<AuditQuestionsBloc>()
                          .add(AuditQuestionsSectionIncludedChanged(
                            isIncluded: !state.selectedSection.isIncluded,
                            sectionId: state.selectedSection.id,
                          )),
                      dialogType: DialogType.question,
                    ).show();
                  } else {
                    context
                        .read<AuditQuestionsBloc>()
                        .add(AuditQuestionsSectionIncludedChanged(
                          isIncluded: !state.selectedSection.isIncluded,
                          sectionId: state.selectedSection.id,
                        ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: allExluded ? primaryColor : warnColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
                child: Text(
                  allExluded ? 'Include Section' : 'Remove Entire Section',
                  style: textNormal12,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
