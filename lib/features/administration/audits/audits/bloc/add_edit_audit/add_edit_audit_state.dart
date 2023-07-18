// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_audit_bloc.dart';

class AddEditAuditState extends Equatable {
  /// created audit id
  final String? createdAuditId;

  /// loaded audit to fill the form to edit audit
  final Audit? loadedAudit;

  /// site list
  final List<Site> siteList;

  /// template list
  final List<Template> templateList;

  /// project list
  final List<Project> projectList;

  /// audit name to create audit
  final String auditName;

  /// initial audit name to check form dirty
  final String initialAuditName;

  /// validation message for audit name
  final String auditNameValidationMessage;

  /// audit date to create audit
  DateTime? auditDate;

  /// initial audit date to check form dirty
  final DateTime? initialAuditDate;

  /// validation message for audit time
  final String auditDateValidationMessage;

  /// site to create audit
  final Site? site;

  /// initial site to check form dirty
  final Site? initialSite;

  /// validation message for site
  final String siteValidationMessage;

  /// template to create audit
  final Template? template;

  /// initial template to check form dirty
  final Template? initialTemplate;

  /// validation message for template;
  final String templateValidationMessage;

  /// companies with comma separated to create audit
  final String companies;

  /// initial companies to check form dirty
  final String initialCompanies;

  /// validation message for companies
  final String companiesValidationMessage;

  /// project to create audit
  final Project? project;

  /// initial project to check form dirty
  final Project? initialProject;

  /// area to create audit
  final String? area;

  /// initial area to check form dirty
  final String? initialArea;

  /// inspectors to create audit
  final String? inspectors;

  /// validation message for inspectors
  final String inspectorsValidationMessage;

  /// initial inspectors to check form dirty
  final String? initialInspectors;

  /// creation & edition site status
  final EntityStatus status;

  /// response message from server
  final String message;
  AddEditAuditState({
    this.createdAuditId,
    this.loadedAudit,
    this.siteList = const [],
    this.templateList = const [],
    this.projectList = const [],
    this.auditName = '',
    this.initialAuditName = '',
    this.auditNameValidationMessage = '',
    this.auditDate,
    this.initialAuditDate,
    this.auditDateValidationMessage = '',
    this.site,
    this.initialSite,
    this.siteValidationMessage = '',
    this.template,
    this.initialTemplate,
    this.templateValidationMessage = '',
    this.companies = '',
    this.initialCompanies = '',
    this.companiesValidationMessage = '',
    this.project,
    this.initialProject,
    this.area = '',
    this.initialArea = '',
    this.inspectors = '',
    this.initialInspectors = '',
    this.inspectorsValidationMessage = '',
    this.status = EntityStatus.initial,
    this.message = '',
  }) {
    auditDate ??= DateTime.now();
  }

  @override
  List<Object?> get props => [
        createdAuditId,
        loadedAudit,
        siteList,
        templateList,
        projectList,
        auditName,
        initialAuditName,
        auditNameValidationMessage,
        auditDate,
        initialAuditDate,
        auditDateValidationMessage,
        site,
        initialSite,
        siteValidationMessage,
        template,
        initialTemplate,
        templateValidationMessage,
        companies,
        initialCompanies,
        companiesValidationMessage,
        project,
        initialProject,
        area,
        initialArea,
        inspectors,
        initialInspectors,
        inspectorsValidationMessage,
        status,
        message,
      ];

  AuditCreate get audit => AuditCreate(
        name: auditName,
        userId: emptyGuid,
        auditDate: auditDate!.toIso8601String(),
        templateId: template!.id!,
        siteId: site!.id!,
        projectId: project?.id,
        area: area,
        companies: companies,
        inspectors: inspectors,
      );

  bool get formDirty =>
      (Validation.isNotEmpty(auditName) && auditName != initialAuditName) ||
      (Validation.isNotEmpty(companies) && companies != initialCompanies) ||
      (Validation.isNotEmpty(area) && area != initialArea) ||
      (Validation.isNotEmpty(inspectors) && inspectors != initialInspectors) ||
      (auditDate != null && auditDate != initialAuditDate) ||
      (site != null && site?.id != initialSite?.id) ||
      (template != null && template?.id != initialTemplate?.id) ||
      (project != null && project != initialProject);

  AddEditAuditState copyWith({
    String? createdAuditId,
    Audit? loadedAudit,
    List<Site>? siteList,
    List<Template>? templateList,
    List<Project>? projectList,
    String? auditName,
    String? initialAuditName,
    String? auditNameValidationMessage,
    DateTime? auditDate,
    DateTime? initialAuditDate,
    String? auditDateValidationMessage,
    Site? site,
    Site? initialSite,
    String? siteValidationMessage,
    Nullable<Template?>? template,
    Template? initialTemplate,
    String? templateValidationMessage,
    String? companies,
    String? companiesValidationMessage,
    String? initialCompanies,
    Nullable<Project?>? project,
    Project? initialProject,
    String? area,
    String? initialArea,
    String? inspectors,
    String? initialInspectors,
    String? inspectorsValidationMessage,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditAuditState(
      createdAuditId: createdAuditId ?? this.createdAuditId,
      loadedAudit: loadedAudit ?? this.loadedAudit,
      siteList: siteList ?? this.siteList,
      templateList: templateList ?? this.templateList,
      projectList: projectList ?? this.projectList,
      auditName: auditName ?? this.auditName,
      initialAuditName: initialAuditName ?? this.initialAuditName,
      auditNameValidationMessage:
          auditNameValidationMessage ?? this.auditNameValidationMessage,
      auditDate: auditDate ?? this.auditDate,
      initialAuditDate: initialAuditDate ?? this.initialAuditDate,
      auditDateValidationMessage:
          auditDateValidationMessage ?? this.auditDateValidationMessage,
      site: site ?? this.site,
      initialSite: initialSite ?? this.initialSite,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      template: template != null ? template.value : this.template,
      initialTemplate: initialTemplate ?? this.initialTemplate,
      templateValidationMessage:
          templateValidationMessage ?? this.templateValidationMessage,
      companies: companies ?? this.companies,
      companiesValidationMessage:
          companiesValidationMessage ?? this.companiesValidationMessage,
      initialCompanies: initialCompanies ?? this.initialCompanies,
      initialProject: initialProject ?? this.initialProject,
      project: project != null ? project.value : this.project,
      area: area ?? this.area,
      initialArea: initialArea ?? this.initialArea,
      inspectors: inspectors ?? this.inspectors,
      initialInspectors: initialInspectors ?? this.initialInspectors,
      inspectorsValidationMessage:
          inspectorsValidationMessage ?? this.inspectorsValidationMessage,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
