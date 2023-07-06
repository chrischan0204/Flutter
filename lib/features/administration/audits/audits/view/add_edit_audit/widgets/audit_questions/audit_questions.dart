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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuditDetailBloc(context, auditId)),
        BlocProvider(
            create: (context) => AuditQuestionsBloc(context, auditId: auditId))
      ],
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
        .add(AuditQuestionsAuditSectionListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummarySectionView(auditId: widget.auditId),
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
            const Expanded(
              flex: 2,
              child: AuditSectionsView(),
            ),
            Expanded(
              flex: 5,
              child: BlocBuilder<AuditQuestionsBloc, AuditQuestionsState>(
                builder: (context, state) {
                  if (state.selectedAuditSectionId != null) {
                    return const QuestionListView();
                  }
                  return Container();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
