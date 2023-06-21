// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_list_bloc.dart';

class AuditListState extends Equatable {
  /// loaded audit list
  final List<Audit> auditList;

  /// audit list load status
  final EntityStatus auditListLoadStatus;

  /// selected audit
  final Audit? audit;

  /// total rows of audit list
  final int totalRows;
  const AuditListState({
    this.auditList = const [],
    this.auditListLoadStatus = EntityStatus.initial,
    this.audit,
    this.totalRows = 0,
  });

  @override
  List<Object?> get props => [
        auditList,
        auditListLoadStatus,
        audit,
        totalRows,
      ];

  AuditListState copyWith({
    List<Audit>? auditList,
    EntityStatus? auditListLoadStatus,
    Audit? audit,
    int? totalRows,
  }) {
    return AuditListState(
      auditList: auditList ?? this.auditList,
      auditListLoadStatus: auditListLoadStatus ?? this.auditListLoadStatus,
      audit: audit ?? this.audit,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
