// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_comment_bloc.dart';

abstract class ExecuteAuditCommentEvent extends Equatable {
  const ExecuteAuditCommentEvent();

  @override
  List<Object> get props => [];
}

/// event to load comment list
class ExecuteAuditCommentListLoaded extends ExecuteAuditCommentEvent {}

/// event to create comment
class ExecuteAuditCommentCreated extends ExecuteAuditCommentEvent {}

/// event to update comment
class ExecuteAuditCommentUpdated extends ExecuteAuditCommentEvent {}

/// event to select comment to show detail or update
class ExecuteAuditCommentSelected extends ExecuteAuditCommentEvent {}

/// event to change comment text to create comment
class ExecuteAuditCommentTextChanged extends ExecuteAuditCommentEvent {
  final String commentText;

  const ExecuteAuditCommentTextChanged({required this.commentText});

  @override
  List<Object> get props => [commentText];
}

/// event to delete comment by id
class ExecuteAuditCommentDeleted extends ExecuteAuditCommentEvent {
  final String commentId;

  const ExecuteAuditCommentDeleted({
    required this.commentId,
  });

  @override
  List<Object> get props => [commentId];
}

/// event to change view - list, create, updat, detail
class ExecuteAuditCommentViewChanged extends ExecuteAuditCommentEvent {
  final CrudView view;

  const ExecuteAuditCommentViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}

/// event to load comment detail
class ExecuteAuditCommentLoaded extends ExecuteAuditCommentEvent {
  final String commentId;

  const ExecuteAuditCommentLoaded({required this.commentId});

  @override
  List<Object> get props => [commentId];
}

/// event to init state
class ExecuteAuditCommentInited extends ExecuteAuditCommentEvent {}