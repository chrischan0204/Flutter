import '/common_libraries.dart';

class CompaniesTextField extends StatefulWidget {
  const CompaniesTextField({super.key});

  @override
  State<CompaniesTextField> createState() => _CompaniesTextFieldState();
}

class _CompaniesTextFieldState extends State<CompaniesTextField> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    final audit = context.read<AddEditAuditBloc>().state.loadedAudit;
    if (audit != null) {
      _textController.text = audit.companies;
    }
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditAuditBloc, AddEditAuditState>(
      listener: (context, state) {
        _textController.text = state.loadedAudit!.companies;
      },
      listenWhen: (previous, current) =>
          previous.loadedAudit != current.loadedAudit,
      builder: (context, state) {
        return CustomTextField(
          controller: _textController,
          hintText:
              'Type in the companies involved with this audit. Comma separated',
          minLines: 3,
          height: null,
          maxLines: 3,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          onChanged: (_) {
            String text = _textController.text;
            if (text.contains('\n')) {
              int offset = _textController.selection.base.offset;

              int count = text.split('\n').length;

              _textController.text = text.replaceAll('\n', '');

              _textController.selection =
                  TextSelection.collapsed(offset: offset - count + 1);
            }
            context.read<AddEditAuditBloc>().add(
                  AddEditAuditCompaniesChanged(companies: _textController.text),
                );
          },
        );
      },
    );
  }
}
