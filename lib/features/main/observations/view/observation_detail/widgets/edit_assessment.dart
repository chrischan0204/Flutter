import '/common_libraries.dart';
import 'assessment_item.dart';

class EditAssessmentView extends StatelessWidget {
  const EditAssessmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBottomBorderContainer(
            padding: inset20,
            color: lightBlueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assessment Reading',
                  style: textNormal14,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: Text(
                    'Edit Assessment',
                    style: textNormal12.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
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
      ),
    );
  }
}
