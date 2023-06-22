import '/common_libraries.dart';

class NotesDetailView extends StatelessWidget {
  const NotesDetailView({super.key});

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
              child: Text(
                state.actionItem!.notes,
                style: textNormal14,
              ),
            ),
          ],
        );
      },
    );
  }
}
