import '../../../../../../common_libraries.dart';
import 'widgets/widgets.dart';

class AuditDetailForNotCompletedView extends StatelessWidget {
  final String auditNumber;
  const AuditDetailForNotCompletedView({
    super.key,
    required this.auditNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          child: Padding(
            padding: inset10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: inset20,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: grey))),
                  child: Text(
                    auditNumber,
                    style: textNormal20,
                  ),
                ),
                const IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 2, child: SectionSummaryView()),
                      Expanded(flex: 1, child: AuditDetailView1()),
                      Expanded(flex: 1, child: AuditDetailView2()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        spacery20,
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: AuditSectionsView()),
              Expanded(
                flex: 3,
                child: QuestionsListView(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
