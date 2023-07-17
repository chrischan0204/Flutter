import '/common_libraries.dart';
import '../../../../form_item.dart';

class TaskInputBox extends StatelessWidget {
  const TaskInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Action Required (*)',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                key: ValueKey(state.actionItem?.id),
                initialValue: state.task,
                hintText: 'Action Required Description',
                onChanged: (task) {
                  context
                      .read<AddActionItemBloc>()
                      .add(AddActionItemTaskChanged(task: task));
                },
              ),
              if (state.actionItemValidationMessage.isNotEmpty)
                Padding(
                  padding: inset4,
                  child: Text(
                    state.actionItemValidationMessage,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
