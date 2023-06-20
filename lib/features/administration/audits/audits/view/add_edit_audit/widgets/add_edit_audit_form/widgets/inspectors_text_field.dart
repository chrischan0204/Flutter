import '/common_libraries.dart';

class InspectorsTextField extends StatelessWidget {
  const InspectorsTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        return FormItem(
          label: 'Inspectors',
          content: CustomTextField(
            key: ValueKey(state.loadedAudit?.id),
            initialValue: state.inspectors,
            hintText:
                'Type in the additional inspectors involved with this audit. Comma separated',
            minLines: 3,
            height: null,
            maxLines: 100,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            onChanged: (inspectors) => context.read<AddEditAuditBloc>().add(
                  AddEditAuditInspectorsChanged(inspectors: inspectors),
                ),
          ),
        );
      },
    );
  }
}
