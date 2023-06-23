import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditQuestionsView extends StatelessWidget {
  const AuditQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: inset10,
        child: Column(
          children: const [
            AuditQuestionsHeaderView(),
            Expanded(
              child: CustomScrollViewWithBackButton(
                child: QuestionsListView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
