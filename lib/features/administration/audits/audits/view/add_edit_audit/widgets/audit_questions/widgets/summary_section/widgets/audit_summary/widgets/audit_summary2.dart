
import '../../../../../../../../widgets/widgets.dart';
import '/common_libraries.dart';

class AuditSummary2 extends StatelessWidget {
  const AuditSummary2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          if (state.auditSummary != null) {
            final audit = state.auditSummary!;
            return Column(
              children: [
                AuditDetailItemView(
                  label: 'Project',
                  content: audit.projectName ?? '--',
                ),
                AuditDetailItemView(
                  label: 'Completion',
                  content:
                      '${audit.completedPercent}% (${audit.answeredQuestions} of ${audit.questions})',
                ),
                AuditDetailItemView(
                  label: 'Observations',
                  content: audit.observations.toString(),
                  highlighted: true,
                ),
                AuditDetailItemView(
                  label: 'Action Items',
                  content: audit.actionItems.toString(),
                  highlighted: true,
                ),
                AuditDetailItemView(
                  label: 'Documents',
                  content: audit.documents.toString(),
                  highlighted: true,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
