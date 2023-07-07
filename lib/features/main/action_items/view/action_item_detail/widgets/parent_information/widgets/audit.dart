import '../../action_item_information.dart';
import '/common_libraries.dart';

class AuditViewForActionItem extends StatelessWidget {
  const AuditViewForActionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionItemDetailBloc, ActionItemDetailState>(
      builder: (context, state) {
        if (state.audit != null) {
          final audit = state.audit!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActionItemInformationItemView(
                label: 'Audit',
                content: audit.name ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'ID',
                content: audit.auditNumber ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Site',
                content: audit.siteName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Company',
                content: audit.companies,
              ),
              ActionItemInformationItemView(
                label: 'Project',
                content: audit.projectName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Created By',
                content: audit.owner ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Audit Date',
                content: audit.formatedAuditDate,
              ),
              CustomBottomBorderContainer(
                padding: inset12,
                child: Text(
                  'For question',
                  style: textNormal14,
                ),
              ),
              CustomBottomBorderContainer(
                padding: inset12,
                child: Text(
                  state.actionItemParentInfo?.forQuestion ?? '--',
                  style: textNormal14,
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
