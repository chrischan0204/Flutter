import '../../action_item_information.dart';
import '/common_libraries.dart';

class ObservationViewForActionItem extends StatelessWidget {
  const ObservationViewForActionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionItemDetailBloc, ActionItemDetailState>(
      builder: (context, state) {
        if (state.observation != null) {
          final observation = state.observation!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActionItemInformationItemView(
                label: 'Observation:',
                content: observation.description ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Site',
                content: observation.assessmentSiteName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Company',
                content: observation.assessmentCompanyName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Project',
                content: observation.assessmentProjectName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Created By',
                content: observation.createdByUserName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Priority Level',
                content: observation.assessmentPriorityLevelName ?? '--',
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
