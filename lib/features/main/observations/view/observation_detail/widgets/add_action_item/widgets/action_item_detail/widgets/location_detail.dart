import '/common_libraries.dart';
import '../../../../form_item.dart';

class LocationDetailView extends StatelessWidget {
  const LocationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Area',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Text(
            state.actionItem!.area,
            style: textNormal14,
          );
        },
      ),
    );
  }
}
