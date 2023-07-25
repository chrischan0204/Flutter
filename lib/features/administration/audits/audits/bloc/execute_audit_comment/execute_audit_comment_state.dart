part of 'execute_audit_comment_bloc.dart';

class ExecuteAuditCommentState extends Equatable {
  final List<AuditComment> auditCommentList;

  final AuditComment? auditComment;

  final String commentText;
  final String commentValidationMessage;

  final EntityStatus status;

  final CrudView view;

  const ExecuteAuditCommentState({
    this.auditCommentList = const [],
    this.auditComment,
    this.commentText = '',
    this.commentValidationMessage = '',
    this.status = EntityStatus.initial,
    this.view = CrudView.list,
  });

  @override
  List<Object?> get props => [
        auditCommentList,
        auditComment,
        commentText,
        commentValidationMessage,
        status,
        view,
      ];

  ExecuteAuditCommentState copyWith({
    List<AuditComment>? auditCommentList,
    AuditComment? auditComment,
    String? commentText,
    String? commentValidationMessage,
    EntityStatus? status,
    CrudView? view,
  }) {
    return ExecuteAuditCommentState(
      auditCommentList: auditCommentList ?? this.auditCommentList,
      auditComment: auditComment ?? this.auditComment,
      commentText: commentText ?? this.commentText,
      commentValidationMessage:
          commentValidationMessage ?? this.commentValidationMessage,
      status: status ?? this.status,
      view: view ?? this.view,
    );
  }
}
