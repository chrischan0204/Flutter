import '/common_libraries.dart';

class CompaniesTextField extends StatelessWidget {
  const CompaniesTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditAuditBloc, AddEditAuditState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.loadedAudit?.id),
          initialValue: state.companies,
          hintText:
              'Type in the companies involved with this audit. Comma separated',
          minLines: 3,
          height: null,
          maxLines: 100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          onChanged: (companies) => context.read<AddEditAuditBloc>().add(
                AddEditAuditCompaniesChanged(companies: companies),
              ),
        );
      },
    );
  }
}
