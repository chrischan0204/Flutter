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
