import '/common_libraries.dart';

part 'add_edit_project_event.dart';
part 'add_edit_project_state.dart';

class AddEditProjectBloc
    extends Bloc<AddEditProjectEvent, AddEditProjectState> {
  final FormDirtyBloc formDirtyBloc;
  final ProjectsRepository projectsRepository;
  final SitesRepository sitesRepository;

  static String addErrorMessage =
      'There was an error while adding project. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing project. Our team has been notified. Please wait a few minutes and try again.';
  AddEditProjectBloc({
    required this.formDirtyBloc,
    required this.projectsRepository,
    required this.sitesRepository,
  }) : super(const AddEditProjectState()) {
    on<AddEditProjectAdded>(_onAddEditProjectAdded);
    on<AddEditProjectEdited>(_onAddEditProjectEdited);
    on<AddEditProjectLoaded>(_onAddEditProjectLoaded);
    on<AddEditProjectSiteListLoaded>(_onAddEditProjectSiteListLoaded);
    on<AddEditProjectNameChanged>(_onAddEditProjectNameChanged);
    on<AddEditProjecSiteChanged>(_onAddEditProjecSiteChanged);
    on<AddEditProjectReferenceNumberChanged>(
        _onAddEditProjectReferenceNumberChanged);
    on<AddEditProjectReferenceNameChanged>(
        _onAddEditProjectReferenceNameChanged);
  }

  void _onAddEditProjectNameChanged(
    AddEditProjectNameChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      projectName: event.name,
      projectNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditProjecSiteChanged(
    AddEditProjecSiteChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      site: event.site,
      siteValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditProjectReferenceNumberChanged(
    AddEditProjectReferenceNumberChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      referenceNumber: event.referenceNumber,
      referenceNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditProjectReferenceNameChanged(
    AddEditProjectReferenceNameChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      referenceName: event.referenceName,
      referenceNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  Future<void> _onAddEditProjectAdded(
    AddEditProjectAdded event,
    Emitter<AddEditProjectState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await projectsRepository.addProject(Project(
          name: state.projectName,
          siteId: state.site!.id!,
          referenceNumber: state.referenceNumber,
          referneceName: state.referenceName,
        ));

        if (response.isSuccess) {
          emit(state.copyWith(
            createdProjectId: response.data?.id,
            message: response.message,
            status: EntityStatus.success,
          ));
        } else {
          _checkMessage(emit, response.message);
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: addErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditProjectEdited(
    AddEditProjectEdited event,
    Emitter<AddEditProjectState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await projectsRepository.editProject(Project(
          id: event.id,
          name: state.projectName,
          siteId: state.site!.id!,
          referenceNumber: state.referenceNumber,
          referneceName: state.referenceName,
        ));

        if (response.isSuccess) {
          emit(state.copyWith(
            initialProjectName: state.projectName,
            initialSite: state.site,
            initialReferenceName: state.referenceName,
            initialReferenceNumber: state.referenceNumber,
            message: response.message,
            status: EntityStatus.success,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          _checkMessage(emit, response.message);
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: editErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditProjectSiteListLoaded(
    AddEditProjectSiteListLoaded event,
    Emitter<AddEditProjectState> emit,
  ) async {
    try {
      List<Site> siteList = await sitesRepository.getSites();

      emit(state.copyWith(siteList: siteList));
    } catch (e) {}
  }

  Future<void> _onAddEditProjectLoaded(
    AddEditProjectLoaded event,
    Emitter<AddEditProjectState> emit,
  ) async {
    try {
      Project project = await projectsRepository.getProjectById(event.id);

      emit(state.copyWith(
        loadedProject: project,
        initialProjectName: project.name,
        initialSite: Site(id: project.siteId, name: project.siteName),
        initialReferenceName: project.referneceName,
        initialReferenceNumber: project.referenceNumber,
        projectName: project.name,
        site: Site(id: project.siteId, name: project.siteName),
        referenceName: project.referneceName,
        referenceNumber: project.referenceNumber,
      ));
    } catch (e) {}
  }

  /// check response message
  void _checkMessage(Emitter<AddEditProjectState> emit, String message) {
    emit(state.copyWith(
      status: EntityStatus.initial,
      siteValidationMessage: '',
      projectNameValidationMessage: message,
      referenceNameValidationMessage: '',
      refereneceNumberValidationMessage: '',
    ));
  }

  /// validate form
  bool _checkValidation(Emitter<AddEditProjectState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.projectName)) {
      emit(state.copyWith(
          projectNameValidationMessage:
              'Project name is required and cannot be blank.'));
      success = false;
    } else if (Validation.isNotEmpty(state.projectName) &&
        !Validation.isAlphanumbericWithSpecialChars(state.projectName)) {
      emit(state.copyWith(
          projectNameValidationMessage:
              'Project name should be alphanumeric with allow special char.'));
      success = false;
    } else if (state.projectName.length >
        ProjectFormValidation.projectNameMaxLength) {
      emit(state.copyWith(
          projectNameValidationMessage:
              'Project name can be ${ProjectFormValidation.projectNameMaxLength} long at maximum.'));
      success = false;
    }

    if (state.site == null) {
      emit(state.copyWith(siteValidationMessage: 'Site is required.'));
      success = false;
    }

    if (Validation.isNotEmpty(state.referenceName) &&
        !Validation.isAlphanumbericWithSpecialChars(state.referenceName)) {
      emit(state.copyWith(
          referenceNameValidationMessage:
              'Reference name should be alphanumeric with allow special char.'));
      success = false;
    } else if (state.referenceName.length >
        ProjectFormValidation.referenceNameMaxLength) {
      emit(state.copyWith(
          referenceNameValidationMessage:
              'Reference name can be ${ProjectFormValidation.referenceNameMaxLength} long at maximum.'));
      success = false;
    }

    if (Validation.isNotEmpty(state.referenceNumber) &&
        !Validation.isAlphanumbericWithSpecialChars(state.referenceNumber)) {
      emit(state.copyWith(
          refereneceNumberValidationMessage:
              'Reference number should be alphanumeric with allow special char.'));
      success = false;
    } else if (state.referenceNumber.length >
        ProjectFormValidation.referneceNumberMaxLength) {
      emit(state.copyWith(
          refereneceNumberValidationMessage:
              'Reference number can be ${ProjectFormValidation.referneceNumberMaxLength} long at maximum.'));
      success = false;
    }

    return success;
  }
}
