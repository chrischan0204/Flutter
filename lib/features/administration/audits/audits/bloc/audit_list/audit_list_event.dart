// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_list_bloc.dart';

abstract class AuditListEvent extends Equatable {
  const AuditListEvent();

  @override
  List<Object?> get props => [];
}

/// event to load audit list
class AuditListLoaded extends AuditListEvent {}

/// event to get filtered audit list
class AuditListFiltered extends AuditListEvent {
  final FilteredTableParameter option;
  const AuditListFiltered({
    required this.option,
  });

  @override
  List<Object?> get props => [option];
}

/// event to load audit detail for side panel
class AuditListAuditForSideDetailLoaded extends AuditListEvent {
  final String auditId;
  const AuditListAuditForSideDetailLoaded({required this.auditId});

  @override
  List<Object?> get props => [auditId];
}
