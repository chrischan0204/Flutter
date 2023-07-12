import '/common_libraries.dart';

class QuestionItemView extends CustomExpansionPanel {
  final String auditId;
  final int index;
  final bool collapsed;
  final AuditQuestion auditQuestion;
  final AuditQuestion? followUpLevel1Question;
  final AuditQuestion? followUpLevel2Question;
  final AuditResponseScaleItem? selectedResponse;
  final AuditResponseScaleItem? selectedResponseForLevel0;
  final AuditResponseScaleItem? selectedResponseForLevel1;
  QuestionItemView({
    required this.auditId,
    required this.auditQuestion,
    required this.index,
    required this.collapsed,
    required this.followUpLevel1Question,
    required this.followUpLevel2Question,
    required this.selectedResponse,
    required this.selectedResponseForLevel0,
    required this.selectedResponseForLevel1,
  }) : super(
          headerBuilder: (BuildContext context, bool isExpanded) {
            if (followUpLevel1Question != null) {
              return Padding(
                padding: insetx12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => context
                              .read<ExecuteAuditBloc>()
                              .add(ExecuteAuditLevelChanged(
                                questionIndex: index,
                                isLevel0: true,
                              )),
                          child: Text(
                            'Question',
                            style: textNormal18.copyWith(
                              color: textBlue,
                              decoration: TextDecoration.underline,
                              decorationColor: textBlue,
                            ),
                          ),
                        ),
                        Text(
                          '>',
                          style: TextStyle(
                            color: textBlue,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context
                              .read<ExecuteAuditBloc>()
                              .add(ExecuteAuditLevelChanged(
                                questionIndex: index,
                                isLevel0: false,
                              )),
                          child: Text(
                            'Follow up Question (Option=\'${selectedResponseForLevel0?.name}\')',
                            style: textNormal14.copyWith(
                              decoration: TextDecoration.underline,
                              color: textBlue,
                              decorationColor: textBlue,
                            ),
                          ),
                        ),
                        if (followUpLevel2Question != null)
                          Text(
                            '>',
                            style: TextStyle(
                              color: textBlue,
                            ),
                          ),
                        if (followUpLevel2Question != null)
                          Text(
                            'Level Two Follow up Question (For Option=\'${selectedResponseForLevel1?.name}\')',
                            style: textNormal12.copyWith(
                              color: textBlue,
                            ),
                          )
                      ],
                    ),
                    spacery5,
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Q${index + 1}: ${followUpLevel2Question != null ? followUpLevel2Question.question : followUpLevel1Question.question}',
                        style: textSemiBold16,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: insetx12,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Q${index + 1}: ${auditQuestion.question}',
                      style: textSemiBold16,
                    ),
                  ),
                  CustomBadge(
                    label: auditQuestion.questionStatusName,
                    color: auditQuestion.questionStatus == 0
                        ? warnColor
                        : primaryColor,
                  )
                ],
              ),
            );
          },
          backgroundColor: Colors.white,
          isExpanded: collapsed,
          body: BlocProvider(
            create: (context) => ExecuteAuditQuestionBloc(
              context: context,
              auditId: auditId,
              auditQuestion: auditQuestion,
            ),
            child: QuestionItemBodyView(
              questionIndex: index,
              auditQuestion: auditQuestion,
              selectedResponse: selectedResponse,
            ),
          ),
        );
}

class QuestionItemBodyView extends StatelessWidget {
  final int questionIndex;
  final AuditQuestion auditQuestion;
  final AuditResponseScaleItem? selectedResponse;
  const QuestionItemBodyView({
    super.key,
    required this.questionIndex,
    required this.auditQuestion,
    required this.selectedResponse,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditQuestionBloc, ExecuteAuditQuestionState>(
      builder: (context, state) {
        if (state.questionLoadStatus.isLoading) {
          return Center(
              child: Padding(
            padding: insety30,
            child: const Loader(),
          ));
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomBottomBorderContainer(
                      padding: insetx12y24,
                      child: Text(
                        'Response',
                        style: textNormal14,
                      ),
                    ),
                    for (final response in auditQuestion.responseScaleItems)
                      CustomBottomBorderContainer(
                        padding: inset20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Radio(
                                      value: response,
                                      groupValue: selectedResponse,
                                      onChanged: (value) => context
                                          .read<ExecuteAuditBloc>()
                                          .add(ExecuteAuditResponseSelected(
                                            questionId: auditQuestion.id,
                                            questionIndex: questionIndex,
                                            response: value!,
                                          ))),
                                  spacerx20,
                                  Text(
                                    response.name,
                                    style: textNormal14,
                                  ),
                                ],
                              ),
                            ),
                            if (selectedResponse == response)
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    if (response.commentRequired == true)
                                      const CustomBadge(
                                        label: 'Comment',
                                        color: Color.fromRGBO(36, 114, 151, 1),
                                      ),
                                    if (response.actionItemRequired == true)
                                      const CustomBadge(
                                        label: 'Action Item',
                                        color: Color.fromRGBO(36, 114, 151, 1),
                                      ),
                                    if (response.followUpRequired == true)
                                      CustomBadge(
                                        label: 'Follow up ->',
                                        color: primaryColor,
                                        onClick: () {
                                          context
                                              .read<ExecuteAuditQuestionBloc>()
                                              .add(ExecuteAuditQuestionLoaded(
                                                  questionIndex: questionIndex,
                                                  responseId: response.id));
                                        },
                                      ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomBottomBorderContainer(
                      padding: insetx12y24,
                      child: Text(
                        'Assests',
                        style: textNormal14,
                      ),
                    ),
                    Padding(
                      padding: insetx12y24,
                      child: CustomTabBar(
                        activeIndex: 0,
                        tabs: const {
                          'Observations': Text('Observations'),
                          'Action Items': Text('Action Items'),
                          'Comments': Text('Comments'),
                          'Images/Documents': Text('Images/Documents'),
                        },
                        onTabClick: (index) async {
                          return true;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
