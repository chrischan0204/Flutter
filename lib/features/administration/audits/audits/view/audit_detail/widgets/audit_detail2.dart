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
          final audit = state.audit!;
          return Column(
            children: [
              AuditDetailItemView(
                label: 'Created on',
                content: audit.createdOn ?? '--',
              ),
              AuditDetailItemView(
                label: 'Status',
                content: audit.auditStatusName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Questions',
                content: audit.questions.toString(),
              ),
              AuditDetailItemView(
                label: 'Project',
                content: audit.projectName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Action items',
                content: '4',
                highlighted: true,
              ),
              AuditDetailItemView(
                label: 'Images',
                content: '4',
                highlighted: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
