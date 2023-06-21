import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditQuestionsView extends StatelessWidget {
  final String auditId;
  const AuditQuestionsView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuditQuestionsBloc(context),
      child: AuditQuestionsWidget(auditId: auditId),
    );
  }
}

class AuditQuestionsWidget extends StatefulWidget {
  final String auditId;
  const AuditQuestionsWidget({
    super.key,
    required this.auditId,
  });

  @override
  State<AuditQuestionsWidget> createState() => _AuditQuestionsWidgetState();
}

class _AuditQuestionsWidgetState extends State<AuditQuestionsWidget> {
  @override
  void initState() {
    context
        .read<AuditQuestionsBloc>()
        .add(AuditQuestionsSnapshotListLoaded(auditId: emptyGuid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SummarySectionView(),
        Padding(
          padding: inset20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Define audit page. An audits sections, questions and other composition can be defined here.',
                style: textNormal14,
              ),
              const CustomDivider(),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: inset10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: inset20,
                        child: Text(
                          'Audit Sections',
                          style: textSemiBold14,
                        ),
                      ),
                      const CustomDivider(),
                      Placeholder(),
                    ],
                  ),
                ),
              ),
            ),
            spacerx10,
            Expanded(
              flex: 5,
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    Padding(
                      padding: inset20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Questions from Electric Inspection',
                            style: textSemiBold14,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: warnColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                            ),
                            child: Text(
                              'Remove Entire Section',
                              style: textNormal12,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: inset10,
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor)),
                      child: Placeholder(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
