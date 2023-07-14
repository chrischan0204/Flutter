import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditQuestionsView extends StatefulWidget {
  final String auditId;
  const AuditQuestionsView({
    super.key,
    required this.auditId,
  });

  @override
  State<AuditQuestionsView> createState() => _AuditQuestionsViewState();
}

class _AuditQuestionsViewState extends State<AuditQuestionsView> {
  @override
  void initState() {
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
    return Card(
      child: Padding(
        padding: inset10,
        child: Column(
          children: [
            const AuditQuestionsHeaderView(),
            Expanded(
              child: CustomScrollViewWithBackButton(
                child: QuestionsListView(auditId: widget.auditId),
              ),
            )
          ],
        ),
      ),
    );
  }
}
