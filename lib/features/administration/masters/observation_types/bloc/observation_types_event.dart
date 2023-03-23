// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_types_bloc.dart';

abstract class ObservationTypesEvent extends Equatable {
  const ObservationTypesEvent();

  @override
  List<Object> get props => [];
}

class ObservationTypesRetrieved extends ObservationTypesEvent {}

class ObservationTypeSelected extends ObservationTypesEvent {
  final ObservationType observationType;
  const ObservationTypeSelected({
    required this.observationType,
  });
  @override
  List<Object> get props => [
        observationType,
      ];
}

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
