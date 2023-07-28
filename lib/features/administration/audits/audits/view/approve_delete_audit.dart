import '/common_libraries.dart';

class ApproveDeleteAuditView extends StatelessWidget {
  final String auditId;
  const ApproveDeleteAuditView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuditDetailBloc(context, auditId),
      child: ApproveDeleteAuditWidget(auditId: auditId),
    );
  }
}

class ApproveDeleteAuditWidget extends StatefulWidget {
  final String auditId;
  const ApproveDeleteAuditWidget({
    super.key,
    required this.auditId,
  });

  @override
  State<ApproveDeleteAuditWidget> createState() =>
      _ApproveDeleteAuditViewState();
}

class _ApproveDeleteAuditViewState extends State<ApproveDeleteAuditWidget> {
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
        CustomNotification(
          context: context,
          notifyType: NotifyType.success,
          content: state.message,
        ).showNotification();
        context.go('/audits');
      },
      listenWhen: (previous, current) =>
          previous.status != current.status && current.status.isSuccess,
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () {},
          isDeletable: false,
          entity: state.auditSummary?.audit,
          onListButtonClick: () => context.go('/audits'),
          onEditButtonClick: () =>
              context.go('/audits/edit/${widget.auditId}'),
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
                      '${state.auditSummary?.auditNumber ?? ''} - Delete Confirmation',
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
                        'This action will delete Audit ${state.auditSummary?.auditNumber ?? ''}.',
                        style: textNormal14,
                      ),
                      Padding(
                        padding: insety20,
                        child: Text(
                          'There are ${state.auditSummary?.answeredQuestions ?? ''} questions that have answers currently. These will be deleted as a result of this delete along with its action items, observations and image uploads.',
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
                            'Confirm delete and proceed',
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
                                        .add(AuditDetailAuditDeleted());
                                  }
                                : null,
                            backgroundColor: warnColor,
                            hoverBackgroundColor: warnHoverColor,
                            body: Text(
                              'Delete',
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
                              'Don\'t delete',
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
