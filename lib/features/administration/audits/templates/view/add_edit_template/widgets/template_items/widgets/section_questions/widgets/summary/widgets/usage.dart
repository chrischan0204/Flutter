import '/common_libraries.dart';

class UsageView extends StatefulWidget {
  const UsageView({super.key});

  @override
  State<UsageView> createState() => _UsageViewState();
}

class _UsageViewState extends State<UsageView> {
  @override
  void initState() {
    context.read<TemplateDetailBloc>().add(TemplateDetailUsageSummaryLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: lightGreenAccent,
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'Usage',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UsageSummaryItemView(
                      label: 'Used in',
                      content:
                          '${state.templateUsageSummary?.usedInAudits ?? ''} Audits',
                    ),
                    const CustomDivider(),
                    UsageSummaryItemView(
                      label: 'Last Used',
                      content:
                          ' Audit # ${state.templateUsageSummary?.auditNumber ?? ''}',
                    ),
                    const CustomDivider(),
                    UsageSummaryItemView(
                      label: 'Last Used By',
                      content: state.templateUsageSummary?.lastCreatedBy ?? '',
                    ),
                    const CustomDivider(),
                    UsageSummaryItemView(
                      label: 'Last used Audit Status',
                      content: state.templateUsageSummary?.auditStatus ?? '',
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class UsageSummaryItemView extends StatelessWidget {
  final String label;
  final String content;
  const UsageSummaryItemView({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RichText(
        text: TextSpan(
          text: '$label:   ',
          children: [
            TextSpan(
              text: content,
              style: textNormal14,
            )
          ],
          style: textSemiBold14,
        ),
      ),
    );
  }
}
