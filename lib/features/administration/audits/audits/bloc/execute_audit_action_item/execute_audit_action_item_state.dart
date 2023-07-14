part of 'execute_audit_action_item_bloc.dart';

class ExecuteAuditActionItemState extends Equatable {
  final List<AuditActionItem> auditActionItemList;
  final EntityStatus auditActionItemListLoadStatus;

  final ActionItemDetail? auditActionItem;
  final EntityStatus auditActionItemLoadStatus;

  final String actionItemText;

  final EntityStatus status;

  final CrudView view;

  /// fields to create actionItem

  const ExecuteAuditActionItemState({
    this.auditActionItemList = const [],
    this.auditActionItemListLoadStatus = EntityStatus.initial,
    this.auditActionItem,
    this.auditActionItemLoadStatus = EntityStatus.initial,
    this.actionItemText = '',
    this.status = EntityStatus.initial,
    this.view = CrudView.list,
  });

  @override
  List<Object?> get props => [
        auditActionItemList,
        auditActionItemListLoadStatus,
        auditActionItem,
        auditActionItemLoadStatus,
        actionItemText,
        status,
        view,
      ];

  // ExecuteAuditActionItemState copyWith({
  //   List<AuditActionItem>? auditActionItemList,
  //   EntityStatus? auditActionItemListLoadStatus,
  //   ActionItemDetail? auditActionItem,
  //   EntityStatus? auditActionItemLoadStatus,
  //   String? actionItemText,
  //   EntityStatus? status,
  //   CrudView? view,
  // }) {
  //   return ExecuteAuditActionItemState(
  //     auditActionItemList: auditActionItemList ?? this.auditActionItemList,
  //     auditActionItemListLoadStatus:
  //         auditActionItemListLoadStatus ?? this.auditActionItemListLoadStatus,
  //     auditActionItem: auditActionItem ?? this.auditActionItem,
  //     auditActionItemLoadStatus:
  //         auditActionItemLoadStatus ?? this.auditActionItemLoadStatus,
  //     actionItemText: actionItemText ?? this.actionItemText,
  //     status: status ?? this.status,
  //     view: view ?? this.view,
  //   );
  // }
}
