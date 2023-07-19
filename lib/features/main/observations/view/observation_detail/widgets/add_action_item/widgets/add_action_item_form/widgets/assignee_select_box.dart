import '../../../../form_item.dart';
import '/common_libraries.dart';

class AssigneeSelectField extends StatelessWidget {
  const AssigneeSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Assignee (*)',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          Map<String, Entity> items = {}..addEntries(
              state.userList.map((user) => MapEntry(user.name!, user)));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSingleSelect(
                items: items,
                hint: 'Select Assignee',
                selectedValue:
                    state.userList.isEmpty ? null : state.assignee?.name,
                onChanged: (assignee) {
                  context
                      .read<AddActionItemBloc>()
                      .add(AddActionItemAssigneeChanged(
                          assignee: User(
                        id: (assignee.value as Entity).id,
                        firstName:
                            (assignee.value as Entity).name!.split(' ').first,
                        lastName:
                            (assignee.value as Entity).name!.split(' ').last,
                      )));
                },
              ),
              if (state.assigneeValidationMessage.isNotEmpty)
                Padding(
                  padding: inset4,
                  child: Text(
                    state.assigneeValidationMessage,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
