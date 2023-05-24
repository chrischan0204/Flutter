import '/common_libraries.dart';

class FirstNameField extends StatefulWidget {
  const FirstNameField({super.key});

  @override
  State<FirstNameField> createState() => _FirstNameFieldState();
}

class _FirstNameFieldState extends State<FirstNameField> {
  TextEditingController descriptionController = TextEditingController();
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
        CustomNotification(
          context: context,
          notifyType: NotifyType.error,
          content: state.message,
        ).showNotification();
      },
      listenWhen: (previous, current) =>
          previous.templateAddEditStatus != current.templateAddEditStatus &&
          current.templateAddEditStatus.isFailure &&
          previous.message != current.message,
      builder: (context, state) => FormItem(
        label: 'Template Description (*)',
        content: BlocListener<AddEditTemplateBloc, AddEditTemplateState>(
          listener: (context, state) {
            descriptionController.text = state.templateDescription;
            descriptionController.selection = TextSelection.collapsed(
                offset: state.templateDescription.length);
          },
          listenWhen: (previous, current) =>
              previous.templateDescription != current.templateDescription,
          child: CustomTextField(
            controller: descriptionController,
            hintText: 'Template description',
            onChanged: (firstName) => addEditTemplateBloc
                .add(AddEditTemplateDescriptionChanged(description: firstName)),
          ),
        ),
        message: state.templateDescriptionValidationMessage,
      ),
    );
  }
}
