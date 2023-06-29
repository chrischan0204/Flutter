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
                label: 'Created on',
                content: audit.formatedCreatedOn,
              ),
              AuditDetailItemView(
                label: 'Status',
                content: audit.auditStatusName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Area',
                content: audit.area ?? '--',
              ),
              AuditDetailItemView(
                label: 'Project',
                content: audit.projectName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Action items',
                content: audit.actionItems.toString(),
                highlighted: true,
              ),
              AuditDetailItemView(
                label: 'Images',
                content: audit.documents.toString(),
                highlighted: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
