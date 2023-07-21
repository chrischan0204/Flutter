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
                label: 'Created on',
                content: audit.formatedCreatedOn,
              ),
              AuditDetailItemView(
                label: 'Last executed on',
                content: audit.formatedLastModifiedOn,
              ),
              AuditDetailItemView(
                label: 'Site',
                content: audit.siteName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Project',
                content: audit.projectName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Area',
                content: audit.area ?? '--',
              ),
              AuditDetailItemView(
                label: 'Companies',
                content: audit.companies ?? '--',
                twoLines: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
