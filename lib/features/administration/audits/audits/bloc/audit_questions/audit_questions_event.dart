// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_questions_bloc.dart';

abstract class AuditQuestionsEvent extends Equatable {
  const AuditQuestionsEvent();

  @override
  List<Object?> get props => [];
}

/// event to load the audit question snapshot list
class AuditQuestionsSnapshotListLoaded extends AuditQuestionsEvent {
  final String auditId;
  const AuditQuestionsSnapshotListLoaded({
    required this.auditId,
  });

  @override
  List<Object> get props => [auditId];
}

/// event to load audit section list
class AuditQuestionsAuditSectionListLoaded extends AuditQuestionsEvent {
  final String auditId;
  const AuditQuestionsAuditSectionListLoaded({
    required this.auditId,
  });

  @override
  List<Object> get props => [auditId];
}

/// event to load audit question list
class AuditQuestionsAuditQuestionListLoaded extends AuditQuestionsEvent {}

/// event to change selected audit detail
class AuditQuestionsSelectedAuditSectionChanged extends AuditQuestionsEvent {
  final AuditSection auditSection;
  const AuditQuestionsSelectedAuditSectionChanged({
    required this.auditSection,
  });

  @override
  List<Object> get props => [auditSection];
}

/// event to include or exclude the question

class AuditQuestionsIncludedChanged extends AuditQuestionsEvent {
  final String questionId;
  final bool isIncluded;
  final bool isNew;
  const AuditQuestionsIncludedChanged({
    required this.questionId,
    required this.isIncluded,
    required this.isNew,
  });

  @override
  List<Object?> get props => [
        questionId,
        isIncluded,
        isNew,
      ];
}

/// event to include or exclude the section

class AuditQuestionsSectionIncludedChanged extends AuditQuestionsEvent {
  final String sectionId;
  final bool isIncluded;
  const AuditQuestionsSectionIncludedChanged({
    required this.sectionId,
    required this.isIncluded,
  });

  @override
  List<Object?> get props => [
        sectionId,
        isIncluded,
      ];
}
