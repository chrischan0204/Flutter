import '/common_libraries.dart';

class TemplateSelectField extends StatelessWidget {
  const TemplateSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        Map<String, Template> items = {}..addEntries(state.templateList
            .map((template) => MapEntry(template.name ?? '', template)));
        return FormItem(
          label: 'Template (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Template',
            selectedValue:
                state.templateList.isEmpty ? null : state.template?.name,
            onChanged: (template) {
              context
                  .read<AddEditAuditBloc>()
                  .add(AddEditAuditTemplateChanged(template: template.value));
            },
          ),
          message: state.templateValidationMessage,
        );
      },
    );
  }
}
