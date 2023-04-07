// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_types_bloc.dart';

class ObservationTypesState extends Equatable {
  final List<ObservationType> observationTypes;
  final ObservationType? selectedObservationType;

  final EntityStatus observationTypesRetrievedStatus;
  final EntityStatus observationTypeSelectedStatus;
  final EntityStatus observationTypeCrudStatus;

  final String message;
  const ObservationTypesState({
    this.observationTypes = const [],
    this.selectedObservationType,
    this.observationTypesRetrievedStatus = EntityStatus.initial,
    this.observationTypeSelectedStatus = EntityStatus.initial,
    this.observationTypeCrudStatus = EntityStatus.initial,
    this.message = '',
  });

  // set the field for equality of observation type
  @override
  List<Object?> get props => [
        observationTypes,
        observationTypesRetrievedStatus,
        selectedObservationType,
        observationTypeSelectedStatus,
        observationTypeCrudStatus,
        message,
      ];

  // return new observation type with updated fields
  ObservationTypesState copyWith({
    List<ObservationType>? observationTypes,
    ObservationType? selectedObservationType,
    EntityStatus? observationTypesRetrievedStatus,
    EntityStatus? observationTypeSelectedStatus,
    EntityStatus? observationTypeCrudStatus,
    String? message,
  }) {
    return ObservationTypesState(
      observationTypes: observationTypes ?? this.observationTypes,
      selectedObservationType:
          selectedObservationType ?? this.selectedObservationType,
      observationTypesRetrievedStatus: observationTypesRetrievedStatus ??
          this.observationTypesRetrievedStatus,
      observationTypeSelectedStatus:
          observationTypeSelectedStatus ?? this.observationTypeSelectedStatus,
      observationTypeCrudStatus:
          observationTypeCrudStatus ?? this.observationTypeCrudStatus,
      message: message ?? this.message,
    );
  }
}
