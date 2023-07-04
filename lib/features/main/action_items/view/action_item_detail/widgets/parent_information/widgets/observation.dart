import '../../action_item_information.dart';
import '/common_libraries.dart';

class ObservationViewForActionItem extends StatelessWidget {
  const ObservationViewForActionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionItemDetailBloc, ActionItemDetailState>(
      builder: (context, state) {
        final actionItemParentInfo = state.actionItemParentInfo!;
        if (state.actionItemParentInfo != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ActionItemInformationItemView(
                label: 'Generated Via',
                content: 'Observation:',
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
                label: 'Priority Level',
                content: actionItemParentInfo.priorityLevelName,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
