import 'package:date_time_picker/date_time_picker.dart';

import '/common_libraries.dart';

class AuditDatePicker extends StatelessWidget {
  const AuditDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        return CustomDateTimePicker(
          key: ValueKey(state.loadedAudit?.id),
          initialValue: state.auditDate.toString(),
          dateTimePickerType: DateTimePickerType.dateTime,
          onChange: (date) {
            context
                .read<AddEditAuditBloc>()
                .add(AddEditAuditDateChanged(date: date));
          },
        );
      },
    );
  }
}
