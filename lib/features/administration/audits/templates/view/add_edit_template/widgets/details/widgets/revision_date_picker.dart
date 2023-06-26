import 'package:date_time_picker/date_time_picker.dart';

import '/common_libraries.dart';

class RevisionDatePicker extends StatelessWidget {
  const RevisionDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditTemplateBloc, AddEditTemplateState>(
      builder: (context, state) {
        return FormItem(
          label: 'Date (*)',
          content: CustomDateTimePicker(
            key: ValueKey(state.loadedTemplate?.id),
            initialValue: state.date?.toString(),
            dateTimePickerType: DateTimePickerType.date,
            onChange: (date) {
              context
                  .read<AddEditTemplateBloc>()
                  .add(AddEditTemplateDateChanged(date: date));
            },
          ),
          message: state.dateValidationMesage,
        );
      },
    );
  }
}
