part of 'add_edit_observation_type_bloc.dart';

abstract class AddEditObservationTypeEvent extends Equatable {
  const AddEditObservationTypeEvent();

  @override
  List<Object> get props => [];
}

class AddEditObservationTypeNameChanged extends AddEditObservationTypeEvent {
  /// observation type name to change
  final String observationTypeName;

  const AddEditObservationTypeNameChanged({
    required this.observationTypeName,
  });

  @override
  List<Object> get props => [observationTypeName];
}

class AddEditObservationTypeSeverityChanged
    extends AddEditObservationTypeEvent {
  /// observation type severity to change
  final String observationTypeSeverity;

  const AddEditObservationTypeSeverityChanged({
    required this.observationTypeSeverity,
  });

  @override
  List<Object> get props => [observationTypeSeverity];
}

class AddEditObservationTypeVisibilityChanged
    extends AddEditObservationTypeEvent {
  /// observation type visibility
  final String observationTypeVisibility;

  const AddEditObservationTypeVisibilityChanged({
    required this.observationTypeVisibility,
  });

  @override
  List<Object> get props => [observationTypeVisibility];
}

class AddEditObservationTypeLoaded extends AddEditObservationTypeEvent {
  /// observation type id to load
  final String observationTypeId;
  const AddEditObservationTypeLoaded({
    required this.observationTypeId,
  });

  @override
  List<Object> get props => [observationTypeId];
}

class AddEditObservationTypeAdded extends AddEditObservationTypeEvent {}

class AddEditObservationTypeEdited extends AddEditObservationTypeEvent {
  /// observation type id to edit
  final String id;
  const AddEditObservationTypeEdited({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class AddEditObservationTypeDeactivatedChanged
    extends AddEditObservationTypeEvent {
  /// deactivated to change
  final bool deactivated;

  const AddEditObservationTypeDeactivatedChanged({required this.deactivated});

  @override
  List<Object> get props => [deactivated];
}
