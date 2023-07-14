part of 'execute_audit_observation_bloc.dart';

class ExecuteAuditObservationState extends Equatable {
  final List<ObservationDetail> auditObservationList;
  final EntityStatus auditObservationListLoadStatus;

  final ObservationDetail? auditObservation;
  final EntityStatus auditObservationLoadStatus;

  final EntityStatus status;

  final CrudView view;

  /// fields to create observation
  final Site? site;
  final String siteValidationMessage;

  final ObservationType? observationType;
  final String observationTypeValidationMessage;

  final PriorityLevel? priorityLevel;
  final String priorityLevelValidationMessage;

  final String observation;
  final String observationValidationMessage;

  final String area;
  final String areaValidationMessage;

  final String response;

  final List<PlatformFile> fileList;

  const ExecuteAuditObservationState({
    this.auditObservationList = const [],
    this.auditObservationListLoadStatus = EntityStatus.initial,
    this.auditObservation,
    this.auditObservationLoadStatus = EntityStatus.initial,
    this.status = EntityStatus.initial,
    this.view = CrudView.list,
    this.site,
    this.siteValidationMessage = '',
    this.observationType,
    this.observationTypeValidationMessage = '',
    this.priorityLevel,
    this.priorityLevelValidationMessage = '',
    this.observation = '',
    this.observationValidationMessage = '',
    this.area = '',
    this.areaValidationMessage = '',
    this.response = '',
    this.fileList = const [],
  });

  @override
  List<Object?> get props => [
        auditObservationList,
        auditObservationListLoadStatus,
        auditObservation,
        auditObservationLoadStatus,
        status,
        view,
        site,
        siteValidationMessage,
        observationType,
        observationTypeValidationMessage,
        priorityLevel,
        priorityLevelValidationMessage,
        observation,
        observationValidationMessage,
        area,
        areaValidationMessage,
        response,
        fileList,
      ];

  ExecuteAuditObservationState copyWith({
    List<ObservationDetail>? auditObservationList,
    EntityStatus? auditObservationListLoadStatus,
    ObservationDetail? auditObservation,
    EntityStatus? auditObservationLoadStatus,
    EntityStatus? status,
    CrudView? view,
    Nullable<Site?>? site,
    String? siteValidationMessage,
    Nullable<ObservationType?>? observationType,
    String? observationTypeValidationMessage,
    Nullable<PriorityLevel?>? priorityLevel,
    String? priorityLevelValidationMessage,
    String? observation,
    String? observationValidationMessage,
    String? area,
    String? areaValidationMessage,
    String? response,
    List<PlatformFile>? fileList,
  }) {
    return ExecuteAuditObservationState(
      auditObservationList: auditObservationList ?? this.auditObservationList,
      auditObservationListLoadStatus:
          auditObservationListLoadStatus ?? this.auditObservationListLoadStatus,
      auditObservation: auditObservation ?? this.auditObservation,
      auditObservationLoadStatus:
          auditObservationLoadStatus ?? this.auditObservationLoadStatus,
      status: status ?? this.status,
      view: view ?? this.view,
      site: site != null ? site.value : this.site,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      observationType: observationType != null
          ? observationType.value
          : this.observationType,
      observationTypeValidationMessage: observationTypeValidationMessage ??
          this.observationTypeValidationMessage,
      priorityLevel:
          priorityLevel != null ? priorityLevel.value : this.priorityLevel,
      priorityLevelValidationMessage:
          priorityLevelValidationMessage ?? this.priorityLevelValidationMessage,
      observation: observation ?? this.observation,
      observationValidationMessage:
          observationValidationMessage ?? this.observationValidationMessage,
      area: area ?? this.area,
      areaValidationMessage:
          areaValidationMessage ?? this.areaValidationMessage,
      response: response ?? this.response,
      fileList: fileList ?? this.fileList,
    );
  }
}
