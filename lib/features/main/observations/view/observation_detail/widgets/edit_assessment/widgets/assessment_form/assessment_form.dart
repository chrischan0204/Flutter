import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AssessmentFormView extends StatelessWidget {
  const AssessmentFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CategorySelectField(),
        const ObservationTypeSelectField(),
        const PriorityLevelSelectField(),
        const SiteSelectField(),
        const EditAssessmentTitleView(title: 'Written against'),
        const CompanySelectField(),
        const ProjectSelectField(),
        const EditAssessmentTitleView(title: 'Other Data Points'),
        const ObserverTextField(),
        const ReportedViaTextField(),
        const FollowUpCloseoutTextField(),
        Padding(
          padding: inset10,
          child: const Row(
            children: [
              Expanded(
                child: NotifySenderCheckBox(),
              ),
              Expanded(
                child: MarkAsClosedCheckBox(),
              ),
              Spacer(),
            ],
          ),
        )
      ],
    );
  }
}
