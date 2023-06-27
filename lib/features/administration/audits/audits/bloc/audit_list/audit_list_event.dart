// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_list_bloc.dart';

abstract class AuditListEvent extends Equatable {
  const AuditListEvent();

  @override
  List<Object?> get props => [];
}

class AuditListLoaded extends AuditListEvent {}

class AuditListFiltered extends AuditListEvent {
  final FilteredTableParameter option;
  const AuditListFiltered({
    required this.option,
  });

  @override
  List<Object?> get props => [option];
}

class AuditListAuditForSideDetailLoaded extends AuditListEvent {
  final String auditId;
  const AuditListAuditForSideDetailLoaded({required this.auditId});

  @override
  List<Object?> get props => [auditId];
}
