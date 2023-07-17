import '/common_libraries.dart';

class DueByDatePicker extends StatelessWidget {
  const DueByDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        return CustomDateTimePicker(
          key: ValueKey(state.actionItem?.id),
          initialValue: state.dueBy?.toString(),
          dateTimePickerType: DateTimePickerType.date,
          onChange: (dueBy) {
            context
                .read<AddEditActionItemBloc>()
                .add(AddEditActionItemDueByChanged(dueBy: dueBy));
          },
        );
      },
    );
  }
}
