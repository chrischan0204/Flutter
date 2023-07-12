import '../../../../../../../../widgets/detail_item.dart';
import '/common_libraries.dart';

class AuditSummary1 extends StatelessWidget {
  const AuditSummary1({super.key});

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
                  label: 'Owner',
                  content: audit.owner ?? '--',
                ),
                AuditDetailItemView(
                  label: 'Created on',
                  content: audit.formatedCreatedOn,
                ),
                AuditDetailItemView(
                  label: 'Status',
                  content: audit.auditStatusName ?? '--',
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
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
