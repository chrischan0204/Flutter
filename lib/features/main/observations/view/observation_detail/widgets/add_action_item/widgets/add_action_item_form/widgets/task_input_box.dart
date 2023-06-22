import '/common_libraries.dart';
import '../../../../form_item.dart';

class TaskInputBox extends StatelessWidget {
  const TaskInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Task',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return CustomTextField(
            key: ValueKey(state.actionItem?.id),
            initialValue: state.task,
            hintText: 'Task Description',
            onChanged: (task) {
              context
                  .read<AddActionItemBloc>()
                  .add(AddActionItemTaskChanged(task: task));
            },
          );
        },
      ),
    );
  }
}