// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'action_item_detail_bloc.dart';

abstract class ActionItemDetailEvent extends Equatable {
  const ActionItemDetailEvent();

  @override
  List<Object> get props => [];
}

/// event to load the action item detail
class ActionItemDetailLoaded extends ActionItemDetailEvent {}

/// event to delete action item
class ActionItemDetailActionItemDeleted extends ActionItemDetailEvent {}

/// event to load document list
class ActionItemDetailDocumentListLoaded extends ActionItemDetailEvent {}

/// event to delete document
class ActionItemDetailDocumentDeleted extends ActionItemDetailEvent {
  final String documentId;
  const ActionItemDetailDocumentDeleted({
    required this.documentId,
  });

  @override
  List<Object> get props => [documentId];
}
