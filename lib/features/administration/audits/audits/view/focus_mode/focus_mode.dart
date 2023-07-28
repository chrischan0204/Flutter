import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditFocusModeView extends StatefulWidget {
  final String auditId;
  const AuditFocusModeView({
    super.key,
    required this.auditId,
  });

  @override
  State<AuditFocusModeView> createState() => _AuditFocusModeViewState();
}

class _AuditFocusModeViewState extends State<AuditFocusModeView> {
  bool isStart = false;
  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailLoaded(auditId: widget.auditId));

    context.read<ExecuteAuditBloc>()
      ..add(ExecuteAuditPriorityLevelListLoaded())
      ..add(ExecuteAuditObservationTypeListLoaded())
      ..add(ExecuteAuditSiteListLoaded())
      ..add(ExecuteAuditAssigneeListLoaded())
      ..add(ExecuteAuditCategoryListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: inset12,
      child: Column(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: insetx24y12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<AuditDetailBloc, AuditDetailState>(
                    builder: (context, state) {
                      return Text(
                        'Execute Audit - ${state.auditSummary?.name ?? ''}',
                        style: textSemiBold18,
                      );
                    },
                  ),
                  Row(
                    children: [
                      if (isStart)
                        CustomButton(
                          backgroundColor: successColor,
                          hoverBackgroundColor: successHoverColor,
                          iconData: PhosphorIcons.regular.alignLeft,
                          text: 'Questions Selector',
                          onClick: () {
                            setState(() {
                              isStart = false;
                            });
                          },
                        ),
                      if (isStart) spacerx10,
                      CustomButton(
                        backgroundColor: purpleColor,
                        hoverBackgroundColor: purpleHoverColor,
                        iconData: PhosphorIcons.regular.alignLeft,
                        text: 'Exit Focus Mode',
                        onClick: () => GoRouter.of(context)
                            .go('/audits/execute/${widget.auditId}'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: isStart
                ? ExecuteFocusModeView(auditId: widget.auditId)
                : QuestionSelectorForFocusMode(
                    onStart: () => setState(() {
                      isStart = true;
                    }),
                  ),
          )
        ],
      ),
    );
  }
}
