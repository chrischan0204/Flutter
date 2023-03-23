// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_types_bloc.dart';

class ObservationTypesState extends Equatable {
  final List<ObservationType> observationTypes;
  final ObservationType? selectedObservationType;

  final EntityStatus observationTypesRetrievedStatus;
  final EntityStatus observationTypeSelectedStatus;
  final EntityStatus observationTypeAddedStatus;
  final EntityStatus observationTypeEditedStatus;
  final EntityStatus observationTypeDeletedStatus;
  const ObservationTypesState({
    this.observationTypes = const [],
    this.observationTypesRetrievedStatus = EntityStatus.initial,
    this.selectedObservationType,
    this.observationTypeSelectedStatus = EntityStatus.initial,
    this.observationTypeAddedStatus = EntityStatus.initial,
    this.observationTypeEditedStatus = EntityStatus.initial,
    this.observationTypeDeletedStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        observationTypes,
        observationTypesRetrievedStatus,
        selectedObservationType,
        observationTypeSelectedStatus,
        observationTypeAddedStatus,
        observationTypeEditedStatus,
        observationTypeDeletedStatus,
      ];

  ObservationTypesState copyWith({
    List<ObservationType>? observationTypes,
    ObservationType? selectedObservationType,
    EntityStatus? observationTypesRetrievedStatus,
    EntityStatus? observationTypeSelectedStatus,
    EntityStatus? observationTypeAddedStatus,
    EntityStatus? observationTypeEditedStatus,
    EntityStatus? observationTypeDeletedStatus,
  }) {
    return ObservationTypesState(
      observationTypes: observationTypes ?? this.observationTypes,
      selectedObservationType:
          selectedObservationType ?? this.selectedObservationType,
      observationTypesRetrievedStatus: observationTypesRetrievedStatus ??
          this.observationTypesRetrievedStatus,
      observationTypeSelectedStatus:
          observationTypeSelectedStatus ?? this.observationTypeSelectedStatus,
      observationTypeAddedStatus:
          observationTypeAddedStatus ?? this.observationTypeAddedStatus,
      observationTypeEditedStatus:
          observationTypeEditedStatus ?? this.observationTypeEditedStatus,
      observationTypeDeletedStatus:
          observationTypeDeletedStatus ?? this.observationTypeDeletedStatus,
    );
  }
}
