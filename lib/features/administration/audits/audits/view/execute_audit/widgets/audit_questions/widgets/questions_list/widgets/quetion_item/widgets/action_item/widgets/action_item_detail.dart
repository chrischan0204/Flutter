import '/common_libraries.dart';

class AuditActionItemDetailView extends StatelessWidget {
  const AuditActionItemDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        if (state.auditActionItemLoadStatus.isLoading) {
          return const Center(child: Loader());
        }

        if (state.auditActionItem != null) {
          final actionItem = state.auditActionItem!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActionItemDetailItemView(
                label: 'Action required',
                content: actionItem.description ?? '--',
              ),
              ActionItemDetailItemView(
                label: 'Due',
                content: actionItem.formatedDueBy,
              ),
              ActionItemDetailItemView(
                label: 'Assignee',
                content: actionItem.assigneeName ?? '--',
              ),
              ActionItemDetailItemView(
                label: 'Category',
                content: actionItem.awarenessCategoryName ?? '--',
              ),
              ActionItemDetailItemView(
                label: 'Company',
                content: actionItem.companyName ?? '--',
              ),
              ActionItemDetailItemView(
                label: 'Project',
                content: actionItem.projectName ?? '--',
              ),
              ActionItemDetailItemView(
                label: 'Area',
                content: actionItem.area ?? '--',
              ),
              CustomBottomBorderContainer(
                padding: inset12,
                child: Text(
                  'notes',
                  style: textNormal12,
                ),
              ),
              CustomBottomBorderContainer(
                padding: inset12,
                child: Text(
                  actionItem.notes ?? '',
                  style: textNormal12,
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }
}

class ActionItemDetailItemView extends StatelessWidget {
  final String label;
  final String content;
  const ActionItemDetailItemView({
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
              style: textNormal12,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              content,
              style: textNormal12,
            ),
          ),
        ],
      ),
    );
  }
}
