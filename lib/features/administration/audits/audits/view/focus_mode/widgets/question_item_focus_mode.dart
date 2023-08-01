import '../../execute_audit/widgets/audit_questions/widgets/questions_list/widgets/quetion_item/widgets/widgets.dart';
import '/common_libraries.dart';

class QuestionItemForFocusModeView extends StatelessWidget {
  final String auditId;
  final int questionIndex;
  final BuildContext context;
  const QuestionItemForFocusModeView({
    super.key,
    required this.auditId,
    required this.questionIndex,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditQuestionBloc, ExecuteAuditQuestionState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: insetx12,
              child: Row(
                children: [
                  Expanded(
                    child: state.level1Followup != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context.read<ExecuteAuditQuestionBloc>().add(
                                          const ExecuteAuditQuestionLevelChanged(
                                              level: 0));
                                    },
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
                                    onPressed: state.level2Followup != null
                                        ? () {
                                            context
                                                .read<
                                                    ExecuteAuditQuestionBloc>()
                                                .add(
                                                    const ExecuteAuditQuestionLevelChanged(
                                                        level: 1));
                                          }
                                        : null,
                                    child: Text(
                                      'Follow up Question (Option=\'${state.selectedlevel0Response?.name}\')',
                                      style: textNormal14.copyWith(
                                        decoration: state.level2Followup != null
                                            ? TextDecoration.underline
                                            : null,
                                        color: textBlue,
                                        decorationColor: textBlue,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ),
                                  if (state.level2Followup != null)
                                    Text(
                                      '>',
                                      style: TextStyle(
                                        color: textBlue,
                                      ),
                                    ),
                                  if (state.level2Followup != null)
                                    TextButton(
                                      onPressed: null,
                                      child: Text(
                                        'Level Two Follow up Question (For Option=\'${state.selectedlevel1Response?.name}\')',
                                        style: textNormal12.copyWith(
                                          color: textBlue,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              spacery5,
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Q${questionIndex + 1}: ${state.level2Followup != null ? state.level2Followup?.question : state.level1Followup?.question}',
                                  style: textSemiBold16,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Q${questionIndex + 1}: ${state.auditQuestion?.question}',
                            style: textSemiBold16,
                          ),
                  ),
                  CustomBadge(
                    label: state.level0.questionStatusName,
                    color: state.level0.questionStatus == 0
                        ? warnColor
                        : primaryColor,
                  )
                ],
              ),
            ),
            QuestionItemBodyView(
              questionIndex: questionIndex,
            )
          ],
        );
      },
    );
  }
}

class QuestionItemBodyView extends StatefulWidget {
  final int questionIndex;
  const QuestionItemBodyView({
    super.key,
    required this.questionIndex,
  });

  @override
  State<QuestionItemBodyView> createState() => _QuestionItemBodyViewState();
}

class _QuestionItemBodyViewState extends State<QuestionItemBodyView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditQuestionBloc, ExecuteAuditQuestionState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: state.questionLoadStatus.isLoading
                  ? Center(
                      child: Padding(
                      padding: insety30,
                      child: const Loader(),
                    ))
                  : Card(
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
                          for (final response
                              in state.auditQuestion?.responseScaleItems ?? [])
                            CustomBottomBorderContainer(
                              padding: inset20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Radio(
                                            value: response,
                                            groupValue: state.selectedResponse,
                                            onChanged: (value) => context
                                                .read<
                                                    ExecuteAuditQuestionBloc>()
                                                .add(
                                                    ExecuteAuditQuestionResponseSelected(
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
                                  if (state.selectedResponse == response)
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          if (response.commentRequired == true)
                                            const CustomBadge(
                                              label: 'Comment',
                                              color: Color.fromRGBO(
                                                  36, 114, 151, 1),
                                            ),
                                          if (response.actionItemRequired ==
                                              true)
                                            const CustomBadge(
                                              label: 'Action Item',
                                              color: Color.fromRGBO(
                                                  36, 114, 151, 1),
                                            ),
                                          if (response.followUpRequired == true)
                                            CustomBadge(
                                              label: 'Follow up ->',
                                              color: primaryColor,
                                              onClick: () {
                                                context
                                                    .read<
                                                        ExecuteAuditQuestionBloc>()
                                                    .add(
                                                        ExecuteAuditQuestionLoaded(
                                                            responseId:
                                                                response.id));
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
                        'Assets',
                        style: textNormal14,
                      ),
                    ),
                    Padding(
                      padding: insety20,
                      child: CustomTabBar(
                        activeIndex: 0,
                        tabs: {
                          'Observations': BlocProvider(
                            create: (context) => ExecuteAuditObservationBloc(
                              context: context,
                              auditQuestion: state.level0,
                            ),
                            child: const AuditObservationView(),
                          ),
                          'Action Items': BlocProvider(
                            create: (context) => ExecuteAuditActionItemBloc(
                              context: context,
                              auditQuestion: state.level0,
                            ),
                            child: const AuditActionItemView(),
                          ),
                          'Comments': BlocProvider(
                            create: (context) => ExecuteAuditCommentBloc(
                              context: context,
                              auditQuestion: state.level0,
                            ),
                            child: const AuditCommentView(),
                          ),
                          'Images/Documents': BlocProvider(
                            create: (context) => ExecuteAuditDocumentBloc(
                              context: context,
                              auditQuestion: state.level0,
                            ),
                            child: const ExecuteAuditDocumentView(),
                          ),
                        },
                        onTabClick: (questionIndex, previous) async {
                          if (context.read<FormDirtyBloc>().state.isDirty ==
                              true) {
                            bool success = false;

                            if (context.read<FormDirtyBloc>().state.isDirty) {
                              await AwesomeDialog(
                                context: context,
                                width: MediaQuery.of(context).size.width / 4,
                                dialogType: DialogType.question,
                                headerAnimationLoop: false,
                                animType: AnimType.bottomSlide,
                                title: 'Confirm',
                                dialogBorderRadius: BorderRadius.circular(5),
                                desc:
                                    'Data that was entered will be lost ..... Proceed?',
                                buttonsTextStyle:
                                    const TextStyle(color: Colors.white),
                                showCloseIcon: true,
                                btnCancelOnPress: () => success = false,
                                btnOkOnPress: () {
                                  success = true;
                                  context.read<FormDirtyBloc>().add(
                                      const FormDirtyChanged(isDirty: false));
                                },
                                btnOkText: 'Proceed',
                                buttonsBorderRadius: BorderRadius.circular(3),
                                padding: const EdgeInsets.all(10),
                              ).show();
                            }
                            return success;
                          } else {
                            return true;
                          }
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
