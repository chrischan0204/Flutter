part of 'action_item_detail_bloc.dart';

abstract class ActionItemDetailEvent extends Equatable {
  const ActionItemDetailEvent();

  @override
  List<Object> get props => [];
}

/// event to load the actionItem detail
class ActionItemDetailLoaded extends ActionItemDetailEvent {
  /// actionItem id to load
  final String actionItemId;
  const ActionItemDetailLoaded({
    required this.actionItemId,
  });

  @override
  List<Object> get props => [actionItemId];
}

/// event to delete actionItem
class ActionItemDetailActionItemDeleted extends ActionItemDetailEvent {
  /// actionItem id to delete
  final String actionItemId;
  const ActionItemDetailActionItemDeleted({
    required this.actionItemId,
  });

  @override
  List<Object> get props => [actionItemId];
}
