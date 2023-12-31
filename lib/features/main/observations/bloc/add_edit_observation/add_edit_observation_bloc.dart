import 'package:file_picker/file_picker.dart';

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
  late DocumentsRepository _documentsRepository;
  final BuildContext context;
  AddEditObservationBloc(this.context)
      : super(const AddEditObservationState()) {
    formDirtyBloc = context.read();
    sitesRepository = RepositoryProvider.of(context);
    observationTypesRepository = RepositoryProvider.of(context);
    priorityLevelsRepository = RepositoryProvider.of(context);
    observationsRepository = RepositoryProvider.of(context);
    _documentsRepository = context.read();
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
    on<AddEditObservationProjectChanged>(_onAddEditObservationProjectChanged);
    on<AddEditObservationCompanyChanged>(_onAddEditObservationCompanyChanged);

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
          if (state.images.isNotEmpty) {
            await _documentsRepository.uploadDocuments(
              ownerId: response.data!.id!,
              ownerType: 'observation',
              documentList: state.images,
            );
          }

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

    if (state.company == null) {
      emit(state.copyWith(
          companyValidationMessage:
              FormValidationMessage(fieldName: 'Company').requiredMessage));
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

    if (state.project == null) {
      emit(state.copyWith(
          projectValidationMessage:
              FormValidationMessage(fieldName: 'Project').requiredMessage));
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
      List<Entity> siteList = await sitesRepository.getActiveSiteList();
      emit(state.copyWith(
          siteList:
              siteList.map((e) => Site(id: e.id, name: e.name)).toList()));
    } catch (e) {}
  }

  Future<void> _onAddEditObservationPriorityLevelListLoaded(
    AddEditObservationPriorityLevelListLoaded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    try {
      List<Entity> priorityLevelList =
          await priorityLevelsRepository.getActivePriorityLevelList();
      emit(state.copyWith(
          priorityLevelList: priorityLevelList
              .map((e) => PriorityLevel(
                    colorCode: Colors.white,
                    priorityType: '',
                    id: e.id,
                    name: e.name,
                  ))
              .toList()));
    } catch (e) {}
  }

  Future<void> _onAddEditObservationObservationTypeListLoaded(
    AddEditObservationObservationTypeListLoaded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    try {
      List<Entity> observationTypeList =
          await observationTypesRepository.getActiveObservationTypeList();
      emit(state.copyWith(
        observationTypeList: observationTypeList
            .map((e) => ObservationType(severity: '', id: e.id, name: e.name))
            .toList(),
      ));
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

  void _onAddEditObservationProjectChanged(
    AddEditObservationProjectChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(
      project: Nullable.value(event.project),
      projectValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationCompanyChanged(
    AddEditObservationCompanyChanged event,
    Emitter<AddEditObservationState> emit,
  ) {
    emit(state.copyWith(
      company: Nullable.value(event.company),
      companyValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  Future<void> _onAddEditObservationSiteChanged(
    AddEditObservationSiteChanged event,
    Emitter<AddEditObservationState> emit,
  ) async {
    emit(state.copyWith(
      site: event.site,
      siteValidationMessage: '',
    ));

    List<Project> projectList =
        await sitesRepository.getProjectListForSite(event.site.id!);

    emit(state.copyWith(
      projectList: projectList,
      project: const Nullable.value(null),
    ));

    List<CompanySite> companyList =
        await sitesRepository.getCompanyListForSite(event.site.id!);

    emit(state.copyWith(
      companyList: companyList
          .map((e) => Company(id: e.companyId, name: e.companyName))
          .toList(),
      company: const Nullable.value(null),
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
