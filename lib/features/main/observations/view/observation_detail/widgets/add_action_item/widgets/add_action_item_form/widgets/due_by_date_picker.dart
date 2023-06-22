import 'package:date_time_picker/date_time_picker.dart';

import '../../../../form_item.dart';
import '/common_libraries.dart';

class DueByDatePicker extends StatelessWidget {
  const DueByDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Due By',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return CustomDateTimePicker(
            key: ValueKey(state.actionItem?.id),
            initialValue: state.dueBy.toString(),
            dateTimePickerType: DateTimePickerType.date,
            onChange: (dueBy) {
              context
                  .read<AddActionItemBloc>()
                  .add(AddActionItemDueByChanged(dueBy: dueBy));
            },
          );
        },
      ),
    );
  }
}
