import '/common_libraries.dart';

class InspectorsTextField extends StatefulWidget {
  const InspectorsTextField({super.key});

  @override
  State<InspectorsTextField> createState() => _InspectorsTextFieldState();
}

class _InspectorsTextFieldState extends State<InspectorsTextField> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    final audit = context.read<AddEditAuditBloc>().state.loadedAudit;
    if (audit != null) {
      _textController.text = audit.inspectors;
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
        _textController.text = state.loadedAudit!.inspectors;
      },
      listenWhen: (previous, current) =>
          previous.loadedAudit != current.loadedAudit,
      builder: (context, state) {
        return CustomTextField(
          controller: _textController,
          hintText:
              'Type in the additional inspectors involved with this audit. Comma separated',
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
              _textController.text = text.replaceAll('\n', '');
              _textController.selection =
                  TextSelection.collapsed(offset: offset - 1);
            }
            context.read<AddEditAuditBloc>().add(
                  AddEditAuditInspectorsChanged(
                      inspectors: _textController.text),
                );
          },
        );
      },
    );
  }
}
