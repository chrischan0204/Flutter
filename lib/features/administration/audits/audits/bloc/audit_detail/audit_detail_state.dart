part of 'audit_detail_bloc.dart';

class AuditDetailState extends Equatable {
  final Audit? audit;
  final EntityStatus auditLoadStatus;
  final EntityStatus auditDeleteStatus;

  final List<AuditSection> auditSectionList;
  final AuditSection? selectedAuditSection;

  final String message;
  const AuditDetailState({
    this.audit,
    this.auditLoadStatus = EntityStatus.initial,
    this.auditDeleteStatus = EntityStatus.initial,
    this.auditSectionList = const [],
    this.selectedAuditSection,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        audit,
        auditLoadStatus,
        auditDeleteStatus,
        auditSectionList,
        selectedAuditSection,
        message,
      ];

  AuditDetailState copyWith({
    Audit? audit,
    EntityStatus? auditLoadStatus,
    EntityStatus? auditDeleteStatus,
    List<AuditSection>? auditSectionList,
    AuditSection? selectedAuditSection,
    String? message,
  }) {
    return AuditDetailState(
      audit: audit ?? this.audit,
      auditLoadStatus: auditLoadStatus ?? this.auditLoadStatus,
      auditDeleteStatus: auditDeleteStatus ?? this.auditDeleteStatus,
      auditSectionList: auditSectionList ?? this.auditSectionList,
      selectedAuditSection: selectedAuditSection ?? this.selectedAuditSection,
      message: message ?? this.message,
    );
  }
}
