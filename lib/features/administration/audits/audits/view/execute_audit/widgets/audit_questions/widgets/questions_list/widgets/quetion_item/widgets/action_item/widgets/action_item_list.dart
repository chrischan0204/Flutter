import '/common_libraries.dart';

class AuditActionItemListView extends StatelessWidget {
  const AuditActionItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditActionItemBloc, ExecuteAuditActionItemState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.auditActionItemListLoadStatus.isLoading)
              const Center(child: Loader()),
            if (state.auditActionItemListLoadStatus.isSuccess)
              for (final actionItem in state.auditActionItemList)
                AuditActionItemListItemView(actionItem: actionItem)
          ],
        );
      },
    );
  }
}

class AuditActionItemListItemView extends StatelessWidget {
  final AuditActionItem actionItem;
  const AuditActionItemListItemView({
    super.key,
    required this.actionItem,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            actionItem.description ?? '',
            style: textNormal14,
          ),
          spacery10,
          Row(
            children: [
              Expanded(
                  child: RichText(
                text: TextSpan(
                  text: 'Due By: ',
                  style: textSemiBold12,
                  children: [
                    TextSpan(
                      text: actionItem.formatedDueBy,
                      style: textNormal12,
                    )
                  ],
                ),
              )),
              Expanded(
                  child: RichText(
                text: TextSpan(
                  text: 'Assignee: ',
                  style: textSemiBold12,
                  children: [
                    TextSpan(
                      text: actionItem.assigneeName ?? '',
                      style: textNormal12,
                    )
                  ],
                ),
              )),
              Expanded(
                  child: RichText(
                text: TextSpan(
                  text: 'Creator: ',
                  style: textSemiBold12,
                  children: [
                    TextSpan(
                      text: actionItem.createdBy ?? '',
                      style: textNormal12,
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: actionItem.isClosed == true
                      ? null
                      : () {
                          context.read<ExecuteAuditActionItemBloc>()
                            ..add(const ExecuteAuditActionItemViewChanged(
                                view: CrudView.update))
                            ..add(ExecuteAuditActionItemLoaded(
                                actionItemId: actionItem.id));
                        },
                  icon: Icon(
                    PhosphorIcons.regular.wrench,
                    size: 14,
                    color: Colors.orange,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    context.read<ExecuteAuditActionItemBloc>()
                      ..add(const ExecuteAuditActionItemViewChanged(
                          view: CrudView.detail))
                      ..add(ExecuteAuditActionItemLoaded(
                          actionItemId: actionItem.id));
                  },
                  icon: Icon(
                    PhosphorIcons.regular.appWindow,
                    size: 14,
                    color: Colors.purple,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: actionItem.isClosed == true
                      ? null
                      : () {
                          CustomAlert(
                            context: context,
                            width: MediaQuery.of(context).size.width / 4,
                            title: 'Notification',
                            description: 'Deleting action item. Are you sure?',
                            btnOkText: 'OK',
                            btnOkOnPress: () => context
                                .read<ExecuteAuditActionItemBloc>()
                                .add(ExecuteAuditActionItemDeleted(
                                    actionItemId: actionItem.id)),
                            btnCancelOnPress: () {},
                            dialogType: DialogType.info,
                          ).show();
                        },
                  icon: Icon(
                    PhosphorIcons.regular.trash,
                    size: 14,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
