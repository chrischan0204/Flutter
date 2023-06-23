import '../../../../../../widgets/detail_item.dart';
import '/common_libraries.dart';

class AuditSummary2 extends StatelessWidget {
  const AuditSummary2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
        builder: (context, state) {
          if (state.loadedAudit != null) {
            final audit = state.loadedAudit!;
            return Column(
              children: [
                AuditDetailItemView(
                  label: 'Project',
                  content: audit.projectName ?? '--',
                ),
                AuditDetailItemView(
                  label: 'Completion',
                  content: '${audit.completed} of 33',
                  highlighted: true,
                ),
                AuditDetailItemView(
                  label: 'Observations',
                  content: '2',
                  highlighted: true,
                ),
                AuditDetailItemView(
                  label: 'Action Items',
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
          }
          return Container();
        },
      ),
    );
  }
}
