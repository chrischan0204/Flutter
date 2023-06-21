import '/common_libraries.dart';

class ProjectSelectField extends StatelessWidget {
  const ProjectSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
    //   builder: (context, state) {
    //     Map<String, Entity> items = {};
    //     for (final item in state.projectList) {
    //       items.addEntries(
    //           [MapEntry(item.name!, Entity(id: item.id, name: item.name))]);
    //     }
    //     return FormItem(
    //       label: 'Project',
    //       content: CustomMultiSelect(
    //         items: items,
    //         selectedItems: state.selectedProjectList
    //             .map((e) => Entity(id: e.id, name: e.name))
    //             .toList(),
    //         hint: 'Select Projects',
    //         onChanged: (projectList) => context
    //             .read<AddEditAuditBloc>()
    //             .add(AddEditAuditProjectChanged(
    //                 projectList: projectList
    //                     .map((e) => Project(
    //                           id: e.id,
    //                           name: e.name,
    //                         ))
    //                     .toList())),
    //       ),
    //     );
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        Map<String, Project> items = {}..addEntries(state.projectList
            .map((project) => MapEntry(project.name ?? '', project)));
        return FormItem(
          label: 'Project (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Project',
            selectedValue:
                state.projectList.isEmpty ? null : state.project?.name,
            onChanged: (project) {
              context
                  .read<AddEditAuditBloc>()
                  .add(AddEditAuditProjectChanged(project: project.value));
            },
          ),
          message: '',
        );
      },
    );
  }
}
