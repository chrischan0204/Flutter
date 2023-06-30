import '/common_libraries.dart';

class ProjectSelectField extends StatelessWidget {
  const ProjectSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        Map<String, Project> items = {}..addEntries(state.projectList
            .map((project) => MapEntry(project.name ?? '', project)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Project',
          selectedValue: state.projectList.isEmpty ? null : state.project?.name,
          onChanged: (project) {
            context
                .read<AddEditActionItemBloc>()
                .add(AddEditActionItemProjectChanged(project: project.value));
          },
        );
      },
    );
  }
}
