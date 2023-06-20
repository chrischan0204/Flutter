import '/common_libraries.dart';

class AuditQuestionsView extends StatelessWidget {
  final String auditId;
  const AuditQuestionsView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: inset20,
                child: Text(
                  'Summary Section',
                  style: textSemiBold14,
                ),
              ),
              Container(
                padding: inset20.copyWith(bottom: 100),
                decoration:
                    BoxDecoration(border: Border.all(color: primaryColor)),
                child: Row(
                  children: [
                    Expanded(
                      child: Placeholder(),
                    ),
                    spacer20,
                    Expanded(
                      child: Placeholder(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            spacer10,
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
