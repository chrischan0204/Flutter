import '/common_libraries.dart';

class MarkAsCompletedAuditView extends StatelessWidget {
  final String auditId;
  const MarkAsCompletedAuditView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuditDetailBloc(context, auditId),
      child: MarkAsCompletedAuditWidget(auditId: auditId),
    );
  }
}

class MarkAsCompletedAuditWidget extends StatefulWidget {
  final String auditId;
  const MarkAsCompletedAuditWidget({
    super.key,
    required this.auditId,
  });

  @override
  State<MarkAsCompletedAuditWidget> createState() =>
      _MarkAsCompletedAuditViewState();
}

class _MarkAsCompletedAuditViewState extends State<MarkAsCompletedAuditWidget> {
  static String pageTitle = 'Audit';
  static String pageLabel = 'Audit';

  bool checked = false;

  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailLoaded(auditId: widget.auditId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuditDetailBloc, AuditDetailState>(
      listener: (context, state) {
        // CustomNotification(
        //   context: context,
        //   notifyType: NotifyType.success,
        //   content: state.message,
        // ).showNotification();
        context.go('/audits/show/${widget.auditId}');
      },
      listenWhen: (previous, current) =>
          previous.auditStatusChangeStatus != current.auditStatusChangeStatus &&
          current.auditStatusChangeStatus.isSuccess,
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () {},
          isDeletable: false,
          entity: state.auditSummary?.audit,
          onListButtonClick: () => context.go('/audits'),
          onEditButtonClick: () => context.go('/audits/edit/${widget.auditId}'),
          customDetailWidget: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  backgroundColor: const Color(0xFFFFEADE),
                  child: Padding(
                    padding: inset20,
                    child: Text(
                      '${state.auditSummary?.auditNumber ?? ''} - Completion Confirmation',
                      style: textSemiBold18,
                    ),
                  ),
                ),
                CustomBottomBorderContainer(
                  padding: inset20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'This action will mark Audit ${state.auditSummary?.auditNumber ?? ''} as completed.',
                        style: textNormal14,
                      ),
                      Padding(
                        padding: insety20,
                        child: Text(
                          'All answers will be finalized and saved. Once completed, the audit can then be sent for review.',
                          style: textNormal14,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: inset20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: checked,
                              onChanged: (value) {
                                setState(() {
                                  checked = value!;
                                });
                              }),
                          spacerx10,
                          Text(
                            'Confirm completion and proceed',
                            style: textNormal14,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CustomButton(
                            disabled: !checked,
                            onClick: checked
                                ? () {
                                    context
                                        .read<AuditDetailBloc>()
                                        .add(AuditDetailAuditMarkCompleted());
                                  }
                                : null,
                            backgroundColor: warnColor,
                            hoverBackgroundColor: warnHoverColor,
                            body: Text(
                              'Mark As Complete',
                              style: textNormal14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          spacerx20,
                          CustomButton(
                            onClick: () => context.go('/audits'),
                            backgroundColor: purpleColor,
                            hoverBackgroundColor: purpleHoverColor,
                            body: Text(
                              'Cancel Completion',
                              style: textNormal14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
