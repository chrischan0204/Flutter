import '/common_libraries.dart';

class TemplateDescriptionField extends StatelessWidget {
  const TemplateDescriptionField({super.key});

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
          previous.status != current.status &&
          current.status.isFailure &&
          previous.message != current.message &&
          current.message.isNotEmpty,
      builder: (context, state) => FormItem(
        label: 'Template Description (*)',
        content: CustomTextField(
          key: ValueKey(state.loadedTemplate?.id),
          initialValue: state.templateDescription,
          hintText: 'Template description',
          onChanged: (description) {
            context.read<AddEditTemplateBloc>().add(
                AddEditTemplateDescriptionChanged(description: description));
          },
        ),
        message: state.templateDescriptionValidationMessage,
      ),
    );
  }
}
