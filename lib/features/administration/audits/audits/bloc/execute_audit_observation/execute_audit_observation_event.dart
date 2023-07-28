// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_observation_bloc.dart';

abstract class ExecuteAuditObservationEvent extends Equatable {
  const ExecuteAuditObservationEvent();

  @override
  List<Object?> get props => [];
}

class ExecuteAuditObservationListLoaded extends ExecuteAuditObservationEvent {}

class ExecuteAuditObservationCreated extends ExecuteAuditObservationEvent {}

class ExecuteAuditObservationUpdated extends ExecuteAuditObservationEvent {}

class ExecuteAuditObservationSelected extends ExecuteAuditObservationEvent {}

class ExecuteAuditObservationDeleted extends ExecuteAuditObservationEvent {
  final String observationId;

  const ExecuteAuditObservationDeleted({
    required this.observationId,
  });

  @override
  List<Object> get props => [observationId];
}

class ExecuteAuditObservationViewChanged extends ExecuteAuditObservationEvent {
  final CrudView view;

  const ExecuteAuditObservationViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}

class ExecuteAuditObservationLoaded extends ExecuteAuditObservationEvent {
  final String observationId;

  const ExecuteAuditObservationLoaded({required this.observationId});

  @override
  List<Object> get props => [observationId];
}

class ExecuteAuditObservationTypeChanged extends ExecuteAuditObservationEvent {
  final ObservationType observationType;

  const ExecuteAuditObservationTypeChanged({
    required this.observationType,
  });

  @override
  List<Object> get props => [observationType];
}

class ExecuteAuditObservationPriorityLevelChanged
    extends ExecuteAuditObservationEvent {
  final PriorityLevel priorityLevel;

  const ExecuteAuditObservationPriorityLevelChanged({
    required this.priorityLevel,
  });

  @override
  List<Object> get props => [priorityLevel];
}

class ExecuteAuditObservationSiteChanged extends ExecuteAuditObservationEvent {
  final Site site;

  const ExecuteAuditObservationSiteChanged({
    required this.site,
  });

  @override
  List<Object> get props => [site];
}

class ExecuteAuditObservationNameChanged extends ExecuteAuditObservationEvent {
  final String observation;

  const ExecuteAuditObservationNameChanged({
    required this.observation,
  });

  @override
  List<Object> get props => [observation];
}

class ExecuteAuditObservationResponseChanged
    extends ExecuteAuditObservationEvent {
  final String response;

  const ExecuteAuditObservationResponseChanged({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class ExecuteAuditObservationAreaChanged extends ExecuteAuditObservationEvent {
  final String area;

  const ExecuteAuditObservationAreaChanged({
    required this.area,
  });

  @override
  List<Object> get props => [area];
}

class ExecuteAuditObservationFileListChanged
    extends ExecuteAuditObservationEvent {
  final List<PlatformFile> fileList;

  const ExecuteAuditObservationFileListChanged({
    required this.fileList,
  });

  @override
  List<Object> get props => [fileList];
}

class ExecuteAuditObservationImageListLoaded
    extends ExecuteAuditObservationEvent {
  final String observationId;

  const ExecuteAuditObservationImageListLoaded({required this.observationId});

  @override
  List<Object> get props => [observationId];
}
