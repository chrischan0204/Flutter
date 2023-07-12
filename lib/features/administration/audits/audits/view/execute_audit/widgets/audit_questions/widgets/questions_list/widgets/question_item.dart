import '/common_libraries.dart';

class QuestionItemView extends CustomExpansionPanel {
  final String auditId;
  // final String question;
  // final String status;
  // final List<AuditResponseScaleItem> responseList;
  final int index;
  final bool collapsed;
  final AuditQuestion auditQuestion;
  QuestionItemView({
    required this.auditId,
    // required this.question,
    // required this.status,
    // required this.responseList,
    required this.auditQuestion,
    required this.index,
    required this.collapsed,
  }) : super(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: insetx12,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Q$index: ${auditQuestion.question}',
                      style: textSemiBold16,
                    ),
                  ),
                  CustomBadge(
                    label: auditQuestion.questionStatus == 0
                        ? 'Unanswered'
                        : 'Answered',
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
            child: const QuestionItemBodyView(),
          ),
        );
}

class QuestionItemBodyView extends StatefulWidget {
  const QuestionItemBodyView({super.key});

  @override
  State<QuestionItemBodyView> createState() => _QuestionItemBodyViewState();
}

class _QuestionItemBodyViewState extends State<QuestionItemBodyView> {
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
                    for (final response in state.auditQuestion.responseScaleItems)
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
                                      groupValue: state.selectedResponse,
                                      onChanged: (value) => context
                                          .read<ExecuteAuditQuestionBloc>()
                                          .add(
                                              ExecuteAuditQuestionResponseSelected(
                                                  response: value!))),
                                  spacerx20,
                                  Text(
                                    response.name,
                                    style: textNormal14,
                                  ),
                                ],
                              ),
                            ),
                            if (state.selectedResponse == response)
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
