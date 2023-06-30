import '../../action_item_information.dart';
import '/common_libraries.dart';

class ObservationViewForActionItem extends StatelessWidget {
  const ObservationViewForActionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        ActionItemInformationItemView(
          label: 'Generated Via',
          content: 'Audit',
        ),
        ActionItemInformationItemView(
          label: 'ID',
          content: 'SA0923-0028',
        ),
        ActionItemInformationItemView(
          label: 'Site',
          content: 'Dallas City Center',
        ),
        ActionItemInformationItemView(
          label: 'Company',
          content: '--',
        ),
        ActionItemInformationItemView(
          label: 'Project',
          content: '--',
        ),
        ActionItemInformationItemView(
          label: 'Created By',
          content: 'Cory Jeter',
        ),
        ActionItemInformationItemView(
          label: 'Priority Level',
          content: 'High',
        ),
      ],
    );
  }
}
