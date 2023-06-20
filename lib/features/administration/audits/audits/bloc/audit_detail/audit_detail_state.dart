// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_detail_bloc.dart';

class AuditDetailState extends Equatable {
  final Audit? audit;
  final EntityStatus auditLoadStatus;
  final EntityStatus auditDeleteStatus;
  final String message;
  const AuditDetailState({
    this.audit,
    this.auditLoadStatus = EntityStatus.initial,
    this.auditDeleteStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        audit,
        auditLoadStatus,
        auditDeleteStatus,
        message,
      ];

  AuditDetailState copyWith({
    Audit? audit,
    EntityStatus? auditLoadStatus,
    EntityStatus? auditDeleteStatus,
    String? message,
  }) {
    return AuditDetailState(
      audit: audit ?? this.audit,
      auditLoadStatus: auditLoadStatus ?? this.auditLoadStatus,
      auditDeleteStatus: auditDeleteStatus ?? this.auditDeleteStatus,
      message: message ?? this.message,
    );
  }
}
