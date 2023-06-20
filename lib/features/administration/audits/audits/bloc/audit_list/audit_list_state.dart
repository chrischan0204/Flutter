part of 'audit_list_bloc.dart';

class AuditListState extends Equatable {
  /// loaded audit list
  final List<Audit> auditList;

  /// audit list load status
  final EntityStatus auditListLoadStatus;

  /// total rows of audit list
  final int totalRows;
  const AuditListState({
    this.auditList = const [],
    this.auditListLoadStatus = EntityStatus.initial,
    this.totalRows = 0,
  });

  @override
  List<Object> get props => [
        auditList,
        auditListLoadStatus,
        totalRows,
      ];

  AuditListState copyWith({
    List<Audit>? auditList,
    EntityStatus? auditListLoadStatus,
    int? totalRows,
  }) {
    return AuditListState(
      auditList: auditList ?? this.auditList,
      auditListLoadStatus: auditListLoadStatus ?? this.auditListLoadStatus,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
