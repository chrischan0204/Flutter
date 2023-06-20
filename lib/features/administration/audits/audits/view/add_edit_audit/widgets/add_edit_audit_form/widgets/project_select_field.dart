import '/common_libraries.dart';

class ProjectSelectField extends StatelessWidget {
  const ProjectSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        Map<String, Entity> items = {};
        for (final item in state.projectList) {
          items.addEntries(
              [MapEntry(item.name!, Entity(id: item.id, name: item.name))]);
        }
        return FormItem(
          label: 'Project',
          content: CustomMultiSelect(
            items: items,
            selectedItems: state.selectedProjectList
                .map((e) => Entity(id: e.id, name: e.name))
                .toList(),
            hint: 'Select Projects',
            onChanged: (projectList) => context
                .read<AddEditAuditBloc>()
                .add(AddEditAuditSelectedProjectListChanged(
                    projectList: projectList
                        .map((e) => Project(
                              id: e.id,
                              name: e.name,
                            ))
                        .toList())),
          ),
        );
        // Map<String, Entity> items = {}
        //   ..addEntries(state.projectList.map((project) => MapEntry(
        //       project.name ?? '', Entity(id: project.id, name: project.name))));
        // return FormItem(
        //   label: 'Project',
        //   content: CustomMultiSelect(
        //     items: items,
        //     hint: 'Select Projects',
        //     selectedItems: state.selectedProjectList,
        //     onChanged: (projectList) {
        //       context
        //           .read<AddEditAuditBloc>()
        //           .add(AddEditAuditSelectedProjectListChanged(
        //               projectList: projectList
        //                   .map((e) => Project(
        //                         id: e.id,
        //                         name: e.name,
        //                       ))
        //                   .toList()));
        //     },
        //   ),
        //   message: '',
        // );
      },
    );
  }
}
