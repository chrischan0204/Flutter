import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SummarySectionView extends StatelessWidget {
  final String auditId;
  const SummarySectionView({
    super.key,
    required this.auditId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            padding: inset10,
            decoration: BoxDecoration(border: Border.all(color: primaryColor)),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(
                    child: SectionSummaryView(),
                  ),
                  Expanded(
                    child: AuditSummaryView(auditId: auditId),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
