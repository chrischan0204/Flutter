import '/common_libraries.dart';

class AddActionItemHeaderView extends StatelessWidget {
  const AddActionItemHeaderView({super.key});

  String _getHeaderTitle(AddActionItemState state) {
    if (state.isEditing) {
      if (state.actionItem == null) {
        return 'Add Action Item';
      } else {
        return 'Update Action Item';
      }
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
      return Tooltip(
        message: '${state.actionItem == null ? 'Add' : 'Update'} Action Item',
        child: ElevatedButton(
          onPressed: () =>
              context.read<AddActionItemBloc>().add(AddActionItemSaved()),
          style: ElevatedButton.styleFrom(backgroundColor: successColor),
          child: Text(
            state.actionItem == null ? 'Add' : 'Update',
            style: textNormal12.copyWith(color: Colors.white),
          ),
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
              Expanded(
                child: Text(
                  _getHeaderTitle(state),
                  style: textSemiBold14,
                  softWrap: true,
                  textAlign: MediaQuery.of(context).size.width > minDesktopWidth
                      ? TextAlign.left
                      : TextAlign.center,
                ),
              ),
              spacerx10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (state.isEditing)
                    ElevatedButton(
                      onPressed: () => context.read<AddActionItemBloc>().add(
                          const AddActionItemIsEditingChanged(
                              isEditing: false)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      child: Text(
                        'Cancel',
                        style: textNormal12.copyWith(color: Colors.white),
                      ),
                    ),
                  if (state.isEditing) spacerx10,
                  _getButton(state, context),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
