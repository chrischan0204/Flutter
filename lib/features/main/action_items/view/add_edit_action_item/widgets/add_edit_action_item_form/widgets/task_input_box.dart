import '/common_libraries.dart';

class ActionItemNameInputBox extends StatelessWidget {
  const ActionItemNameInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.actionItem?.id),
          initialValue: state.name,
          hintText: 'Action Item Description',
          onChanged: (name) { 
            context
                .read<AddEditActionItemBloc>()
                .add(AddEditActionItemNameChanged(name: name));
          },
        );
      },
    );
  }
}
