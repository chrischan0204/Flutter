// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'action_item_list_bloc.dart';

class ActionItemListState extends Equatable {
  /// loaded actionItem list
  final List<ActionItem> actionItemList;

  /// actionItem list load status
  final EntityStatus actionItemListLoadStatus;

  /// selected actionItem for detail
  final ActionItem? actionItem;

  /// actionItem load status
  final EntityStatus actionItemLoadStatus;

  /// total rows of actionItem list
  final int totalRows;
  const ActionItemListState({
    this.actionItemList = const [],
    this.actionItem,
    this.actionItemListLoadStatus = EntityStatus.initial,
    this.actionItemLoadStatus = EntityStatus.initial,
    this.totalRows = 0,
  });

  @override
  List<Object?> get props => [
        actionItemList,
        actionItemListLoadStatus,
        actionItemLoadStatus,
        actionItem,
        totalRows,
      ];

  ActionItemListState copyWith({
    List<ActionItem>? actionItemList,
    EntityStatus? actionItemListLoadStatus,
    ActionItem? actionItem,
    EntityStatus? actionItemLoadStatus,
    int? totalRows,
  }) {
    return ActionItemListState(
      actionItemList: actionItemList ?? this.actionItemList,
      actionItemListLoadStatus:
          actionItemListLoadStatus ?? this.actionItemListLoadStatus,
      actionItem: actionItem ?? this.actionItem,
      actionItemLoadStatus:
          actionItemLoadStatus ?? this.actionItemLoadStatus,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
