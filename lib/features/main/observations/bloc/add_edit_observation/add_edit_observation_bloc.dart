import 'package:flutter/foundation.dart';

import '/common_libraries.dart';

part 'add_edit_observation_event.dart';
part 'add_edit_observation_state.dart';

class AddEditObservationBloc
    extends Bloc<AddEditObservationEvent, AddEditObservationState> {
  late FormDirtyBloc formDirtyBloc;
  late SitesRepository sitesRepository;
  late ObservationTypesRepository observationTypesRepository;
  late PriorityLevelsRepository priorityLevelsRepository;
  late ObservationsRepository observationsRepository;
  final BuildContext context;
  AddEditObservationBloc(this.context)
      : super(const AddEditObservationState()) {
    formDirtyBloc = context.read();
    sitesRepository = RepositoryProvider.of(context);
    observationTypesRepository = RepositoryProvider.of(context);
    priorityLevelsRepository = RepositoryProvider.of(context);
    observationsRepository = RepositoryProvider.of(context);
    _bindEvents();
  }

  void _bindEvents() {
    on<AddEditObservationAdded>(_onAddEditObservationAdded);
    on<AddEditObservationEdited>(_onAddEditObservationEdited);
    on<AddEditObservationLoaded>(_onAddEditObservationLoaded);

    on<AddEditObservationSiteListLoaded>(_onAddEditObservationSiteListLoaded);
    on<AddEditObservationPriorityLevelListLoaded>(
        _onAddEditObservationPriorityLevelListLoaded);
    on<AddEditObservationObservationTypeListLoaded>(
        _onAddEditObservationObservationTypeListLoaded);
    on<AddEditObservationNameChanged>(_onAddEditObservationNameChanged);
    on<AddEditObservationLocationChanged>(_onAddEditObservationLocationChanged);
    on<AddEditObservationSiteChanged>(_onAddEditObservationSiteChanged);
    on<AddEditObservationResponseChanged>(_onAddEditObservationResponseChanged);
    on<AddEditObservationPriorityLevelChanged>(
        _onAddEditObservationPriorityLevelChanged);

    on<AddEditObservationObservationTypeChanged>(
        _onAddEditObservationObservationTypeChanged);
    on<AddEditObservationImageListChanged>(
        _onAddEditObservationImageListChanged);
  }

  Future<void> _onAddEditObservationAdded(
    AddEditObservationAdded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response =
            await observationsRepository.addObservation(state.observation);

        if (response.isSuccess) {
          emit(state.copyWith(
            createdObservationId: response.data?.id,
            initialLocation: state.location,
            initialObservationName: state.observationName,
            initialObservationType: state.observationType,
            initialPriorityLevel: state.priorityLevel,
            initialResponse: state.response,
            initialSite: state.site,
            initialImages: state.images,
            message: response.message,
            status: EntityStatus.success,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {}
      } catch (e) {
        print(e);
        emit(state.copyWith(
          status: EntityStatus.failure,
          // message: addErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditObservationEdited(
    AddEditObservationEdited event,
    Emitter<AddEditObservationState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        // EntityResponse response = await observationsRepository
        //     .editObservation(state.observation.copyWith(id: event.id));

        // if (response.isSuccess) {
        //   emit(state.copyWith(
        //     initialObservationName: state.observationName,
        //     message: response.message,
        //     status: EntityStatus.success,
        //   ));

        //   formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        // } else {
        //   // _checkMessage(emit, response.message);
        // }
      } catch (e) {
        // emit(state.copyWith(
        //   status: EntityStatus.failure,
        //   message: editErrorMessage,
        // ));
      }
    }
  }

  Future<void> _onAddEditObservationLoaded(
    AddEditObservationLoaded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    try {
      ObservationDetail observation =
          await observationsRepository.getObservationById(event.id);

      emit(state.copyWith(
        loadedObservation: observation,
      ));
    } catch (e) {}
  }

  bool _checkValidation(Emitter<AddEditObservationState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.observationName)) {
      emit(state.copyWith(
          observationNameValidationMessage:
              FormValidationMessage(fieldName: 'Observation').requiredMessage));
      success = false;
    }

    if (Validation.isEmpty(state.location)) {
      emit(state.copyWith(
          locationValidationMessage:
              FormValidationMessage(fieldName: 'Area').requiredMessage));
      success = false;
    }

    if (state.site == null) {
      emit(state.copyWith(
          siteValidationMessage:
              FormValidationMessage(fieldName: 'Site').requiredMessage));
      success = false;
    }

    if (state.priorityLevel == null) {
      emit(state.copyWith(
          priorityLevelValidationMessage:
              FormValidationMessage(fieldName: 'Priority level')
                  .requiredMessage));
      success = false;
    }

    if (state.observationType == null) {
      emit(state.copyWith(
          observationTypeValidationMessage:
              FormValidationMessage(fieldName: 'Observation type')
                  .requiredMessage));
      success = false;
    }

    return success;
  }

  Future<void> _onAddEditObservationSiteListLoaded(
    AddEditObservationSiteListLoaded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    try {
      List<Site> siteList = await sitesRepository.getSiteList();
      emit(state.copyWith(siteList: siteList));
    } catch (e) {}
  }

  Future<void> _onAddEditObservationPriorityLevelListLoaded(
    AddEditObservationPriorityLevelListLoaded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    try {
      List<PriorityLevel> priorityLevelList =
          await priorityLevelsRepository.getPriorityLevelList();
      emit(state.copyWith(priorityLevelList: priorityLevelList));
    } catch (e) {}
  }

  Future<void> _onAddEditObservationObservationTypeListLoaded(
    AddEditObservationObservationTypeListLoaded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    try {
      List<ObservationType> observationTypeList =
          await observationTypesRepository.getObservationTypeList();
      emit(state.copyWith(observationTypeList: observationTypeList));
    } catch (e) {}
  }

  void _onAddEditObservationNameChanged(
    AddEditObservationNameChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(
      observationName: event.observationName,
      observationNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationLocationChanged(
    AddEditObservationLocationChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(
      location: event.location,
      locationValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationResponseChanged(
    AddEditObservationResponseChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(response: event.response));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationSiteChanged(
    AddEditObservationSiteChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(
      site: event.site,
      siteValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationPriorityLevelChanged(
    AddEditObservationPriorityLevelChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(
      priorityLevel: event.priorityLevel,
      priorityLevelValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationObservationTypeChanged(
    AddEditObservationObservationTypeChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(
      observationType: event.observationType,
      observationTypeValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationImageListChanged(
    AddEditObservationImageListChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(images: event.imageList));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }
}
