import '/common_libraries.dart';
import 'widgets/assessment_item.dart';

class AssessmentDetailView extends StatelessWidget {
  const AssessmentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AssessmentDetailItemView(
          label: 'Category',
          content: 'Fall Protection',
        ),
        AssessmentDetailItemView(
          label: 'Observation Type',
          content: 'Near Miss',
        ),
        AssessmentDetailItemView(
          label: 'Priority Level',
          content: 'High',
        ),
        AssessmentDetailItemView(
          label: 'Company',
          content: '--',
        ),
        AssessmentDetailItemView(
          label: 'Project',
          content: '--',
        ),
        AssessmentDetailItemView(
          label: 'Site',
          content: 'Lakeshore Drive, Chicago',
        ),
        AssessmentDetailItemView(
          label: 'Follow up closeout',
          content:
              'A monitoring team was sent to the location and they reported back that the incident had been contained by the cleaning crew. The stairs pose no further threat.',
          twoLines: true,
        ),
        AssessmentDetailItemView(
          label: 'Status',
          content: 'Marked as closed on 15th May 2023 at 12 PM',
        ),
        AssessmentDetailItemView(
          label: 'User Notified?',
          content: 'No',
        ),
        AssessmentDetailItemView(
          label: 'Assigned to',
          content: 'John Carter',
        ),
        AssessmentDetailItemView(
          label: 'Assigned by',
          content: 'Auto Notification',
        ),
        AssessmentDetailItemView(
          label: 'Assessment Status',
          content: 'Assessed on 21st May 2023 at 3:20 PM',
        ),
        AssessmentDetailItemView(
          label: 'Assessed By',
          content: 'Cush Derrick',
        ),
      ],
    );
  }
}
