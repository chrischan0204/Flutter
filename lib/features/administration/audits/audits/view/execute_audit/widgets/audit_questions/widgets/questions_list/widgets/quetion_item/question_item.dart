import 'package:expandable/expandable.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionItemView extends StatelessWidget {
  final String auditId;
  final int questionIndex;
  final BuildContext context;
  const QuestionItemView({
    super.key,
    required this.auditId,
    required this.questionIndex,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditQuestionBloc, ExecuteAuditQuestionState>(
      builder: (context, state) {
        return ExpandableNotifier(
          child: ScrollOnExpand(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      // tapBodyToExpand: true,
                      // tapBodyToCollapse: true,
                      iconPlacement: ExpandablePanelIconPlacement.right,
                    ),
                    header: Padding(
                      padding: insetx12,
                      child: Row(
                        children: [
                          Expanded(
                            child: state.level1Followup != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<
                                                      ExecuteAuditQuestionBloc>()
                                                  .add(
                                                      const ExecuteAuditQuestionLevelChanged(
                                                          level: 0));
                                            },
                                            child: Text(
                                              'Question',
                                              style: textNormal18.copyWith(
                                                color: textBlue,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: textBlue,
                                                decorationThickness: 2,
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
                                            onPressed:
                                                state.level2Followup != null
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
                                                decoration:
                                                    state.level2Followup != null
                                                        ? TextDecoration
                                                            .underline
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                          ),
                        ],
                      ),
                    ),
                    collapsed: Container(),
                    expanded: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => ExecuteAuditObservationBloc(
                            context: context,
                            auditQuestion: state.level0,
                          ),
                        ),
                        BlocProvider(
                          create: (context) => ExecuteAuditActionItemBloc(
                            context: context,
                            auditQuestion: state.level0,
                          ),
                        ),
                        BlocProvider(
                          create: (context) => ExecuteAuditCommentBloc(
                            context: context,
                            auditQuestion: state.level0,
                          ),
                        ),
                        BlocProvider(
                          create: (context) => ExecuteAuditDocumentBloc(
                            context: context,
                            auditQuestion: state.level0,
                          ),
                        ),
                      ],
                      child: QuestionItemBodyView(
                        questionIndex: questionIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
  Future<bool> checkFormDirty(bool isDirty) async {
    bool success = false;

    if (isDirty) {
      await AwesomeDialog(
        context: context,
        width: MediaQuery.of(context).size.width / 4,
        dialogType: DialogType.question,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Confirm',
        dialogBorderRadius: BorderRadius.circular(5),
        desc: 'Data that was entered will be lost ..... Proceed?',
        buttonsTextStyle: const TextStyle(color: Colors.white),
        showCloseIcon: true,
        btnCancelOnPress: () => success = false,
        btnOkOnPress: () {
          success = true;
          // context.read<FormDirtyBloc>().add(FormDirtyChanged(isDirty: isDirty));
        },
        btnOkText: 'Proceed',
        buttonsBorderRadius: BorderRadius.circular(3),
        padding: const EdgeInsets.all(10),
      ).show();
    } else {
      success = true;
    }
    return success;
  }

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
                                        Expanded(
                                          child: Text(
                                            response.name,
                                            style: textNormal14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  spacerx10,
                                  if (state.selectedResponse == response)
                                    Row(
                                      children: [
                                        if (response.commentRequired == true)
                                          const CustomBadge(
                                            label: 'Comment',
                                            color:
                                                Color.fromRGBO(36, 114, 151, 1),
                                          ),
                                        spacerx4,
                                        if (response.actionItemRequired == true)
                                          const CustomBadge(
                                            label: 'Action Item',
                                            color:
                                                Color.fromRGBO(36, 114, 151, 1),
                                          ),
                                        if (response.actionItemRequired == true)
                                          spacerx4,
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
                        tabs: const {
                          'Observations': AuditObservationView(),
                          'Action Items': AuditActionItemView(),
                          'Comments': AuditCommentView(),
                          'Images/Documents': ExecuteAuditDocumentView(),
                        },
                        onTabClick: (questionIndex, previous) async {
                          if (previous == 3) {
                            context
                                .read<ExecuteAuditObservationBloc>()
                                .add(ExecuteAuditObservationInited());
                            context
                                .read<ExecuteAuditActionItemBloc>()
                                .add(ExecuteAuditActionItemInited());
                            context
                                .read<ExecuteAuditCommentBloc>()
                                .add(ExecuteAuditCommentInited());
                            return true;
                          }
                          late bool isDirty;
                          if (previous == 0) {
                            isDirty = context
                                .read<ExecuteAuditObservationBloc>()
                                .state
                                .isDirty;
                            context
                                .read<ExecuteAuditActionItemBloc>()
                                .add(ExecuteAuditActionItemInited());
                            context
                                .read<ExecuteAuditCommentBloc>()
                                .add(ExecuteAuditCommentInited());
                          } else if (previous == 1) {
                            isDirty = context
                                .read<ExecuteAuditActionItemBloc>()
                                .state
                                .isDirty;

                            context
                                .read<ExecuteAuditObservationBloc>()
                                .add(ExecuteAuditObservationInited());
                            context
                                .read<ExecuteAuditCommentBloc>()
                                .add(ExecuteAuditCommentInited());
                          } else if (previous == 2) {
                            isDirty = context
                                .read<ExecuteAuditCommentBloc>()
                                .state
                                .isDirty;

                            context
                                .read<ExecuteAuditActionItemBloc>()
                                .add(ExecuteAuditActionItemInited());
                            context
                                .read<ExecuteAuditObservationBloc>()
                                .add(ExecuteAuditObservationInited());
                          }
                          return await checkFormDirty(isDirty);
                        },
                      ),
                    ),
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
