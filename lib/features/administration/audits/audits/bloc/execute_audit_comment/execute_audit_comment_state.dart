part of 'execute_audit_comment_bloc.dart';

class ExecuteAuditCommentState extends Equatable {
  final List<AuditComment> auditCommentList;
  final EntityStatus auditCommentListLoadStatus;

  final AuditComment? auditComment;
  final EntityStatus auditCommentLoadStatus;

  final String commentText;
  final String commentValidationMessage;

  final EntityStatus status;

  final CrudView view;

  const ExecuteAuditCommentState({
    this.auditCommentList = const [],
    this.auditCommentListLoadStatus = EntityStatus.initial,
    this.auditComment,
    this.auditCommentLoadStatus = EntityStatus.initial,
    this.commentText = '',
    this.commentValidationMessage = '',
    this.status = EntityStatus.initial,
    this.view = CrudView.list,
  });

  @override
  List<Object?> get props => [
        auditCommentList,
        auditCommentListLoadStatus,
        auditComment,
        auditCommentLoadStatus,
        commentText,
        commentValidationMessage,
        status,
        view,
      ];

  ExecuteAuditCommentState copyWith({
    List<AuditComment>? auditCommentList,
    EntityStatus? auditCommentListLoadStatus,
    AuditComment? auditComment,
    EntityStatus? auditCommentLoadStatus,
    String? commentText,
    String? commentValidationMessage,
    EntityStatus? status,
    CrudView? view,
  }) {
    return ExecuteAuditCommentState(
      auditCommentList: auditCommentList ?? this.auditCommentList,
      auditCommentListLoadStatus:
          auditCommentListLoadStatus ?? this.auditCommentListLoadStatus,
      auditComment: auditComment ?? this.auditComment,
      auditCommentLoadStatus:
          auditCommentLoadStatus ?? this.auditCommentLoadStatus,
      commentText: commentText ?? this.commentText,
      commentValidationMessage:
          commentValidationMessage ?? this.commentValidationMessage,
      status: status ?? this.status,
      view: view ?? this.view,
    );
  }
}
