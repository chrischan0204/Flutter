import '/common_libraries.dart';

class NotesTextField extends StatelessWidget {
  const NotesTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActionItemBloc, AddActionItemState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomBottomBorderContainer(
              padding: inset10,
              child: Text(
                'Notes:',
                style: textSemiBold14,
              ),
            ),
            CustomBottomBorderContainer(
              padding: inset10,
              child: CustomTextField(
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
                onChanged: (notes) => context.read<AddActionItemBloc>().add(
                      AddActionItemNotesChanged(notes: notes),
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
