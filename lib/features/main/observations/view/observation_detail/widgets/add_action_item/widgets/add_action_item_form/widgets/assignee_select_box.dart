import '../../../../form_item.dart';
import '/common_libraries.dart';

class AssigneeSelectField extends StatelessWidget {
  const AssigneeSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Assignee (*)',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, User> items = {}..addEntries(observationDetailState
              .userList
              .map((user) => MapEntry(user.name!, user)));
          return BlocBuilder<AddActionItemBloc, AddActionItemState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSingleSelect(
                    items: items,
                    hint: 'Select Assignee',
                    selectedValue: observationDetailState.userList.isEmpty
                        ? null
                        : state.assignee?.name,
                    onChanged: (assignee) {
                      context.read<AddActionItemBloc>().add(
                          AddActionItemAssigneeChanged(
                              assignee: assignee.value));
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
          );
        },
      ),
    );
  }
}
