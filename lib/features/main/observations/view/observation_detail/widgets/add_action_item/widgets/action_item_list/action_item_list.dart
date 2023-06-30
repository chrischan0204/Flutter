import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ActionItemListViewForObservation extends StatelessWidget {
  const ActionItemListViewForObservation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActionItemBloc, AddActionItemState>(
      builder: (context, state) {
        return Column(
          children: [
            for (final actionItem in state.actionItemList)
              ActionItemView(actionItem: actionItem)
          ],
        );
      },
    );
  }
}
