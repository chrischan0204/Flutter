import '/common_libraries.dart';

class AddActionItemHeaderView extends StatelessWidget {
  const AddActionItemHeaderView({super.key});

  String _getHeaderTitle(AddActionItemState state) {
    if (state.isEditing) {
      return 'Add Action Item';
    } else {
      if (state.actionItem == null) {
        return 'Action Items';
      } else {
        return 'Action Item Details';
      }
    }
  }

  Widget _getButton(AddActionItemState state, BuildContext context) {
    if (state.isEditing) {
      return ElevatedButton(
        onPressed: () =>
            context.read<AddActionItemBloc>().add(AddActionItemSaved()),
        style: ElevatedButton.styleFrom(backgroundColor: successColor),
        child: Text(
          'Submit',
          style: textNormal12.copyWith(color: Colors.white),
        ),
      );
    } else {
      if (state.actionItem == null) {
        return ElevatedButton(
          onPressed: () => context
              .read<AddActionItemBloc>()
              .add(AddActionItemAddActionItemButtonClicked()),
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          child: Text(
            'Add Action Item',
            style: textNormal12.copyWith(color: Colors.white),
          ),
        );
      } else {
        return ElevatedButton(
          onPressed: () => context
              .read<AddActionItemBloc>()
              .add(AddActionItemActionItemListButtonClicked()),
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          child: Text(
            'Action Item List',
            style: textNormal12.copyWith(color: Colors.white),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset20,
      backgroundColor: lightBlueAccent,
      child: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getHeaderTitle(state),
                style: textSemiBold14,
              ),
              _getButton(state, context),
            ],
          );
        },
      ),
    );
  }
}
