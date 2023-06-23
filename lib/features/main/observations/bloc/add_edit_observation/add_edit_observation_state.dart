// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_observation_bloc.dart';

class AddEditObservationState extends Equatable {
  /// created observation id
  final String? createdObservationId;

  /// loaded observation to fill the form to edit observation
  final Observation? loadedObservation;

  /// site list
  final List<Site> siteList;

  /// priority level list
  final List<PriorityLevel> priorityLevelList;

  /// observation type list
  final List<ObservationType> observationTypeList;

  /// observation name to create observation
  final String observationName;

  /// initial observation name to check form dirty
  final String initialObservationName;

  /// validation message for observation name
  final String observationNameValidationMessage;

  /// site to create observation
  final Site? site;

  /// initial site to check form dirty
  final Site? initialSite;

  /// validation message for site
  final String siteValidationMessage;

  /// location to create observation
  final String location;

  /// initial location to check form dirty
  final String initialLocation;

  /// validation message for location
  final String locationValidationMessage;

  /// location to create response
  final String response;

  /// initial response to check form dirty
  final String initialResponse;

  /// priority level to create observation
  final PriorityLevel? priorityLevel;

  /// initial priority level to check form dirty
  final PriorityLevel? initialPriorityLevel;

  /// validation message for priority level
  final String priorityLevelValidationMessage;

  /// observation type to create observation
  final ObservationType? observationType;

  /// initial observation type to check form dirty
  final ObservationType? initialObservationType;

  /// validation message for observation type
  final String observationTypeValidationMessage;

  /// images to create observation
  final List<Uint8List> images;

  /// creation & edition site status
  final EntityStatus status;

  /// response message from server
  final String message;
  const AddEditObservationState({
    this.createdObservationId,
    this.loadedObservation,
    this.siteList = const [],
    this.priorityLevelList = const [],
    this.observationTypeList = const [],
    this.observationName = '',
    this.initialObservationName = '',
    this.observationNameValidationMessage = '',
    this.site,
    this.initialSite,
    this.siteValidationMessage = '',
    this.location = '',
    this.initialLocation = '',
    this.locationValidationMessage = '',
    this.response = '',
    this.initialResponse = '',
    this.priorityLevel,
    this.initialPriorityLevel,
    this.priorityLevelValidationMessage = '',
    this.initialObservationType,
    this.observationType,
    this.observationTypeValidationMessage = '',
    this.images = const [],
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        createdObservationId,
        loadedObservation,
        siteList,
        priorityLevelList,
        observationTypeList,
        observationName,
        initialObservationName,
        observationNameValidationMessage,
        site,
        initialSite,
        siteValidationMessage,
        location,
        initialLocation,
        locationValidationMessage,
        response,
        initialResponse,
        priorityLevel,
        initialPriorityLevel,
        priorityLevelValidationMessage,
        observationType,
        initialObservationType,
        observationTypeValidationMessage,
        images,
        status,
        message,
      ];

  ObservationCreate get observation => ObservationCreate(
        name: observationName,
        siteId: site!.id!,
        location: location,
        response: response,
        priorityLevelId: priorityLevel!.id!,
        observationTypeId: observationType!.id!,
        images: images,
      );

  bool get formDirty =>
      (Validation.isNotEmpty(observationName) &&
          observationName != initialObservationName) ||
      (Validation.isNotEmpty(location) && location != initialLocation) ||
      (Validation.isNotEmpty(response) && response != initialResponse) ||
      (site != null && site?.id != initialSite?.id) ||
      (priorityLevel != null &&
          priorityLevel?.id != initialPriorityLevel?.id) ||
      (observationType != null &&
          observationType?.id != initialObservationType?.id) ||
      (images.isNotEmpty);

  AddEditObservationState copyWith({
    String? createdObservationId,
    Observation? loadedObservation,
    List<Site>? siteList,
    List<PriorityLevel>? priorityLevelList,
    List<ObservationType>? observationTypeList,
    String? observationName,
    String? initialObservationName,
    String? observationNameValidationMessage,
    Site? site,
    Site? initialSite,
    String? siteValidationMessage,
    String? location,
    String? initialLocation,
    String? locationValidationMessage,
    String? response,
    String? initialResponse,
    PriorityLevel? priorityLevel,
    PriorityLevel? initialPriorityLevel,
    String? priorityLevelValidationMessage,
    ObservationType? observationType,
    ObservationType? initialObservationType,
    String? observationTypeValidationMessage,
    List<Uint8List>? images,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditObservationState(
      createdObservationId: createdObservationId ?? this.createdObservationId,
      loadedObservation: loadedObservation ?? this.loadedObservation,
      siteList: siteList ?? this.siteList,
      priorityLevelList: priorityLevelList ?? this.priorityLevelList,
      observationTypeList: observationTypeList ?? this.observationTypeList,
      observationName: observationName ?? this.observationName,
      initialObservationName:
          initialObservationName ?? this.initialObservationName,
      observationNameValidationMessage: observationNameValidationMessage ??
          this.observationNameValidationMessage,
      site: site ?? this.site,
      initialSite: initialSite ?? this.initialSite,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      location: location ?? this.location,
      initialLocation: initialLocation ?? this.initialLocation,
      locationValidationMessage:
          locationValidationMessage ?? this.locationValidationMessage,
      response: response ?? this.response,
      initialResponse: initialResponse ?? this.initialResponse,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      initialPriorityLevel: initialPriorityLevel ?? this.initialPriorityLevel,
      priorityLevelValidationMessage:
          priorityLevelValidationMessage ?? this.priorityLevelValidationMessage,
      observationType: observationType ?? this.observationType,
      initialObservationType:
          initialObservationType ?? this.initialObservationType,
      observationTypeValidationMessage: observationTypeValidationMessage ??
          this.observationTypeValidationMessage,
      images: images ?? this.images,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
