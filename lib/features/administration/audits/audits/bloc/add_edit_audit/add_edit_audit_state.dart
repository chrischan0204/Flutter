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
  final DateTime? auditDate;

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

  /// audit time to create audit
  final DateTime? auditTime;

  /// initial audit time to check form dirty
  final DateTime? initialAuditTime;

  /// validation message for audit time
  final String auditTimeValidationMessage;

  /// project list to create audit
  final List<Project> selectedProjectList;

  /// initial project list to check form dirty
  final List<Project> initialSelectedProjectList;

  /// area to create audit
  final String? area;

  /// initial area to check form dirty
  final String? initialArea;

  /// inspectors to create audit
  final String? inspectors;

  /// initial inspectors to check form dirty
  final String? initialInspectors;

  /// creation & edition site status
  final EntityStatus status;

  /// response message from server
  final String message;
  const AddEditAuditState({
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
    this.auditTime,
    this.initialAuditTime,
    this.auditTimeValidationMessage = '',
    this.selectedProjectList = const [],
    this.initialSelectedProjectList = const [],
    this.area,
    this.initialArea,
    this.inspectors,
    this.initialInspectors,
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object> get props => [];

  Audit get audit => Audit(
        userId: 'userId',
        auditDate: auditDate.toString(),
        templateId: 'templateId',
        siteId: 'siteId',
      );

  bool get formDirty =>
      (Validation.isNotEmpty(auditName) && auditName != initialAuditName) ||
      (Validation.isNotEmpty(companies) && companies != initialCompanies) ||
      (Validation.isNotEmpty(area) && area != initialArea) ||
      (Validation.isNotEmpty(inspectors) && inspectors != initialInspectors) ||
      (auditDate != null && auditDate != initialAuditDate) ||
      (site != null && site != initialSite) ||
      (template != null && template != initialTemplate) ||
      (selectedProjectList.isNotEmpty &&
          selectedProjectList != initialSelectedProjectList) ||
      (auditTime != null && auditTime != initialAuditTime);

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
    Template? template,
    Template? initialTemplate,
    String? templateValidationMessage,
    String? companies,
    String? initialCompanies,
    DateTime? auditTime,
    DateTime? initialAuditTime,
    String? auditTimeValidationMessage,
    List<Project>? selectedProjectList,
    List<Project>? initialSelectedProjectList,
    String? area,
    String? initialArea,
    String? inspectors,
    String? initialInspectors,
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
      template: template ?? this.template,
      initialTemplate: initialTemplate ?? this.initialTemplate,
      templateValidationMessage:
          templateValidationMessage ?? this.templateValidationMessage,
      companies: companies ?? this.companies,
      initialCompanies: initialCompanies ?? this.initialCompanies,
      auditTime: auditTime ?? this.auditTime,
      initialAuditTime: initialAuditTime ?? this.initialAuditTime,
      auditTimeValidationMessage:
          auditTimeValidationMessage ?? this.auditTimeValidationMessage,
      selectedProjectList: selectedProjectList ?? this.selectedProjectList,
      initialSelectedProjectList:
          initialSelectedProjectList ?? this.initialSelectedProjectList,
      area: area ?? this.area,
      initialArea: initialArea ?? this.initialArea,
      inspectors: inspectors ?? this.inspectors,
      initialInspectors: initialInspectors ?? this.initialInspectors,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
