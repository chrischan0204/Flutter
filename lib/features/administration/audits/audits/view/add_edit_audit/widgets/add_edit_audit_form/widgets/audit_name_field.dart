import '/common_libraries.dart';

class AuditNameTextField extends StatelessWidget {
  const AuditNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.loadedAudit?.id),
          initialValue: state.auditName,
          hintText: 'Audit name',
          onChanged: (auditName) {
            context
                .read<AddEditAuditBloc>()
                .add(AddEditAuditNameChanged(auditName: auditName));
          },
        );
      },
    );
  }
}
