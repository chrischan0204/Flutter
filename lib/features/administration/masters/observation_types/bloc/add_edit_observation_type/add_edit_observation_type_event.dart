// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}

class AddEditObservationTypeSeverityChanged
    extends AddEditObservationTypeEvent {
  /// observation type severity to change
  final String observationTypeSeverity;

  const AddEditObservationTypeSeverityChanged({
    required this.observationTypeSeverity,
  });
}

class AddEditObservationTypeVisibilityChanged
    extends AddEditObservationTypeEvent {
  /// observation type visibility
  final String observationTypeVisibility;

  const AddEditObservationTypeVisibilityChanged({
    required this.observationTypeVisibility,
  });
}

class AddEditObservationTypeLoaded extends AddEditObservationTypeEvent {
  /// observation type id to load
  final String observationTypeId;
  const AddEditObservationTypeLoaded({
    required this.observationTypeId,
  });
}

class AddEditObservationTypeAdded extends AddEditObservationTypeEvent {}

class AddEditObservationTypeEdited extends AddEditObservationTypeEvent {
  /// observation type id to edit
  final String id;
  const AddEditObservationTypeEdited({
    required this.id,
  });
}

class AddEditObservationTypeDeactivatedChanged extends AddEditObservationTypeEvent {
  /// deactivated to change
  final bool deactivated;

  const AddEditObservationTypeDeactivatedChanged({required this.deactivated});

  @override
  List<Object> get props => [deactivated];
}
