import '/common_libraries.dart';

class AuditDetailActionItemListView extends StatelessWidget {
  final List<AuditActionItem> actionItemList;
  const AuditDetailActionItemListView({
    super.key,
    required this.actionItemList,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBottomBorderContainer(
              padding: inset20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Action Items List',
                    style: textSemiBold18,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      PhosphorIcons.regular.x,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: inset10,
              child: Text(
                'The following action were created items in this audit...',
                style: textSemiBold18,
              ),
            ),
            const AuditDetailObservationActionItem(
              actionRequired: 'Action required',
              status: 'Status',
              assignee: 'Assignee',
              isBold: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final actionItem in actionItemList)
                      AuditDetailObservationActionItem(
                        actionRequired: actionItem.description ?? '--',
                        status: actionItem.status ?? '--',
                        assignee: actionItem.assigneeName ?? '--',
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AuditDetailObservationActionItem extends StatelessWidget {
  final String actionRequired;
  final String status;
  final String assignee;
  final bool isBold;
  const AuditDetailObservationActionItem({
    super.key,
    required this.actionRequired,
    required this.status,
    required this.assignee,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: insetx24y12,
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                actionRequired,
                style: isBold ? textBold14 : textSemiBold14,
              )),
          SizedBox(
            width: 100,
            child: isBold
                ? Text(
                    status,
                    style: textBold14,
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: CustomBadge(
                      width: 50,
                      label: status,
                      color: status == 'Overdue'
                          ? Colors.red
                          : status == 'Pending'
                              ? warnColor
                              : status == 'Done'
                                  ? successColor
                                  : primaryColor,
                    ),
                  ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                assignee,
                style: isBold ? textBold14 : textSemiBold14,
              ))
        ],
      ),
    );
  }
}
