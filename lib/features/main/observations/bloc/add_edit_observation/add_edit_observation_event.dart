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

/// even to load priority level list
class AddEditObservationPriorityLevelListLoaded extends AddEditObservationEvent {}

/// even to load observation type list
class AddEditObservationObservationTypeListLoaded extends AddEditObservationEvent {}

/// event to change the observation name
class AddEditObservationNameChanged extends AddEditObservationEvent {
  /// observation name to change
  final String observationName;
  const AddEditObservationNameChanged({required this.observationName});

  @override
  List<Object> get props => [observationName];
}

/// event to change the location
class AddEditObservationLocationChanged extends AddEditObservationEvent {
  /// location to change
  final String location;
  const AddEditObservationLocationChanged({required this.location});

  @override
  List<Object> get props => [location];
}

/// event to change the response
class AddEditObservationResponseChanged extends AddEditObservationEvent {
  /// response to change
  final String response;
  const AddEditObservationResponseChanged({required this.response});

  @override
  List<Object> get props => [response];
}

/// event to change the priority level
class AddEditObservationPriorityLevelChanged extends AddEditObservationEvent {
  /// site to priority level
  final PriorityLevel priorityLevel;
  const AddEditObservationPriorityLevelChanged({required this.priorityLevel});

  @override
  List<Object> get props => [priorityLevel];
}

/// event to change the observation
class AddEditObservationObservationTypeChanged extends AddEditObservationEvent {
  /// site to observation type
  final ObservationType observationType;
  const AddEditObservationObservationTypeChanged(
      {required this.observationType});

  @override
  List<Object> get props => [observationType];
}

/// event to change the site
class AddEditObservationSiteChanged extends AddEditObservationEvent {
  /// site to change
  final Site site;
  const AddEditObservationSiteChanged({required this.site});

  @override
  List<Object> get props => [site];
}

/// event to change the image list
class AddEditObservationImageListChanged extends AddEditObservationEvent {
  /// image list to change
  final List<Uint8List> imageList;
  const AddEditObservationImageListChanged({
    required this.imageList,
  });

  @override
  List<Object> get props => [imageList];
}
