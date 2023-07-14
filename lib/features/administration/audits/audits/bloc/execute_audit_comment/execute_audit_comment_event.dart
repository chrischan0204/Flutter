// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_comment_bloc.dart';

abstract class ExecuteAuditCommentEvent extends Equatable {
  const ExecuteAuditCommentEvent();

  @override
  List<Object> get props => [];
}

class ExecuteAuditCommentListLoaded extends ExecuteAuditCommentEvent {}

class ExecuteAuditCommentCreated extends ExecuteAuditCommentEvent {}

class ExecuteAuditCommentUpdated extends ExecuteAuditCommentEvent {}

class ExecuteAuditCommentSelected extends ExecuteAuditCommentEvent {}

class ExecuteAuditCommentTextChanged extends ExecuteAuditCommentEvent {
  final String commentText;

  const ExecuteAuditCommentTextChanged({required this.commentText});

  @override
  List<Object> get props => [commentText];
}

class ExecuteAuditCommentDeleted extends ExecuteAuditCommentEvent {
  final String commentId;

  const ExecuteAuditCommentDeleted({
    required this.commentId,
  });

  @override
  List<Object> get props => [commentId];
}

class ExecuteAuditCommentViewChanged extends ExecuteAuditCommentEvent {
  final CrudView view;

  const ExecuteAuditCommentViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}

class ExecuteAuditCommentLoaded extends ExecuteAuditCommentEvent {
  final String commentId;

  const ExecuteAuditCommentLoaded({required this.commentId});

  @override
  List<Object> get props => [commentId];
}
