part of 'action_item_detail_bloc.dart';

abstract class ActionItemDetailEvent extends Equatable {
  const ActionItemDetailEvent();

  @override
  List<Object> get props => [];
}

/// event to load the actionItem detail
class ActionItemDetailLoaded extends ActionItemDetailEvent {}

/// event to delete actionItem
class ActionItemDetailActionItemDeleted extends ActionItemDetailEvent {}

/// event to load action item parent info
class ActionItemDetailParentInfoLoaded extends ActionItemDetailEvent {}
