part of 'add_edit_audit_bloc.dart';

abstract class AddEditAuditEvent extends Equatable {
  const AddEditAuditEvent();

  @override
  List<Object> get props => [];
}

/// event to add audit
class AddEditAuditAdded extends AddEditAuditEvent {}

/// event to edit audit
class AddEditAuditEdited extends AddEditAuditEvent {
  /// audit id to edit
  final String id;
  const AddEditAuditEdited({required this.id});

  @override
  List<Object> get props => [id];
}

/// event to load the audit by id
class AddEditAuditLoaded extends AddEditAuditEvent {
  /// audit id to load
  final String id;
  const AddEditAuditLoaded({required this.id});

  @override
  List<Object> get props => [id];
}
