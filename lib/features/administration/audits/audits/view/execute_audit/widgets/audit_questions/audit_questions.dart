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
    return Card(
      child: Padding(
        padding: inset10,
        child: Column(
          children: [
            const AuditQuestionsHeaderView(),
            Expanded(
              child: CustomScrollViewWithBackButton(
                child: QuestionsListView(auditId: auditId),
              ),
            )
          ],
        ),
      ),
    );
  }
}
