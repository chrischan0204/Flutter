import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ActionItemListView extends StatelessWidget {
  const ActionItemListView({super.key});

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
