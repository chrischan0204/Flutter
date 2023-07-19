import '/common_libraries.dart';

class AssigneeSelectField extends StatelessWidget {
  const AssigneeSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        Map<String, Entity> items = {}..addEntries(
            state.userList.map((user) => MapEntry(user.name!, user)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Assignee',
          selectedValue: state.userList.isEmpty ? null : state.assignee?.name,
          onChanged: (assignee) {
            context
                .read<AddEditActionItemBloc>()
                .add(AddEditActionItemAssigneeChanged(
                    assignee: User(
                  id: (assignee.value as Entity).id,
                  firstName: (assignee.value as Entity).name!.split(' ').first,
                  lastName: (assignee.value as Entity).name!.split(' ').last,
                )));
          },
        );
      },
    );
  }
}
