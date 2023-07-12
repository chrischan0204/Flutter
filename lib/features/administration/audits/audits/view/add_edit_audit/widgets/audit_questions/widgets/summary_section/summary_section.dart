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
            padding: inset20,
            decoration: BoxDecoration(border: Border.all(color: primaryColor)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}
