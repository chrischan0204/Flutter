// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_observation_bloc.dart';

abstract class AddEditObservationEvent extends Equatable {
  const AddEditObservationEvent();

  @override
  List<Object> get props => [];
}

/// event to add observation
class AddEditObservationAdded extends AddEditObservationEvent {}

/// event to edit observation
class AddEditObservationEdited extends AddEditObservationEvent {
  /// observation id to edit
  final String id;
  const AddEditObservationEdited({required this.id});

  @override
  List<Object> get props => [id];
}

/// event to load the observation by id
class AddEditObservationLoaded extends AddEditObservationEvent {
  /// observation id to load
  final String id;
  const AddEditObservationLoaded({required this.id});

  @override
  List<Object> get props => [id];
}

/// even to load site list
class AddEditObservationSiteListLoaded extends AddEditObservationEvent {}

/// even to load template list
class AddEditObservationSiteTemplateLoaded extends AddEditObservationEvent {}

/// even to load project list
class AddEditObservationProjectListLoaded extends AddEditObservationEvent {}

/// event to change the observation name
class AddEditObservationNameChanged extends AddEditObservationEvent {
  /// observation name to change
  final String observationName;
  const AddEditObservationNameChanged({required this.observationName});

  @override
  List<Object> get props => [observationName];
}
