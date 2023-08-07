import '/common_libraries.dart';
import 'question_item_focus_mode.dart';

class ExecuteFocusModeView extends StatefulWidget {
  final String auditId;
  const ExecuteFocusModeView({
    super.key,
    required this.auditId,
  });

  @override
  State<ExecuteFocusModeView> createState() => _ExecuteFocusModeViewState();
}

class _ExecuteFocusModeViewState extends State<ExecuteFocusModeView> {
  int currentIndex = 0;
  EntityStatus status = EntityStatus.initial;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: inset20,
                child: Text(
                  state.selectedQuestionViewOption?.active == true
                      ? 'Presenting all questions for ${state.selectedQuestionViewOption?.name ?? ''}'
                      : 'Presenting ${state.selectedQuestionViewOption?.name ?? ''}',
                  style: textSemiBold18,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: status.isLoading
                      ? const Center(child: Loader())
                      : BlocProvider(
                          create: (context) => ExecuteAuditQuestionBloc(
                            context: context,
                            auditId: widget.auditId,
                            auditQuestion:
                                state.auditQuestionList[currentIndex],
                          ),
                          child: QuestionItemForFocusModeView(
                            questionIndex: currentIndex,
                            auditId: widget.auditId,
                            context: context,
                          ),
                        ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: inset20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (currentIndex > 0)
                      ElevatedButton(
                        onPressed: () => CustomAlert.checkFormDirty(() async {
                          setState(() {
                            status = EntityStatus.loading;
                            currentIndex--;
                          });

                          await Future.delayed(
                              const Duration(milliseconds: 500));

                          setState(() {
                            status = EntityStatus.success;
                          });
                        }, context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: purpleColor),
                        child: Text(
                          '<< Previous',
                          style: textNormal14.copyWith(color: Colors.white),
                        ),
                      ),
                    if (currentIndex > 0 &&
                        currentIndex < state.auditQuestionList.length - 1)
                      spacerx10,
                    if (currentIndex < state.auditQuestionList.length - 1)
                      ElevatedButton(
                        onPressed: () => CustomAlert.checkFormDirty(() async {
                          setState(() {
                            status = EntityStatus.loading;
                            currentIndex++;
                          });

                          await Future.delayed(
                              const Duration(milliseconds: 500));

                          setState(() {
                            status = EntityStatus.success;
                          });
                        }, context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        child: Text(
                          'Next >>',
                          style: textNormal14.copyWith(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
