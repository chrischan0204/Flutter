// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_questions_bloc.dart';

class AuditQuestionsState extends Equatable {
  final List<AuditSection> auditSectionList;
  final String? selectedAuditSectionId;

  final List<AuditQuestion> auditQuestionList;

  final EntityStatus status;
  final EntityStatus questionListLoadStatus;

  final String message;

  const AuditQuestionsState({
    this.auditSectionList = const [],
    this.selectedAuditSectionId,
    this.auditQuestionList = const [],
    this.message = '',
    this.status = EntityStatus.initial,
    this.questionListLoadStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        auditSectionList,
        selectedAuditSectionId,
        auditQuestionList,
        message,
        status,
        questionListLoadStatus,
      ];

  AuditSection get selectedSection => auditSectionList.firstWhere(
      (element) => element.id == selectedAuditSectionId,
      orElse: () => const AuditSection());

  AuditQuestionsState copyWith({
    List<AuditSection>? auditSectionList,
    String? selectedAuditSectionId,
    List<AuditQuestion>? auditQuestionList,
    String? message,
    EntityStatus? status,
    EntityStatus? questionListLoadStatus,
  }) {
    return AuditQuestionsState(
      auditSectionList: auditSectionList ?? this.auditSectionList,
      selectedAuditSectionId:
          selectedAuditSectionId ?? this.selectedAuditSectionId,
      auditQuestionList: auditQuestionList ?? this.auditQuestionList,
      message: message ?? this.message,
      status: status ?? this.status,
      questionListLoadStatus:
          questionListLoadStatus ?? this.questionListLoadStatus,
    );
  }
}
