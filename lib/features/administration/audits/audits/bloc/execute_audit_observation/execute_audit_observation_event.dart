// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_observation_bloc.dart';

abstract class ExecuteAuditObservationEvent extends Equatable {
  const ExecuteAuditObservationEvent();

  @override
  List<Object?> get props => [];
}

/// event to load observation list
class ExecuteAuditObservationListLoaded extends ExecuteAuditObservationEvent {}

/// event to create observation on audit execute
class ExecuteAuditObservationCreated extends ExecuteAuditObservationEvent {}

/// event to update observation on audit execute
class ExecuteAuditObservationUpdated extends ExecuteAuditObservationEvent {}

/// event to select observation
class ExecuteAuditObservationSelected extends ExecuteAuditObservationEvent {}

/// event to delete observation by id
class ExecuteAuditObservationDeleted extends ExecuteAuditObservationEvent {
  final String observationId;

  const ExecuteAuditObservationDeleted({
    required this.observationId,
  });

  @override
  List<Object> get props => [observationId];
}

/// event to change view - list, create, update, detail
class ExecuteAuditObservationViewChanged extends ExecuteAuditObservationEvent {
  final CrudView view;

  const ExecuteAuditObservationViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}

/// event to load observation detail
class ExecuteAuditObservationLoaded extends ExecuteAuditObservationEvent {
  final String observationId;

  const ExecuteAuditObservationLoaded({required this.observationId});

  @override
  List<Object> get props => [observationId];
}

/// event to change observation type to create observation
class ExecuteAuditObservationTypeChanged extends ExecuteAuditObservationEvent {
  final ObservationType observationType;

  const ExecuteAuditObservationTypeChanged({
    required this.observationType,
  });

  @override
  List<Object> get props => [observationType];
}

/// event to change priority level to create observation
class ExecuteAuditObservationPriorityLevelChanged
    extends ExecuteAuditObservationEvent {
  final PriorityLevel priorityLevel;

  const ExecuteAuditObservationPriorityLevelChanged({
    required this.priorityLevel,
  });

  @override
  List<Object> get props => [priorityLevel];
}

/// event to change site to create observation
class ExecuteAuditObservationSiteChanged extends ExecuteAuditObservationEvent {
  final Site site;
  final bool isInit;

  const ExecuteAuditObservationSiteChanged({
    required this.site,
    this.isInit = false,
  });

  @override
  List<Object> get props => [
        site,
        isInit,
      ];
}

/// event to change observation name to create observation
class ExecuteAuditObservationNameChanged extends ExecuteAuditObservationEvent {
  final String observation;

  const ExecuteAuditObservationNameChanged({
    required this.observation,
  });

  @override
  List<Object> get props => [observation];
}

/// event to change response to create observation
class ExecuteAuditObservationResponseChanged
    extends ExecuteAuditObservationEvent {
  final String response;

  const ExecuteAuditObservationResponseChanged({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

/// event to change company to create observation
class ExecuteAuditObservationCompanyChanged
    extends ExecuteAuditObservationEvent {
  final Company company;

  const ExecuteAuditObservationCompanyChanged({
    required this.company,
  });

  @override
  List<Object> get props => [company];
}

/// event to change project to create observation
class ExecuteAuditObservationProjectChanged
    extends ExecuteAuditObservationEvent {
  final Project project;

  const ExecuteAuditObservationProjectChanged({
    required this.project,
  });

  @override
  List<Object> get props => [project];
}

/// event to change area to create observation
class ExecuteAuditObservationAreaChanged extends ExecuteAuditObservationEvent {
  final String area;

  const ExecuteAuditObservationAreaChanged({
    required this.area,
  });

  @override
  List<Object> get props => [area];
}

/// event to change observation type to create observation
class ExecuteAuditObservationFileListChanged
    extends ExecuteAuditObservationEvent {
  final List<PlatformFile> fileList;

  const ExecuteAuditObservationFileListChanged({
    required this.fileList,
  });

  @override
  List<Object> get props => [fileList];
}

/// event to change image list to create observation
class ExecuteAuditObservationImageListLoaded
    extends ExecuteAuditObservationEvent {
  final String observationId;

  const ExecuteAuditObservationImageListLoaded({required this.observationId});

  @override
  List<Object> get props => [observationId];
}

/// event to init state
class ExecuteAuditObservationInited extends ExecuteAuditObservationEvent {}

/// event to cancel create or edit mode
class ExecuteAuditObservationCreateUpdateCanceled
    extends ExecuteAuditObservationEvent {}
