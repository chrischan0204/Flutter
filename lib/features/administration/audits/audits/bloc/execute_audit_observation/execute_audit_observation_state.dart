part of 'execute_audit_observation_bloc.dart';

class ExecuteAuditObservationState extends Equatable {
  final List<ObservationDetail> auditObservationList;
  final EntityStatus auditObservationListLoadStatus;

  final ObservationDetail? auditObservation;
  final EntityStatus auditObservationLoadStatus;

  final EntityStatus status;

  final CrudView view;

  /// fields to create observation
  final Site? initialSite;
  final Site? site;
  final String siteValidationMessage;

  final ObservationType? observationType;
  final ObservationType? initialObservationType;
  final String observationTypeValidationMessage;

  final PriorityLevel? initialPriorityLevel;
  final PriorityLevel? priorityLevel;
  final String priorityLevelValidationMessage;

  final String initialObservation;
  final String observation;
  final String observationValidationMessage;

  final String initialArea;
  final String area;
  final String areaValidationMessage;

  final String initialResponse;
  final String response;

  final Company? company;
  final Company? initialCompany;
  final String companyValidationMessage;

  final Project? project;
  final Project? initialProject;
  final String projectValidationMessage;

  final List<PlatformFile> fileList;

  final List<Document> imageList;

  final List<Project> projectList;

  final List<Company> companyList;

  final EntityStatus imageListLoadStatus;

  final EntityStatus crudStatus;
  final String message;

