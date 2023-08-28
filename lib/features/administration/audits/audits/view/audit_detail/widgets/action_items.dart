import '/common_libraries.dart';

class ActionItemsView extends StatefulWidget {
  const ActionItemsView({super.key});

  @override
  State<ActionItemsView> createState() => _ActionItemsViewState();
}

class _ActionItemsViewState extends State<ActionItemsView> {
  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailAuditActionItemsStatsLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomBottomBorderContainer(
                padding: inset10,
                child: Text(
                  'Action Items',
                  style: textSemiBold16,
                ),
              ),
              CustomBottomBorderContainer(
                padding: inset10,
                child: Text(
                  'Stats',
                  style: textSemiBold14,
                ),
              ),
              if (state.actionItemsStats != null)
                CustomBottomBorderContainer(
                  padding: inset10,
                  child: Column(
                    children: [
                      Padding(
                        padding: inset10,
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 3,
                              child: Text('Total Action Items:'),
                            ),
                            Expanded(
                              child: Text(
                                  state.actionItemsStats!.total.toString()),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: inset10,
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 3,
                              child: Text('Closed:'),
                            ),
                            Expanded(
                              child: Text(
                                  state.actionItemsStats!.closed.toString()),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: inset10,
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 3,
                              child: Text('Open:'),
                            ),
                            Expanded(
                              child:
                                  Text(state.actionItemsStats!.open.toString()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              CustomBottomBorderContainer(
                padding: inset10,
                child: Text(
                  'All Action Items',
                  style: textSemiBold14,
                ),
              ),
              const ActionItemView(
                status: 'Status',
                task: 'Task',
                assignee: 'Assignee',
                isTitle: true,
              ),
              const ActionItemView(
                status: 'Done',
                task: 'Inspect the staircase after cleaning',
                assignee: 'Hugh Tulley',
              ),
              const ActionItemView(
                status: 'Due soon',
                task: 'Call contractor to hide wire',
                assignee: 'Hugh Tulley',
              ),
              const ActionItemView(
                status: 'Overdue',
                task: 'Change the outlet in basement',
                assignee: 'Hugh Tulley',
              ),
            ],
          );
        },
      ),
    );
  }
}

class ActionItemView extends StatelessWidget {
  final String status;
  final String task;
  final String assignee;
  final bool isTitle;
  const ActionItemView({
    super.key,
    required this.status,
    required this.task,
    required this.assignee,
    this.isTitle = false,
  });

  Color _getColor() {
    switch (status) {
      case 'Done':
        return successColor;
      case 'Due soon':
        return primaryColor;
      case 'Overdue':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: insetx20y10,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: isTitle
                ? Text(
                    status,
                    style: isTitle
                        ? const TextStyle(fontWeight: FontWeight.w600)
                        : null,
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBadge(
                      label: status,
                      color: _getColor(),
                    ),
                  ),
          ),
          Expanded(
            child: Text(
              task,
              style:
                  isTitle ? const TextStyle(fontWeight: FontWeight.w600) : null,
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              assignee,
              style:
                  isTitle ? const TextStyle(fontWeight: FontWeight.w600) : null,
            ),
          ),
        ],
      ),
    );
  }
}
