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
            padding: inset20.copyWith(bottom: 100),
            decoration: BoxDecoration(border: Border.all(color: primaryColor)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BlocProvider(
                    create: (context) => AuditDetailBloc(context, auditId),
                    child: SectionSummaryView(auditId: auditId),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(child: AuditSummary1()),
                      Expanded(child: AuditSummary2())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
