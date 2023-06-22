import '/common_libraries.dart';
import '../../../../form_item.dart';

class AssigneeDetailView extends StatelessWidget {
  const AssigneeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Assignee',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Text(
            state.actionItem!.assignee,
            style: textNormal14,
          );
        },
      ),
    );
  }
}
