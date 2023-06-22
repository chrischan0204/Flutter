import '../../../../form_item.dart';
import '/common_libraries.dart';

class AssigneeSelectField extends StatelessWidget {
  const AssigneeSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Assignee',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, User> items = {}..addEntries(observationDetailState
              .userList
              .map((user) => MapEntry(user.fullName, user)));
          return BlocBuilder<AddActionItemBloc, AddActionItemState>(
            builder: (context, addActionItemState) {
              return CustomSingleSelect(
                items: items,
                hint: 'Select Assignee',
                selectedValue: observationDetailState.userList.isEmpty
                    ? null
                    : addActionItemState.assignee?.name,
                onChanged: (assignee) {
                  context.read<AddActionItemBloc>().add(
                      AddActionItemAssigneeChanged(assignee: assignee.value));
                },
              );
            },
          );
        },
      ),
    );
  }
}
