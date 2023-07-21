// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_detail_bloc.dart';

class AuditDetailState extends Equatable {
  final AuditSummary? auditSummary;
  final EntityStatus auditLoadStatus;
  final EntityStatus auditDeleteStatus;

  final List<AuditSectionAndQuestion> auditSectionAndQuestionList;
  final AuditSectionAndQuestion? selectedAuditSection;

  final List<Document> documentList;
  final List<AuditActionItem> actionItemList;
  final List<ObservationDetail> observationList;

  final EntityStatus status;

  final String message;
  const AuditDetailState({
    this.auditSummary,
    this.auditLoadStatus = EntityStatus.initial,
    this.auditDeleteStatus = EntityStatus.initial,
    this.status = EntityStatus.initial,
    this.auditSectionAndQuestionList = const [],
    this.documentList = const [],
    this.actionItemList = const [],
    this.observationList = const [],
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
        documentList,
        actionItemList,
        observationList,
        status,
      ];

  bool get isDeletable {
    if (auditSummary == null) {
      return false;
    }
    switch (auditSummary!.auditStatusName!.replaceAll(' ', '').toLowerCase()) {
      case 'draft':
      case 'inprogress':
        return true;
      default:
        return false;
    }
  }

  AuditDetailState copyWith({
    AuditSummary? auditSummary,
    EntityStatus? auditLoadStatus,
    EntityStatus? auditDeleteStatus,
    List<AuditSectionAndQuestion>? auditSectionAndQuestionList,
    AuditSectionAndQuestion? selectedAuditSection,
    List<Document>? documentList,
    List<AuditActionItem>? actionItemList,
    List<ObservationDetail>? observationList,
    EntityStatus? status,
    String? message,
  }) {
    return AuditDetailState(
      auditSummary: auditSummary ?? this.auditSummary,
      auditLoadStatus: auditLoadStatus ?? this.auditLoadStatus,
      auditDeleteStatus: auditDeleteStatus ?? this.auditDeleteStatus,
      auditSectionAndQuestionList:
          auditSectionAndQuestionList ?? this.auditSectionAndQuestionList,
      selectedAuditSection: selectedAuditSection ?? this.selectedAuditSection,
      documentList: documentList ?? this.documentList,
      actionItemList: actionItemList ?? this.actionItemList,
      observationList: observationList ?? this.observationList,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
