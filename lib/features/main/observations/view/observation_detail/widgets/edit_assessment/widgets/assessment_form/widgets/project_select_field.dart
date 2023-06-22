import '/common_libraries.dart';
import 'form_item.dart';

class ProjectSelectField extends StatelessWidget {
  const ProjectSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return AssessmentFormItemView(
      label: 'Project',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, Project> items = {}..addEntries(observationDetailState
              .projectList
              .map((project) => MapEntry(project.name ?? '', project)));
          return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
            builder: (context, editAssessmentState) {
              return CustomSingleSelect(
                items: items,
                hint: 'Select Project',
                selectedValue: observationDetailState.projectList.isEmpty
                    ? null
                    : editAssessmentState.project?.name,
                onChanged: (project) {
                  context.read<EditAssessmentBloc>().add(
                      EditAssessmentProjectChanged(project: project.value));
                },
              );
            },
          );
        },
      ),
    );
  }
}
