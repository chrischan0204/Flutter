// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_observation_bloc.dart';

class AddEditObservationState extends Equatable {
  /// created observation id
  final String? createdObservationId;

  /// loaded observation to fill the form to edit observation
  final Observation? loadedObservation;

  /// site list
  final List<Site> siteList;

  /// template list
  final List<Template> templateList;

  /// project list
  final List<Project> projectList;

  /// observation name to create observation
  final String observationName;

  /// initial observation name to check form dirty
  final String initialObservationName;

  /// validation message for observation name
  final String observationNameValidationMessage;

  /// observation date to create observation
  final DateTime? observationDate;

  /// initial observation date to check form dirty
  final DateTime? initialObservationDate;

  /// validation message for observation time
  final String observationDateValidationMessage;

  /// site to create observation
  final Site? site;

  /// initial site to check form dirty
  final Site? initialSite;

  /// validation message for site
  final String siteValidationMessage;

  /// template to create observation
  final Template? template;

  /// initial template to check form dirty
  final Template? initialTemplate;

  /// validation message for template;
  final String templateValidationMessage;

  /// companies with comma separated to create observation
  final String companies;

  /// initial companies to check form dirty
  final String initialCompanies;

  /// observation time to create observation
  final DateTime? observationTime;

  /// initial observation time to check form dirty
  final DateTime? initialObservationTime;

  /// validation message for observation time
  final String observationTimeValidationMessage;

  /// project list to create observation
  final List<Project> selectedProjectList;

  /// initial project list to check form dirty
  final List<Project> initialSelectedProjectList;

  /// area to create observation
  final String? area;

  /// initial area to check form dirty
  final String? initialArea;

  /// inspectors to create observation
  final String? inspectors;

  /// initial inspectors to check form dirty
  final String? initialInspectors;

  /// creation & edition site status
  final EntityStatus status;

  /// response message from server
  final String message;
  const AddEditObservationState({
    this.createdObservationId,
    this.loadedObservation,
    this.siteList = const [],
    this.templateList = const [],
    this.projectList = const [],
    this.observationName = '',
    this.initialObservationName = '',
    this.observationNameValidationMessage = '',
    this.observationDate,
    this.initialObservationDate,
    this.observationDateValidationMessage = '',
    this.site,
    this.initialSite,
    this.siteValidationMessage = '',
    this.template,
    this.initialTemplate,
    this.templateValidationMessage = '',
    this.companies = '',
    this.initialCompanies = '',
    this.observationTime,
    this.initialObservationTime,
    this.observationTimeValidationMessage = '',
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
  List<Object?> get props => [
        createdObservationId,
        loadedObservation,
        siteList,
        templateList,
        projectList,
        observationName,
        initialObservationName,
        observationNameValidationMessage,
        observationDate,
        initialObservationDate,
        site,
        initialSite,
        siteValidationMessage,
        template,
        initialTemplate,
        templateValidationMessage,
        companies,
        initialCompanies,
        observationTime,
        initialObservationTime,
        observationTimeValidationMessage,
        selectedProjectList,
        initialSelectedProjectList,
        area,
        initialArea,
        inspectors,
        initialInspectors,
        status,
        message,
      ];

  Observation get observation => Observation(
        observation: 'observation',
        siteId: 'siteId',
        location: 'location',
        response: 'response',
      );

  bool get formDirty =>
      (Validation.isNotEmpty(observationName) &&
          observationName != initialObservationName) ||
      (Validation.isNotEmpty(companies) && companies != initialCompanies) ||
      (Validation.isNotEmpty(area) && area != initialArea) ||
      (Validation.isNotEmpty(inspectors) && inspectors != initialInspectors) ||
      (observationDate != null && observationDate != initialObservationDate) ||
      (site != null && site?.id != initialSite?.id) ||
      (template != null && template?.id != initialTemplate?.id) ||
      (selectedProjectList.isNotEmpty &&
          selectedProjectList != initialSelectedProjectList) ||
      (observationTime != null && observationTime != initialObservationTime);

  AddEditObservationState copyWith({
    String? createdObservationId,
    Observation? loadedObservation,
    List<Site>? siteList,
    List<Template>? templateList,
    List<Project>? projectList,
    String? observationName,
    String? initialObservationName,
    String? observationNameValidationMessage,
    DateTime? observationDate,
    DateTime? initialObservationDate,
    String? observationDateValidationMessage,
    Site? site,
    Site? initialSite,
    String? siteValidationMessage,
    Template? template,
    Template? initialTemplate,
    String? templateValidationMessage,
    String? companies,
    String? initialCompanies,
    DateTime? observationTime,
    DateTime? initialObservationTime,
    String? observationTimeValidationMessage,
    List<Project>? selectedProjectList,
    List<Project>? initialSelectedProjectList,
    String? area,
    String? initialArea,
    String? inspectors,
    String? initialInspectors,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditObservationState(
      createdObservationId: createdObservationId ?? this.createdObservationId,
      loadedObservation: loadedObservation ?? this.loadedObservation,
      siteList: siteList ?? this.siteList,
      templateList: templateList ?? this.templateList,
      projectList: projectList ?? this.projectList,
      observationName: observationName ?? this.observationName,
      initialObservationName:
          initialObservationName ?? this.initialObservationName,
      observationNameValidationMessage: observationNameValidationMessage ??
          this.observationNameValidationMessage,
      observationDate: observationDate ?? this.observationDate,
      initialObservationDate:
          initialObservationDate ?? this.initialObservationDate,
      observationDateValidationMessage: observationDateValidationMessage ??
          this.observationDateValidationMessage,
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
      observationTime: observationTime ?? this.observationTime,
      initialObservationTime:
          initialObservationTime ?? this.initialObservationTime,
      observationTimeValidationMessage: observationTimeValidationMessage ??
          this.observationTimeValidationMessage,
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
