import '/common_libraries.dart';

class RevisionDatePicker extends StatefulWidget {
  const RevisionDatePicker({super.key});

  @override
  State<RevisionDatePicker> createState() => _RevisionDatePickerState();
}

class _RevisionDatePickerState extends State<RevisionDatePicker> {
  TextEditingController textController = TextEditingController();

  late AddEditTemplateBloc addEditTemplateBloc;

  @override
  void initState() {
    addEditTemplateBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditTemplateBloc, AddEditTemplateState>(
      listener: (context, state) {
        textController.text = state.date!.toString();
      },
      listenWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        return FormItem(
          label: 'Date (*)',
          content: CustomDateTimePicker(
            controller: textController,
            onChange: (date) =>
                addEditTemplateBloc.add(AddEditTemplateDateChanged(date: date)),
          ),
          message: state.dateValidationMesage,
        );
      },
    );
  }
}
