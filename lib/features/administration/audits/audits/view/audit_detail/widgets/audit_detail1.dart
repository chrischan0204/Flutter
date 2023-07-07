import '../../../../../../../common_libraries.dart';
import '../../widgets/widgets.dart';

class AuditDetailView1 extends StatelessWidget {
  const AuditDetailView1({super.key});

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
                label: 'Owner',
                content: audit.owner ?? '--',
              ),
              AuditDetailItemView(
                label: 'Last executed',
                content: audit.formatedLastModifiedOn,
              ),
              AuditDetailItemView(
                label: 'Sections',
                content: audit.sections.toString(),
              ),
              AuditDetailItemView(
                label: 'Site',
                content: audit.siteName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Completion',
                content:
                    '${audit.completedPercent}% (${audit.answeredQuestions} of ${audit.questions})',
                highlighted: true,
              ),
              AuditDetailItemView(
                label: 'Observations',
                content: audit.observations.toString(),
                highlighted: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
