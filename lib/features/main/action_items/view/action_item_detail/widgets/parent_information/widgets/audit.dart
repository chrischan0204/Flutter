import '../../action_item_information.dart';
import '/common_libraries.dart';

class AuditViewForActionItem extends StatelessWidget {
  const AuditViewForActionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionItemDetailBloc, ActionItemDetailState>(
      builder: (context, state) {
        if (state.actionItemParentInfo != null) {
          final actionItemParentInfo = state.actionItemParentInfo!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ActionItemInformationItemView(
                label: 'Generated Via',
                content: 'Audit:',
              ),
              ActionItemInformationItemView(
                label: 'ID',
                content: actionItemParentInfo.id,
              ),
              ActionItemInformationItemView(
                label: 'Site',
                content: actionItemParentInfo.siteName,
              ),
              ActionItemInformationItemView(
                label: 'Company',
                content: actionItemParentInfo.companyName,
              ),
              ActionItemInformationItemView(
                label: 'Project',
                content: actionItemParentInfo.projectName,
              ),
              ActionItemInformationItemView(
                label: 'Created By',
                content: actionItemParentInfo.createdByName,
              ),
              ActionItemInformationItemView(
                label: 'Audit Date',
                content: actionItemParentInfo.date,
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
                  actionItemParentInfo.forQuestion,
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
