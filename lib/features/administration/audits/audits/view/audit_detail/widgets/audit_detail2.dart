import '../../../../../../../common_libraries.dart';
import '../../widgets/widgets.dart';

class AuditDetailView2 extends StatelessWidget {
  const AuditDetailView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          final audit = state.auditSummary!;
          return Column(
            children: [
              AuditDetailItemView(
                label: 'Status',
                content: audit.auditStatusName ?? '--',
                highlighted: true,
              ),
              AuditDetailItemView(
                label: 'Completion',
                content:
                    '${audit.completedPercent}% (${audit.answeredQuestions} of ${audit.questions})',
              ),
              AuditDetailItemView(
                label: 'Sections',
                content: audit.sections.toString(),
              ),
              AuditDetailItemView(
                label: 'Observations',
                content: audit.observations.toString(),
              ),
              AuditDetailItemView(
                label: 'Action items',
                content: audit.actionItems.toString(),
              ),
              AuditDetailItemView(
                label: 'Images',
                content: audit.documents.toString(),
              ),
              AuditDetailItemView(
                label: 'Inspectors',
                content: audit.inspectors ?? '--',
                twoLines: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
