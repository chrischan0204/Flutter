import '../../../../form_item.dart';
import '/common_libraries.dart';

class ProjectSelectField extends StatelessWidget {
  const ProjectSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Project',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          Map<String, Project> items = {}..addEntries(state.projectList
              .map((project) => MapEntry(project.name ?? '', project)));
          return CustomSingleSelect(
            items: items,
            hint: 'Select Project',
            selectedValue:
                state.projectList.isEmpty ? null : state.project?.name,
            onChanged: (project) {
              context
                  .read<AddActionItemBloc>()
                  .add(AddActionItemProjectChanged(project: project.value));
            },
          );
        },
      ),
    );
  }
}
