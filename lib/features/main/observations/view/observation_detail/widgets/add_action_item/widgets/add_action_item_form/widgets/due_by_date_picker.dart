import '../../../../form_item.dart';
import '/common_libraries.dart';

class DueByDatePicker extends StatelessWidget {
  const DueByDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Due By (*)',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Column(
            children: [
              CustomDateTimePicker(
                key: ValueKey(state.actionItem?.id),
                initialValue: state.dueBy.toString(),
                dateTimePickerType: DateTimePickerType.date,
                onChange: (dueBy) {
                  context
                      .read<AddActionItemBloc>()
                      .add(AddActionItemDueByChanged(dueBy: dueBy));
                },
                firstDate: state.initialDueBy ?? DateTime.now(),
              ),
              if (state.dueByValidationMessage.isNotEmpty)
                Padding(
                  padding: inset4,
                  child: Text(
                    state.dueByValidationMessage,
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
