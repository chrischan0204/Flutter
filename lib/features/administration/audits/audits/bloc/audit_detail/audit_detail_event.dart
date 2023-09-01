// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_detail_bloc.dart';

abstract class AuditDetailEvent extends Equatable {
  const AuditDetailEvent();

  @override
  List<Object> get props => [];
}

/// event to load the audit detail
class AuditDetailLoaded extends AuditDetailEvent {
  /// audit id to load
  final String auditId;
  const AuditDetailLoaded({
    required this.auditId,
  });

  @override
  List<Object> get props => [auditId];
}

class AuditDetailAuditDeleted extends AuditDetailEvent {}

/// event to load audit section list
class AuditDetailAuditSectionListLoaded extends AuditDetailEvent {}

/// event to change selected audit detail
class AuditDetailSelectedAuditSectionChanged extends AuditDetailEvent {
  final AuditSectionAndQuestion auditSection;
  const AuditDetailSelectedAuditSectionChanged({
    required this.auditSection,
  });

  @override
  List<Object> get props => [auditSection];
}

/// event to load document list
class AuditDetailDocumentListLoaded extends AuditDetailEvent {}

/// event to load observation list
class AuditDetailObservationListLoaded extends AuditDetailEvent {}

/// event to load action item list
class AuditDetailActionItemListLoaded extends AuditDetailEvent {}

/// event to select method for completion
class AuditDetailMethodSelected extends AuditDetailEvent {
  final String method;
  const AuditDetailMethodSelected({
    required this.method,
  });

  @override
  List<Object> get props => [method];
}

/// event to add new reviewer to save
class AuditDetailReviewerItemIncreased extends AuditDetailEvent {
  final int index;
  const AuditDetailReviewerItemIncreased({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

/// event to select reviewer for dropdown at index position
class AuditDetailReviewerSelected extends AuditDetailEvent {
  final int index;
  final User reviewer;
  const AuditDetailReviewerSelected({
    required this.index,
    required this.reviewer,
  });

  @override
  List<Object> get props => [index, reviewer];
}

/// event to load reviewer list
class AuditDetailReviewerListLoaded extends AuditDetailEvent {}

/// event to mark audit completed
class AuditDetailAuditMarkCompleted extends AuditDetailEvent {}

/// event to mark audit closed
class AuditDetailAuditMarkClosed extends AuditDetailEvent {}

/// event to mark audit in review
class AuditDetailAuditMarkInReview extends AuditDetailEvent {}

/// event to save reviewers
class AuditDetailReviewersSaved extends AuditDetailEvent {}

/// event to load review list for audit
class AuditDetailReviewListLoaded extends AuditDetailEvent {}

/// event to change comment to leave
class AuditDetailCommentChanged extends AuditDetailEvent {
  final String comment;
  const AuditDetailCommentChanged({
    required this.comment,
  });

  @override
  List<Object> get props => [comment];
}

/// event to save comment
class AuditDetailCommentSaved extends AuditDetailEvent {}

/// event to load completed question with follow ups
class AuditDetailAuditCompletedQuestionsWithFollowupsListLoaded
    extends AuditDetailEvent {}

/// event to load audit action item stats
class AuditDetailAuditActionItemsStatsLoaded extends AuditDetailEvent {}

/// event to load comment list for audit question
class AuditDetailQuestionCommentListLoaded extends AuditDetailEvent {
  final String questionId;
  const AuditDetailQuestionCommentListLoaded({
    required this.questionId,
  });

@override
  List<Object> get props => [questionId];
}
