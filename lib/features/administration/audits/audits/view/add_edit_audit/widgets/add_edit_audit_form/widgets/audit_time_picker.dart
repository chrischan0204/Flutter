import '/common_libraries.dart';

class AuditTimePicker extends StatelessWidget {
  const AuditTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        return FormItem(
          label: 'Audit Time (*)',
          content: CustomTimePicker(
            key: ValueKey(state.loadedAudit?.id),
            initialValue: state.auditTime,
            onChange: (time) {
              context
                  .read<AddEditAuditBloc>()
                  .add(AddEditAuditTimeChanged(time: time));
            },
          ),
          message: state.auditTimeValidationMessage,
        );
      },
    );
  }
}
