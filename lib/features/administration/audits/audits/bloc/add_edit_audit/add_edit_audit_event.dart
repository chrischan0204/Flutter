// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_audit_bloc.dart';

abstract class AddEditAuditEvent extends Equatable {
  const AddEditAuditEvent();

  @override
  List<Object> get props => [];
}

/// event to add audit
class AddEditAuditAdded extends AddEditAuditEvent {
  /// user id to create audit
  final String userId;
  const AddEditAuditAdded({required this.userId});

  @override
  List<Object> get props => [userId];
}

/// event to edit audit
class AddEditAuditEdited extends AddEditAuditEvent {
  /// audit id to edit
  final String id;
  final String userId;
  const AddEditAuditEdited({
    required this.id,
    required this.userId,
  });

  @override
  List<Object> get props => [
        id,
        userId,
      ];
}

/// event to load the audit by id
class AddEditAuditLoaded extends AddEditAuditEvent {
  /// audit id to load
  final String id;
  const AddEditAuditLoaded({required this.id});

  @override
  List<Object> get props => [id];
}

/// even to load site list
class AddEditAuditSiteListLoaded extends AddEditAuditEvent {}

/// even to load template list
class AddEditAuditTemplateListLoaded extends AddEditAuditEvent {
  /// site id to load template list
  final String siteId;
  const AddEditAuditTemplateListLoaded({
    required this.siteId,
  });

  @override
  List<Object> get props => [siteId];
}

/// even to load project list
class AddEditAuditProjectListLoaded extends AddEditAuditEvent {
  /// site id to load project list
  final String siteId;
  const AddEditAuditProjectListLoaded({
    required this.siteId,
  });

  @override
  List<Object> get props => [siteId];
}

/// event to change the audit name
class AddEditAuditNameChanged extends AddEditAuditEvent {
  /// audit name to change
  final String auditName;
  const AddEditAuditNameChanged({required this.auditName});

  @override
  List<Object> get props => [auditName];
}

/// event to change the audit date
class AddEditAuditDateChanged extends AddEditAuditEvent {
  /// audit date to change
  final DateTime date;
  const AddEditAuditDateChanged({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

/// event to change site
class AddEditAuditSiteChanged extends AddEditAuditEvent {
  /// site to change
  final Site site;
  const AddEditAuditSiteChanged({
    required this.site,
  });

  @override
  List<Object> get props => [site];
}

/// event to change template
class AddEditAuditTemplateChanged extends AddEditAuditEvent {
  /// template to change
  final Template template;
  const AddEditAuditTemplateChanged({required this.template});

  @override
  List<Object> get props => [template];
}

/// event to change companies
class AddEditAuditCompaniesChanged extends AddEditAuditEvent {
  /// companies to change
  final String companies;
  const AddEditAuditCompaniesChanged({
    required this.companies,
  });

  @override
  List<Object> get props => [companies];
}

/// event to change the project
class AddEditAuditProjectChanged extends AddEditAuditEvent {
  final Project project;
  const AddEditAuditProjectChanged({required this.project});

  @override
  List<Object> get props => [project];
}

/// event to change area
class AddEditAuditAreaChanged extends AddEditAuditEvent {
  /// area to change
  final String area;
  const AddEditAuditAreaChanged({
    required this.area,
  });

  @override
  List<Object> get props => [area];
}

/// event to change the inspectors
class AddEditAuditInspectorsChanged extends AddEditAuditEvent {
  /// inspectors to change
  final String inspectors;
  const AddEditAuditInspectorsChanged({
    required this.inspectors,
  });

  @override
  List<Object> get props => [inspectors];
}

/// event to change confirmation view
class AddEditIsWithConfirmationChanged extends AddEditAuditEvent {
  final bool isWithConfirmation;
  const AddEditIsWithConfirmationChanged({
    required this.isWithConfirmation,
  });

  @override
  List<Object> get props => [isWithConfirmation];
}
