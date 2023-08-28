// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_types_bloc.dart';

abstract class ObservationTypesEvent extends Equatable {
  const ObservationTypesEvent();

  @override
  List<Object?> get props => [];
}

/// event to load observation type list
class ObservationTypesLoaded extends ObservationTypesEvent {}

/// event to select observation type
class ObservationTypeSelected extends ObservationTypesEvent {
  final ObservationType? observationType;
  const ObservationTypeSelected({
    this.observationType,
  });
  @override
  List<Object?> get props => [
        observationType,
      ];
}

/// event to select observation type by id
class ObservationTypeSelectedById extends ObservationTypesEvent {
  final String observationTypeId;
  const ObservationTypeSelectedById({
    required this.observationTypeId,
  });
  @override
  List<Object> get props => [
        observationTypeId,
      ];
}

/// event to add new observation type
class ObservationTypeAdded extends ObservationTypesEvent {
  final ObservationType observationType;
  const ObservationTypeAdded({
    required this.observationType,
  });

  @override
  List<Object> get props => [
        observationType,
      ];
}

/// event to edit observation type
class ObservationTypeEdited extends ObservationTypesEvent {
  final ObservationType observationType;
  const ObservationTypeEdited({
    required this.observationType,
  });

  @override
  List<Object> get props => [
        observationType,
      ];
}

/// event to delete observation type
class ObservationTypeDeleted extends ObservationTypesEvent {
  final String observationTypeId;
  const ObservationTypeDeleted({
    required this.observationTypeId,
  });

  @override
  List<Object> get props => [
        observationTypeId,
      ];
}

/// event to init status of observation type
class ObservationTypesStatusInited extends ObservationTypesEvent {
  const ObservationTypesStatusInited();
}
