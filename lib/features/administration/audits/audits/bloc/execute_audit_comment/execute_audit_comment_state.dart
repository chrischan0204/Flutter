// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_comment_bloc.dart';

class ExecuteAuditCommentState extends Equatable {
  final List<AuditComment> auditCommentList;

  final AuditComment? auditComment;

  final String commentText;
  final String commentValidationMessage;

  final EntityStatus status;

  final CrudView view;

  final EntityStatus crudStatus;
  final String message;

  const ExecuteAuditCommentState({
    this.auditCommentList = const [],
    this.auditComment,
    this.commentText = '',
    this.commentValidationMessage = '',
    this.status = EntityStatus.initial,
    this.view = CrudView.list,
    this.crudStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        auditCommentList,
        auditComment,
        commentText,
        commentValidationMessage,
        status,
        view,
        message,
        crudStatus,
      ];

  ExecuteAuditCommentState copyWith({
    List<AuditComment>? auditCommentList,
    AuditComment? auditComment,
    String? commentText,
    String? commentValidationMessage,
    EntityStatus? status,
    CrudView? view,
    EntityStatus? crudStatus,
    String? message,
  }) {
    return ExecuteAuditCommentState(
      auditCommentList: auditCommentList ?? this.auditCommentList,
      auditComment: auditComment ?? this.auditComment,
      commentText: commentText ?? this.commentText,
      commentValidationMessage:
          commentValidationMessage ?? this.commentValidationMessage,
      status: status ?? this.status,
      view: view ?? this.view,
      crudStatus: crudStatus ?? this.crudStatus,
      message: message ?? this.message,
    );
  }
}
