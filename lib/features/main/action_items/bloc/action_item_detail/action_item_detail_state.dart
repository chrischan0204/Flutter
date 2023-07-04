// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'action_item_detail_bloc.dart';

class ActionItemDetailState extends Equatable {
  /// actionItem for detail
  final ActionItem? actionItem;
  final EntityStatus actionItemLoadStatus;
  final EntityStatus actionItemDeleteStatus;

  final ActionItemParentInfo? actionItemParentInfo;

  final String message;
  const ActionItemDetailState({
    this.actionItem,
    this.actionItemLoadStatus = EntityStatus.initial,
    this.actionItemDeleteStatus = EntityStatus.initial,
    this.actionItemParentInfo,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        actionItem,
        actionItemLoadStatus,
        actionItemDeleteStatus,
        actionItemParentInfo,
        message,
      ];

  ActionItemDetailState copyWith({
    ActionItem? actionItem,
    EntityStatus? actionItemLoadStatus,
    EntityStatus? actionItemDeleteStatus,
    ActionItemParentInfo? actionItemParentInfo,
    String? message,
  }) {
    return ActionItemDetailState(
      actionItem: actionItem ?? this.actionItem,
      actionItemLoadStatus: actionItemLoadStatus ?? this.actionItemLoadStatus,
      actionItemDeleteStatus:
          actionItemDeleteStatus ?? this.actionItemDeleteStatus,
      actionItemParentInfo: actionItemParentInfo ?? this.actionItemParentInfo,
      message: message ?? this.message,
    );
  }
}
