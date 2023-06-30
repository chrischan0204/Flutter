import '/common_libraries.dart';
import '../../../../form_item.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Task',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Text(
            state.actionItem!.name ?? '',
            style: textNormal14,
          );
        },
      ),
    );
  }
}
