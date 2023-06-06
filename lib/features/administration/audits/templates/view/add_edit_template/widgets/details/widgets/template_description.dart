import '/common_libraries.dart';

class TemplateDescriptionField extends StatefulWidget {
  const TemplateDescriptionField({super.key});

  @override
  State<TemplateDescriptionField> createState() => _TemplateDescriptionFieldState();
}

class _TemplateDescriptionFieldState extends State<TemplateDescriptionField> {
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
        content: BlocListener<TemplateDetailBloc, TemplateDetailState>(
          listener: (context, state) {
            descriptionController.text = state.template!.name ?? '';
          },
          listenWhen: (previous, current) =>
              previous.template != current.template &&
              previous.template == null,
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
