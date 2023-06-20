import '/common_libraries.dart';

part 'add_edit_observation_event.dart';
part 'add_edit_observation_state.dart';

class AddEditObservationBloc
    extends Bloc<AddEditObservationEvent, AddEditObservationState> {
  late FormDirtyBloc formDirtyBloc;
  late ObservationsRepository observationsRepository;
  late SitesRepository sitesRepository;
  late TemplatesRepository templatesRepository;
  late ProjectsRepository projectsRepository;
  final BuildContext context;
  AddEditObservationBloc(this.context)
      : super(const AddEditObservationState()) {
    formDirtyBloc = context.read();
    observationsRepository = RepositoryProvider.of(context);
    sitesRepository = RepositoryProvider.of(context);
    templatesRepository = RepositoryProvider.of(context);
    projectsRepository = RepositoryProvider.of(context);

    _bindEvents();
  }

  void _bindEvents() {
    on<AddEditObservationAdded>(_onAddEditObservationAdded);
    on<AddEditObservationEdited>(_onAddEditObservationEdited);
    on<AddEditObservationLoaded>(_onAddEditObservationLoaded);
    on<AddEditObservationSiteListLoaded>(_onAddEditObservationSiteListLoaded);
    on<AddEditObservationSiteTemplateLoaded>(
        _onAddEditObservationSiteTemplateLoaded);
    on<AddEditObservationProjectListLoaded>(
        _onAddEditObservationProjectListLoaded);
    on<AddEditObservationNameChanged>(_onAddEditObservationNameChanged);
  }

  Future<void> _onAddEditObservationAdded(
    AddEditObservationAdded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        // EntityResponse response = await observationsRepository.addObservation(state.observation);

        // if (response.isSuccess) {
        //   emit(state.copyWith(
        //     createdObservationId: response.data?.id,
        //     message: response.message,
        //     status: EntityStatus.success,
        //   ));
        // } else {}
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
      Observation observation =
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
              FormValidationMessage(fieldName: 'Observation name')
                  .requiredMessage));
      success = false;
    }

    if (state.observationDate == null) {
      emit(state.copyWith(
          observationDateValidationMessage:
              FormValidationMessage(fieldName: 'Observation date')
                  .requiredMessage));
      success = false;
    }

    if (state.site == null) {
      emit(state.copyWith(
          siteValidationMessage:
              FormValidationMessage(fieldName: 'Site').requiredMessage));
      success = false;
    }

    if (state.template == null) {
      emit(state.copyWith(
          templateValidationMessage:
              FormValidationMessage(fieldName: 'Template').requiredMessage));
      success = false;
    }

    if (state.observationTime == null) {
      emit(state.copyWith(
          templateValidationMessage:
              FormValidationMessage(fieldName: 'Observation time')
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
      List<Site> siteList = await sitesRepository.getSites();
      emit(state.copyWith(siteList: siteList));
    } catch (e) {}
  }

  Future<void> _onAddEditObservationSiteTemplateLoaded(
    AddEditObservationSiteTemplateLoaded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    try {
      List<Template> templateList = await templatesRepository.getTemplateList();
      emit(state.copyWith(templateList: templateList));
    } catch (e) {}
  }

  Future<void> _onAddEditObservationProjectListLoaded(
    AddEditObservationProjectListLoaded event,
    Emitter<AddEditObservationState> emit,
  ) async {
    try {
      List<Project> projectList = await projectsRepository.getProjects();
      emit(state.copyWith(projectList: projectList));
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
}
