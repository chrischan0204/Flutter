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
      child: ApproveEditAuditWidget(auditId: auditId),
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
    return BlocBuilder<AuditDetailBloc, AuditDetailState>(
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () {},
          isDeletable: false,
          entity: state.auditSummary?.audit,
          onListButtonClick: () => context.go('/audits/list'),
          onEditButtonClick: () => context.go('/audits/edit/${widget.auditId}'),
          customDetailWidget: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  child: Padding(
                    padding: inset20,
                    child: Text(
                      '${state.auditSummary?.auditNumber ?? ''} - Update Confirmation',
                      style: textNormal18,
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
                                    text: 'Check electric wiring',
                                    style: textNormal18.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'To:  ',
                                style: textNormal18,
                                children: [
                                  TextSpan(
                                    text: 'Electric HVAC inspection',
                                    style: textNormal18.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: insety20,
                        child: Text(
                          'There are 6 questions that have answers currently. These will be deleted as a result of this update.',
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
                            'Confirm delete and to proceed',
                            style: textNormal14,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CustomButton(
                            disabled: !checked,
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
