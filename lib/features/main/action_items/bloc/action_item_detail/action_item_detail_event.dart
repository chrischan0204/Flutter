// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class ActionItemDetailDocumentListLoaded extends ActionItemDetailEvent {}

class ActionItemDetailDocumentDeleted extends ActionItemDetailEvent {
  final String documentId;
  const ActionItemDetailDocumentDeleted({
    required this.documentId,
  });

  @override
  List<Object> get props => [documentId];
}
