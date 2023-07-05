import '/common_libraries.dart';

class LocationInputBox extends StatelessWidget {
  const LocationInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.actionItem?.id),
          initialValue: state.location,
          hintText: 'Area Information',
          onChanged: (location) {
            context
                .read<AddEditActionItemBloc>()
                .add(AddEditActionItemLocationChanged(location: location));
          },
        );
      },
    );
  }
}
