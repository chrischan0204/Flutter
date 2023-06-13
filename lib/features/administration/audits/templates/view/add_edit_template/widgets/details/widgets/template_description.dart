import '/common_libraries.dart';

class TemplateDescriptionField extends StatefulWidget {
  const TemplateDescriptionField({super.key});

  @override
  State<TemplateDescriptionField> createState() =>
      _TemplateDescriptionFieldState();
}

class _TemplateDescriptionFieldState extends State<TemplateDescriptionField> {
  late TextEditingController descriptionController;
  late AddEditTemplateBloc addEditTemplateBloc;

  @override
  void initState() {
    addEditTemplateBloc = context.read();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
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
        content: BlocConsumer<TemplateDetailBloc, TemplateDetailState>(
          listener: (context, state) {
            context
                .read<FormDirtyBloc>()
                .add(const FormDirtyChanged(isDirty: true));
          },
          listenWhen: (previous, current) =>
              previous.template != current.template,
          builder: (context, state) {
            return CustomTextField(
              key: ValueKey(state.template?.name),
              initialValue: state.template?.name,
              hintText: 'Template description',
              onChanged: (description) {
                addEditTemplateBloc.add(AddEditTemplateDescriptionChanged(
                    description: description));
                if (!Validation.isEmpty(description)) {
                  context
                      .read<FormDirtyBloc>()
                      .add(const FormDirtyChanged(isDirty: true));
                } else {
                  context
                        .read<FormDirtyBloc>()
                        .add(const FormDirtyChanged(isDirty: false));
                }
              },
            );
          },
        ),
        message: state.templateDescriptionValidationMessage,
      ),
    );
  }
}
