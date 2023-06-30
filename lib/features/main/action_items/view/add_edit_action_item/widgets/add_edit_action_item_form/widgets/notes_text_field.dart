import '/common_libraries.dart';

class NotesTextField extends StatelessWidget {
  const NotesTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.actionItem?.id),
          initialValue: state.notes,
          hintText: 'Notes about task',
          minLines: 3,
          height: null,
          maxLines: 100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          onChanged: (notes) => context.read<AddEditActionItemBloc>().add(
                AddEditActionItemNotesChanged(notes: notes),
              ),
        );
      },
    );
  }
}
