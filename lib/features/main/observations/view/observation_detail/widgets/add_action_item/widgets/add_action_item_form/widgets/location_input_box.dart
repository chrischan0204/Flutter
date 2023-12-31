import '/common_libraries.dart';
import '../../../../form_item.dart';

class LocationInputBox extends StatelessWidget {
  const LocationInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Area',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return CustomTextField(
            key: ValueKey(state.actionItem?.id),
            initialValue: state.location,
            hintText: 'Area Information',
            onChanged: (location) {
              context
                  .read<AddActionItemBloc>()
                  .add(AddActionItemLocationChanged(location: location));
            },
          );
        },
      ),
    );
  }
}
