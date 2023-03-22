// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_types_bloc.dart';

class ObservationTypesState extends Equatable {
  final List<ObservationType> observationTypes;
  final EntityStatus observationTypesRetrievedStatus;

  final ObservationType? selectedObservationType;
  final EntityStatus observationTypeSelectedStatus;
  const ObservationTypesState({
    this.observationTypes = const [],
    this.observationTypesRetrievedStatus = EntityStatus.initial,
    this.selectedObservationType,
    this.observationTypeSelectedStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        observationTypes,
        observationTypesRetrievedStatus,
        selectedObservationType,
        observationTypeSelectedStatus
      ];

  ObservationTypesState copyWith({
    List<ObservationType>? observationTypes,
    EntityStatus? observationTypesRetrievedStatus,
    ObservationType? selectedObservationType,
    EntityStatus? observationTypeSelectedStatus,
  }) {
    return ObservationTypesState(
      observationTypes: observationTypes ?? this.observationTypes,
      observationTypesRetrievedStatus: observationTypesRetrievedStatus ??
          this.observationTypesRetrievedStatus,
      selectedObservationType:
          selectedObservationType ?? this.selectedObservationType,
      observationTypeSelectedStatus:
          observationTypeSelectedStatus ?? this.observationTypeSelectedStatus,
    );
  }
}
