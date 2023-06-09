import 'package:date_time_picker/date_time_picker.dart';

import '/common_libraries.dart';

class RevisionDatePicker extends StatefulWidget {
  const RevisionDatePicker({super.key});

  @override
  State<RevisionDatePicker> createState() => _RevisionDatePickerState();
}

class _RevisionDatePickerState extends State<RevisionDatePicker> {
  late TextEditingController textController;

  late AddEditTemplateBloc addEditTemplateBloc;

  @override
  void initState() {
    addEditTemplateBloc = context.read();
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditTemplateBloc, AddEditTemplateState>(
      builder: (context, state) {
        return FormItem(
          label: 'Date (*)',
          content: BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
            builder: (context, state) {
              return CustomDateTimePicker(
                key: ValueKey(state.template?.revisionDate.toString()),
                initialValue: state.template?.revisionDate.toString(),
                dateTimePickerType: DateTimePickerType.date,
                onChange: (date) => addEditTemplateBloc
                    .add(AddEditTemplateDateChanged(date: date)),
              );
            },
          ),
          message: state.dateValidationMesage,
        );
      },
    );
  }
}
