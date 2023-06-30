import '/common_libraries.dart';

class ActionItemInformationView extends StatelessWidget {
  const ActionItemInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<ActionItemDetailBloc, ActionItemDetailState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomBottomBorderContainer(
                padding: inset20,
                child: Text(
                  'Action Item Information',
                  style: textSemiBold16,
                ),
              ),
              ActionItemInformationItemView(
                label: 'Task',
                content: state.actionItem?.name ?? '',
              ),
              ActionItemInformationItemView(
                label: 'Due',
                content: state.actionItem?.formatedDue ?? '',
              ),
              ActionItemInformationItemView(
                label: 'Assignee',
                content: state.actionItem?.assigneeName ?? '',
              ),
              ActionItemInformationItemView(
                label: 'Category',
                content: state.actionItem?.awarenessCategoryName ?? '',
              ),
              ActionItemInformationItemView(
                label: 'Company',
                content: state.actionItem?.companyName ?? '',
              ),
              ActionItemInformationItemView(
                label: 'Project',
                content: state.actionItem?.projectName ?? '',
              ),
              ActionItemInformationItemView(
                label: 'Location',
                content: state.actionItem?.area ?? '',
              ),
              CustomBottomBorderContainer(
                padding: inset12,
                child: Text(
                  'Notes',
                  style: textNormal14,
                ),
              ),
              CustomBottomBorderContainer(
                padding: inset12,
                child: Text(
                  state.actionItem?.notes ?? '',
                  style: textNormal14,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class ActionItemInformationItemView extends StatelessWidget {
  final String label;
  final String content;
  const ActionItemInformationItemView({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset12,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: textSemiBold14,
            ),
          ),
          spacerx10,
          Expanded(
            flex: 2,
            child: Text(
              content,
              style: textNormal14,
            ),
          ),
        ],
      ),
    );
  }
}