  const ExecuteAuditObservationState({
    this.auditObservationList = const [],
    this.auditObservationListLoadStatus = EntityStatus.initial,
    this.auditObservation,
    this.auditObservationLoadStatus = EntityStatus.initial,
    this.status = EntityStatus.initial,
    this.view = CrudView.list,
    this.initialSite,
    this.site,
    this.siteValidationMessage = '',
    this.initialObservationType,
    this.observationType,
    this.observationTypeValidationMessage = '',
    this.initialPriorityLevel,
    this.priorityLevel,
    this.priorityLevelValidationMessage = '',
    this.initialObservation = '',
    this.observation = '',
    this.observationValidationMessage = '',
    this.initialArea = '',
    this.area = '',
    this.areaValidationMessage = '',
    this.initialResponse = '',
    this.response = '',
    this.project,
    this.initialProject,
    this.projectValidationMessage = '',
    this.company,
    this.initialCompany,
    this.companyValidationMessage = '',
    this.fileList = const [],
    this.imageList = const [],
    this.projectList = const [],
    this.companyList = const [],
    this.imageListLoadStatus = EntityStatus.initial,
    this.crudStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        auditObservationList,
        auditObservationListLoadStatus,
        auditObservation,
        auditObservationLoadStatus,
        status,
        view,
        initialSite,
        site,
        siteValidationMessage,
        initialObservationType,
        observationType,
        observationTypeValidationMessage,
        initialPriorityLevel,
        priorityLevel,
        priorityLevelValidationMessage,
        initialObservation,
        observation,
        observationValidationMessage,
        initialArea,
        area,
        areaValidationMessage,
        initialResponse,
        response,
        project,
        projectValidationMessage,
        initialProject,
        company,
        initialCompany,
        companyValidationMessage,
        fileList,
        imageList,
        imageListLoadStatus,
        crudStatus,
        projectList,
        companyList,
        message,
      ];

  bool get isDirty =>
      (site != null && site?.id != initialSite?.id) ||
      (observationType != null &&
          observationType?.id != initialObservationType?.id) ||
      (priorityLevel != null &&
          priorityLevel?.id != initialPriorityLevel?.id) ||
      (project != null && project?.id != initialProject?.id) ||
      (company != null && company?.id != initialCompany?.id) ||
      (Validation.isNotEmpty(observation) &&
          observation != initialObservation) ||
      (Validation.isNotEmpty(response) && response != initialResponse) ||
      (Validation.isNotEmpty(area) && area != initialArea);

  ExecuteAuditObservationState copyWith({
    List<ObservationDetail>? auditObservationList,
    EntityStatus? auditObservationListLoadStatus,
    Nullable<ObservationDetail?>? auditObservation,
    EntityStatus? auditObservationLoadStatus,
    EntityStatus? status,
    CrudView? view,
    Nullable<Site?>? initialSite,
    Nullable<Site?>? site,
    String? siteValidationMessage,
    Nullable<ObservationType?>? initialObservationType,
    Nullable<ObservationType?>? observationType,
    String? observationTypeValidationMessage,
    Nullable<PriorityLevel?>? initialPriorityLevel,
    Nullable<PriorityLevel?>? priorityLevel,
    String? priorityLevelValidationMessage,
    Nullable<Project?>? initialProject,
    Nullable<Project?>? project,
    String? projectValidationMessage,
    Nullable<Company?>? initialCompany,
    Nullable<Company?>? company,
    String? companyValidationMessage,
    String? initialObservation,
    String? observation,
    String? observationValidationMessage,
    String? initialArea,
    String? area,
    String? areaValidationMessage,
    String? initialResponse,
    String? response,
    List<PlatformFile>? fileList,
    List<Document>? imageList,
    List<Project>? projectList,
    List<Company>? companyList,
    EntityStatus? imageListLoadStatus,
    EntityStatus? crudStatus,
    String? message,
  }) {
    return ExecuteAuditObservationState(
      auditObservationList: auditObservationList ?? this.auditObservationList,
      auditObservationListLoadStatus:
          auditObservationListLoadStatus ?? this.auditObservationListLoadStatus,
      auditObservation: auditObservation != null
          ? auditObservation.value
          : this.auditObservation,
      auditObservationLoadStatus:
          auditObservationLoadStatus ?? this.auditObservationLoadStatus,
      status: status ?? this.status,
      view: view ?? this.view,
      initialSite: initialSite != null ? initialSite.value : this.initialSite,
      site: site != null ? site.value : this.site,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      initialObservationType: initialObservationType != null
          ? initialObservationType.value
          : this.initialObservationType,
      observationType: observationType != null
          ? observationType.value
          : this.observationType,
      observationTypeValidationMessage: observationTypeValidationMessage ??
          this.observationTypeValidationMessage,
      initialPriorityLevel: initialPriorityLevel != null
          ? initialPriorityLevel.value
          : this.initialPriorityLevel,
      priorityLevel:
          priorityLevel != null ? priorityLevel.value : this.priorityLevel,
      priorityLevelValidationMessage:
          priorityLevelValidationMessage ?? this.priorityLevelValidationMessage,
      observation: observation ?? this.observation,
      initialObservation: initialObservation ?? this.initialObservation,
      observationValidationMessage:
          observationValidationMessage ?? this.observationValidationMessage,
      company: company != null ? company.value : this.company,
      initialCompany:
          initialCompany != null ? initialCompany.value : this.initialCompany,
      companyValidationMessage:
          companyValidationMessage ?? this.companyValidationMessage,
      project: project != null ? project.value : this.project,
      initialProject:
          initialProject != null ? initialProject.value : this.initialProject,
      projectValidationMessage:
          projectValidationMessage ?? this.projectValidationMessage,
      initialArea: initialArea ?? this.initialArea,
      area: area ?? this.area,
      areaValidationMessage:
          areaValidationMessage ?? this.areaValidationMessage,
      response: response ?? this.response,
      initialResponse: initialResponse ?? this.initialResponse,
      fileList: fileList ?? this.fileList,
      imageList: imageList ?? this.imageList,
      imageListLoadStatus: imageListLoadStatus ?? this.imageListLoadStatus,
      projectList: projectList ?? this.projectList,
      companyList: companyList ?? this.companyList,
      crudStatus: crudStatus ?? this.crudStatus,
      message: message ?? this.message,
    );
  }
}
