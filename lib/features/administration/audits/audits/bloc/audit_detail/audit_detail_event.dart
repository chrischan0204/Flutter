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

class AuditDetailAuditDeleted extends AuditDetailEvent {
  /// audit id to delete
  final String auditId;
  const AuditDetailAuditDeleted({
    required this.auditId,
  });

  @override
  List<Object> get props => [auditId];
}
