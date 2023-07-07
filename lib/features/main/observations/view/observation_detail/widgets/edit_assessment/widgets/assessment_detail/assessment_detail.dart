import '/common_libraries.dart';
import 'widgets/assessment_item.dart';

class AssessmentDetailView extends StatelessWidget {
  const AssessmentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
      builder: (context, state) {
        if (state.observation == null) {
          return Container();
        }
        final observation = state.observation!;
        return Column(
          children: [
            AssessmentDetailItemView(
              label: 'Category',
              content: observation.assessmentAwarenessCategoryName ?? '',
            ),
            AssessmentDetailItemView(
              label: 'Observation Type',
              content: observation.assessmentObservationTypeName ?? '',
            ),
            AssessmentDetailItemView(
              label: 'Priority Level',
              content: observation.assessmentPriorityLevelName ?? '',
            ),
            AssessmentDetailItemView(
              label: 'Company',
              content: observation.assessmentCompanyName ?? '',
            ),
            AssessmentDetailItemView(
              label: 'Project',
              content: observation.assessmentCompanyName ?? '',
            ),
            AssessmentDetailItemView(
              label: 'Site',
              content: observation.userReportedSiteName ?? '',
            ),
            AssessmentDetailItemView(
              label: 'Follow up closeout',
              content: observation.assessmentFollowupComment ?? '',
              twoLines: true,
            ),
            if (observation.isClosed == true)
            AssessmentDetailItemView(
              label: 'Status',
              content: 'Marked as closed on ${observation.formatedClosedOn}',
            ),
            AssessmentDetailItemView(
              label: 'Closed By',
              content: observation.closedByUserName ?? '',
            ),
            AssessmentDetailItemView(
              label: 'User Notified?',
              content: observation.notificationSentTo ?? '',
            ),
            if (observation.assessedOn != null)
              AssessmentDetailItemView(
                label: 'Assessment Status',
                content: 'Assessed On ${observation.formatedAssessedOn}',
              ),
            AssessmentDetailItemView(
              label: 'Assessed By',
              content: observation.assessedByName ?? '',
            ),
          ],
        );
      },
    );
  }
}
