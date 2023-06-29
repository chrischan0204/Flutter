part of 'audit_detail_bloc.dart';

class AuditDetailState extends Equatable {
  final AuditSummary? auditSummary;
  final EntityStatus auditLoadStatus;
  final EntityStatus auditDeleteStatus;

  // final List<AuditSection> auditSectionList;
  final List<AuditSectionAndQuestion> auditSectionAndQuestionList;
  final AuditSectionAndQuestion? selectedAuditSection;

  final String message;
  const AuditDetailState({
    this.auditSummary,
    this.auditLoadStatus = EntityStatus.initial,
    this.auditDeleteStatus = EntityStatus.initial,
    this.auditSectionAndQuestionList = const [],
    this.selectedAuditSection,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        auditSummary,
        auditLoadStatus,
        auditDeleteStatus,
        auditSectionAndQuestionList,
        selectedAuditSection,
        message,
      ];

  AuditDetailState copyWith({
    AuditSummary? auditSummary,
    EntityStatus? auditLoadStatus,
    EntityStatus? auditDeleteStatus,
    List<AuditSectionAndQuestion>? auditSectionAndQuestionList,
    AuditSectionAndQuestion? selectedAuditSection,
    String? message,
  }) {
    return AuditDetailState(
      auditSummary: auditSummary ?? this.auditSummary,
      auditLoadStatus: auditLoadStatus ?? this.auditLoadStatus,
      auditDeleteStatus: auditDeleteStatus ?? this.auditDeleteStatus,
      auditSectionAndQuestionList:
          auditSectionAndQuestionList ?? this.auditSectionAndQuestionList,
      selectedAuditSection: selectedAuditSection ?? this.selectedAuditSection,
      message: message ?? this.message,
    );
  }
}
