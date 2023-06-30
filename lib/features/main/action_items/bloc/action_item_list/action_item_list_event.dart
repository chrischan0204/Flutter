part of 'action_item_list_bloc.dart';

abstract class ActionItemListEvent extends Equatable {
  const ActionItemListEvent();

  @override
  List<Object?> get props => [];
}

class ActionItemListLoaded extends ActionItemListEvent {}

class ActionItemListFiltered extends ActionItemListEvent {
  final FilteredTableParameter option;
  const ActionItemListFiltered({
    required this.option,
  });

  @override
  List<Object?> get props => [option];
}

class ActionItemListActionItemForSideDetailLoaded
    extends ActionItemListEvent {
  final String actionItemId;
  const ActionItemListActionItemForSideDetailLoaded(
      {required this.actionItemId});

  @override
  List<Object?> get props => [actionItemId];
}
