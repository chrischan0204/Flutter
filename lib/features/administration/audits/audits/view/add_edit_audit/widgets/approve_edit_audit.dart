import '/common_libraries.dart';

class ApproveEditAuditView extends StatelessWidget {
  final String auditId;
  const ApproveEditAuditView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuditDetailBloc(context, auditId),
      child: ApproveEditAuditWidget(
        auditId: auditId,
      ),
    );
  }
}

class ApproveEditAuditWidget extends StatefulWidget {
  final String auditId;
  const ApproveEditAuditWidget({
    super.key,
    required this.auditId,
  });

  @override
  State<ApproveEditAuditWidget> createState() => _ApproveEditAuditViewState();
}

class _ApproveEditAuditViewState extends State<ApproveEditAuditWidget> {
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
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
        } else if (state.status.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (ctx, state) {
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
                  backgroundColor: const Color(0xffDDDFC0),
                  child: Padding(
                    padding: inset20,
                    child: Text(
                      '${state.auditSummary?.auditNumber ?? ''} - Update Confirmation',
                      style: textSemiBold18,
                    ),
                  ),
                ),
                CustomBottomBorderContainer(
                  padding: inset20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomBottomBorderContainer(
                        padding: insety20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'This update will change the template for this audit and is a significant change. As a result of this change, existing questions will be deleted and replaced with new ones. Any observations, images, action items will also be deleted along with the questions',
                              style: textNormal14,
                            ),
                            spacery30,
                            RichText(
                              text: TextSpan(
                                text: 'From:  ',
                                style: textNormal18,
                                children: [
                                  TextSpan(
                                    text: state.auditSummary?.templateName,
                                    style: textNormal18.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
                              builder: (context, state) {
                                return RichText(
                                  text: TextSpan(
                                    text: 'To:  ',
                                    style: textNormal18,
                                    children: [
                                      TextSpan(
                                        text: state.template?.name,
                                        style: textNormal18.copyWith(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: insety20,
                        child: Text(
                          'There are ${state.auditSummary?.answeredQuestions ?? ''} questions that have answers currently. These will be deleted as a result of this update.',
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
                                    context.read<AddEditAuditBloc>().add(
                                        AddEditAuditEdited(
                                            id: widget.auditId,
                                            userId: context
                                                .read<AuthBloc>()
                                                .state
                                                .authUser!
                                                .id));
                                  }
                                : null,
                            backgroundColor: warnColor,
                            hoverBackgroundColor: warnHoverColor,
                            body: Text(
                              'Delete and update',
                              style: textNormal14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          spacerx20,
                          CustomButton(
                            onClick: () => GoRouter.of(context).go('/audits'),
                            backgroundColor: purpleColor,
                            hoverBackgroundColor: purpleHoverColor,
                            body: Text(
                              'Keep as is',
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
