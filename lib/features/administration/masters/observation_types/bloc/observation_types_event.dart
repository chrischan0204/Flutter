// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_types_bloc.dart';

abstract class ObservationTypesEvent extends Equatable {
  const ObservationTypesEvent();

  @override
  List<Object> get props => [];
}

class ObservationTypesRetrieved extends ObservationTypesEvent {}

class ObservationTypeSelected extends ObservationTypesEvent {
  final String observationTypeId;
  const ObservationTypeSelected({
    required this.observationTypeId,
  });
  @override
  List<Object> get props => [
        observationTypeId,
      ];
}
