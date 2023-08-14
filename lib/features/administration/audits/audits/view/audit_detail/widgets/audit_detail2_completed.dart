import '../../../../../../../common_libraries.dart';
import '../../widgets/detail_item.dart';

class AuditDetail2CompletedView extends StatelessWidget {
  const AuditDetail2CompletedView({super.key});

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
                label: 'Area',
                content: audit.area ?? '--',
              ),
              AuditDetailItemView(
                label: 'Companies',
                content: audit.companies ?? '--',
                twoLines: true,
              ),
              AuditDetailItemView(
                label: 'Project',
                content: audit.projectName ?? '--',
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
