// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_comment_bloc.dart';

class ExecuteAuditCommentState extends Equatable {
  final List<AuditComment> auditCommentList;

  final AuditComment? auditComment;

  final String initialCommentText;
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
    this.initialCommentText = '',
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
        initialCommentText,
        commentText,
        commentValidationMessage,
        status,
        view,
        message,
        crudStatus,
      ];

  bool get isDirty =>
      Validation.isNotEmpty(commentText) && commentText != initialCommentText;

  ExecuteAuditCommentState copyWith({
    List<AuditComment>? auditCommentList,
    Nullable<AuditComment?>? auditComment,
    String? initialCommentText,
    String? commentText,
    String? commentValidationMessage,
    EntityStatus? status,
    CrudView? view,
    EntityStatus? crudStatus,
    String? message,
  }) {
    return ExecuteAuditCommentState(
      auditCommentList: auditCommentList ?? this.auditCommentList,
      auditComment:
          auditComment != null ? auditComment.value : this.auditComment,
      initialCommentText: initialCommentText ?? this.initialCommentText,
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
