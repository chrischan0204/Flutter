import '../../../../form_item.dart';
import '/common_libraries.dart';

class ProjectSelectField extends StatelessWidget {
  const ProjectSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Project',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, Project> items = {}..addEntries(observationDetailState
              .projectList
              .map((project) => MapEntry(project.name ?? '', project)));
          return BlocBuilder<AddActionItemBloc, AddActionItemState>(
            builder: (context, addActionItemState) {
              return CustomSingleSelect(
                items: items,
                hint: 'Select Project',
                selectedValue: observationDetailState.projectList.isEmpty
                    ? null
                    : addActionItemState.project?.name,
                onChanged: (project) {
                  context.read<AddActionItemBloc>().add(
                      AddActionItemProjectChanged(project: project.value));
                },
              );
            },
          );
        },
      ),
    );
  }
}
