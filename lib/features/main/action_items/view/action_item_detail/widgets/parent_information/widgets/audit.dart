import '../../action_item_information.dart';
import '/common_libraries.dart';

class AuditViewForActionItem extends StatelessWidget {
  const AuditViewForActionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
          label: 'Audit Date',
          content: '14th May 2023',
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
            'Are there any visible cracks or fractures in the staircase?',
            style: textNormal14,
          ),
        )
      ],
    );
  }
}
