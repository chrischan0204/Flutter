import 'package:file_picker/file_picker.dart';

import '/common_libraries.dart';

part 'execute_audit_observation_event.dart';
part 'execute_audit_observation_state.dart';

class ExecuteAuditObservationBloc
    extends Bloc<ExecuteAuditObservationEvent, ExecuteAuditObservationState> {
  final BuildContext context;
  final AuditQuestion auditQuestion;

  late ExecuteAuditBloc _executeAuditBloc;
  late FormDirtyBloc _formDirtyBloc;
  late AuthBloc _authBloc;
  late AuditsRepository _auditsRepository;
  late DocumentsRepository _documentsRepository;
  late SitesRepository _sitesRepository;

  late String _questionId;
  late String _auditId;
  ExecuteAuditObservationBloc({
    required this.context,
    required this.auditQuestion,
  }) : super(const ExecuteAuditObservationState()) {
    _executeAuditBloc = context.read();
    _authBloc = context.read();
    _auditsRepository = context.read();
    _documentsRepository = context.read();
    _formDirtyBloc = context.read();
    _sitesRepository = context.read();

    _questionId = auditQuestion.id;

    _auditId = _executeAuditBloc.auditId;

    on<ExecuteAuditObservationListLoaded>(_onExecuteAuditObservationListLoaded);
    on<ExecuteAuditObservationCreated>(_onExecuteAuditObservationCreated);
    on<ExecuteAuditObservationDeleted>(_onExecuteAuditObservationDeleted);
    on<ExecuteAuditObservationViewChanged>(
        _onExecuteAuditObservationViewChanged);
    on<ExecuteAuditObservationLoaded>(_onExecuteAuditObservationLoaded);
    on<ExecuteAuditObservationUpdated>(_onExecuteAuditObservationUpdated);
    on<ExecuteAuditObservationTypeChanged>(
        _onExecuteAuditObservationTypeChanged);
    on<ExecuteAuditObservationPriorityLevelChanged>(
        _onExecuteAuditObservationPriorityLevelChanged);
    on<ExecuteAuditObservationSiteChanged>(
        _onExecuteAuditObservationSiteChanged);
    on<ExecuteAuditObservationNameChanged>(
        _onExecuteAuditObservationNameChanged);
    on<ExecuteAuditObservationResponseChanged>(
        _onExecuteAuditObservationResponseChanged);
    on<ExecuteAuditObservationAreaChanged>(
        _onExecuteAuditObservationAreaChanged);
    on<ExecuteAuditObservationCompanyChanged>(
        _onExecuteAuditObservationCompanyChanged);
    on<ExecuteAuditObservationProjectChanged>(
        _onExecuteAuditObservationProjectChanged);
    on<ExecuteAuditObservationFileListChanged>(
        _onExecuteAuditObservationFileListChanged);
    on<ExecuteAuditObservationImageListLoaded>(
        _onExecuteAuditObservationImageListLoaded);
    on<ExecuteAuditObservationInited>(_onExecuteAuditObservationInited);
    on<ExecuteAuditObservationCreateUpdateCanceled>(
        _onExecuteAuditObservationCreateUpdateCanceled);
  }

  @override
  void onChange(Change<ExecuteAuditObservationState> change) {
    super.onChange(change);
  }

  void _onExecuteAuditObservationCreateUpdateCanceled(
    ExecuteAuditObservationCreateUpdateCanceled event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {}

  Future<void> _onExecuteAuditObservationListLoaded(
    ExecuteAuditObservationListLoaded event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    _formDirtyBloc.add(const FormDirtyChanged(isDirty: false));
    emit(state.copyWith(
      auditObservationListLoadStatus: EntityStatus.loading,
      message: '',
    ));

    try {
      List<ObservationDetail> auditObservationList =
          await _auditsRepository.getAuditObservationList(_questionId);

      emit(state.copyWith(
        auditObservationList: auditObservationList,
        auditObservationListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(
          state.copyWith(auditObservationListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onExecuteAuditObservationLoaded(
    ExecuteAuditObservationLoaded event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    emit(state.copyWith(
      status: EntityStatus.loading,
      message: '',
    ));

    try {
      final auditObservation = await _auditsRepository.getAuditObservationById(
        questionId: _auditId,
        observationId: event.observationId,
      );

      final site = Nullable.value(Site(
        id: auditObservation.userReportedSiteId,
        name: auditObservation.userReportedSiteName,
      ));

      List<CompanySite> companyList = await _sitesRepository
          .getCompanyListForSite(auditObservation.userReportedSiteId!);

      emit(state.copyWith(
        companyList: companyList
            .map((e) => Company(id: e.companyId, name: e.companyName))
            .toList(),
      ));

      List<Project> projectList = await _sitesRepository
          .getProjectListForSite(auditObservation.userReportedSiteId!);

      emit(state.copyWith(projectList: projectList));

      final priorityLevel = Nullable.value(PriorityLevel(
        id: auditObservation.userReportedPriorityLevelId,
        name: auditObservation.userReportedPriorityLevelName,
        colorCode: Colors.white,
        priorityType: '',
      ));

      final observationType = Nullable.value(ObservationType(
        id: auditObservation.userReportedObservationTypeId,
        name: auditObservation.userReportedObservationTypeName,
        severity: '',
      ));

      final project = auditObservation.userReportedProjectId == null
          ? const Nullable.value(null)
          : Nullable.value(Project(
              id: auditObservation.userReportedProjectId,
              name: auditObservation.userReportedProjectName,
            ));

      late Nullable<Company?> company;

      if (auditObservation.userReportedCompanyId == null) {
        company = const Nullable.value(null);
      } else {
        company = Nullable.value(state.companyList.firstWhere(
            (element) => element.id == auditObservation.userReportedCompanyId));
      }

      emit(state.copyWith(
        auditObservation: Nullable.value(auditObservation),
        status: EntityStatus.success,
        initialResponse: auditObservation.response,
        response: auditObservation.response,
        initialArea: auditObservation.area,
        area: auditObservation.area,
        initialObservation: auditObservation.description,
        observation: auditObservation.description,
        initialSite: site,
        site: site,
        initialPriorityLevel: priorityLevel,
        priorityLevel: priorityLevel,
        initialObservationType: observationType,
        observationType: observationType,
        project: project,
        company: company,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  bool _validate(Emitter<ExecuteAuditObservationState> emit) {
    bool valid = true;
    if (Validation.isEmpty(state.observation)) {
      emit(state.copyWith(
          observationValidationMessage:
              FormValidationMessage(fieldName: 'Observation').requiredMessage));

      valid = false;
    }

    if (state.company == null) {
      emit(state.copyWith(
          companyValidationMessage:
              FormValidationMessage(fieldName: 'Company').requiredMessage));

      valid = false;
    }

    if (Validation.isEmpty(state.area)) {
      emit(state.copyWith(
          areaValidationMessage:
              FormValidationMessage(fieldName: 'Area').requiredMessage));

      valid = false;
    }

    if (state.site == null) {
      emit(state.copyWith(
          siteValidationMessage:
              FormValidationMessage(fieldName: 'Site').requiredMessage));

      valid = false;
    }

    if (state.priorityLevel == null) {
      emit(state.copyWith(
          priorityLevelValidationMessage:
              FormValidationMessage(fieldName: 'Priority level')
                  .requiredMessage));

      valid = false;
    }

    if (state.project == null) {
      emit(state.copyWith(
          projectValidationMessage:
              FormValidationMessage(fieldName: 'Project').requiredMessage));

      valid = false;
    }

    if (state.observationType == null) {
      emit(state.copyWith(
          observationTypeValidationMessage:
              FormValidationMessage(fieldName: 'Observation type')
                  .requiredMessage));

      valid = false;
    }

    return valid;
  }

  void _clearForm(Emitter<ExecuteAuditObservationState> emit) {
    emit(state.copyWith(
      observation: '',
      area: '',
      response: '',
      site: const Nullable.value(null),
      priorityLevel: const Nullable.value(null),
      observationType: const Nullable.value(null),
      project: const Nullable.value(null),
      company: const Nullable.value(null),
      fileList: [],
    ));
  }

  Future<void> _onExecuteAuditObservationCreated(
    ExecuteAuditObservationCreated event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(
        status: EntityStatus.loading,
        crudStatus: EntityStatus.loading,
        message: '',
      ));

      try {
        EntityResponse response =
            await _auditsRepository.addObservationForAudit(ObservationCreate(
          name: state.observation,
          siteId: state.site!.id!,
          location: state.area,
          response: state.response,
          priorityLevelId: state.priorityLevel!.id!,
          observationTypeId: state.observationType!.id!,
          auditId: _auditId,
          auditSectionItemId: _questionId,
          reportedBy: _authBloc.state.authUser!.name,
          projectId: state.project!.id!,
          companyId: state.company!.id!,
        ));

        if (state.fileList.isNotEmpty) {
          await _documentsRepository.uploadDocuments(
            ownerId: response.data!.id!,
            ownerType: 'observation',
            documentList: state.fileList,
          );
        }

        emit(state.copyWith(
          status: EntityStatus.success,
          crudStatus: EntityStatus.success,
          message: 'Observation added successfully.',
        ));

        _clearForm(emit);

        add(ExecuteAuditObservationListLoaded());

        add(const ExecuteAuditObservationViewChanged(view: CrudView.list));
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          crudStatus: EntityStatus.failure,
          message: '',
        ));
      }
    }
  }

  Future<void> _onExecuteAuditObservationUpdated(
    ExecuteAuditObservationUpdated event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(
        status: EntityStatus.loading,
        crudStatus: EntityStatus.loading,
        message: '',
      ));

      try {
        await _auditsRepository.editObservationForAudit(
          observationUpdate: ObservationCreate(
            id: state.auditObservation!.id,
            name: state.observation,
            siteId: state.site!.id!,
            location: state.area,
            response: state.response,
            priorityLevelId: state.priorityLevel!.id!,
            observationTypeId: state.observationType!.id!,
            auditId: _auditId,
            auditSectionItemId: _questionId,
            reportedBy: _authBloc.state.authUser!.name,
            companyId: state.company!.id!,
            projectId: state.project!.id!,
          ),
          observationId: state.auditObservation!.id,
        );

        if (state.fileList.isNotEmpty) {
          await _documentsRepository.uploadDocuments(
            ownerId: state.auditObservation!.id,
            ownerType: 'observation',
            documentList: state.fileList,
          );
        }

        emit(state.copyWith(
          crudStatus: EntityStatus.success,
          message: 'Observation updated successfully.',
          initialArea: '',
          initialObservation: '',
          initialObservationType: const Nullable.value(null),
          initialPriorityLevel: const Nullable.value(null),
          initialSite: const Nullable.value(null),
          initialResponse: '',
          initialCompany: const Nullable.value(null),
          initialProject: const Nullable.value(null),
        ));

        emit(state.copyWith(
          status: EntityStatus.success,
          auditObservation: const Nullable.value(null),
        ));

        _clearForm(emit);

        add(ExecuteAuditObservationListLoaded());

        add(const ExecuteAuditObservationViewChanged(view: CrudView.list));
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          crudStatus: EntityStatus.failure,
          message: '',
        ));
      }
    }
  }

  void _onExecuteAuditObservationViewChanged(
    ExecuteAuditObservationViewChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(view: event.view));
  }

  Future<void> _onExecuteAuditObservationDeleted(
    ExecuteAuditObservationDeleted event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    emit(state.copyWith(
      status: EntityStatus.loading,
      crudStatus: EntityStatus.loading,
    ));

    try {
      EntityResponse response = await _auditsRepository.deleteAuditObservation(
        observationId: event.observationId,
        questionId: _questionId,
      );

      if (response.isSuccess) {
        emit(state.copyWith(
          status: EntityStatus.success,
          crudStatus: EntityStatus.success,
          message: 'Observation deleted successfully.',
        ));

        add(ExecuteAuditObservationListLoaded());
      }
    } catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        crudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onExecuteAuditObservationTypeChanged(
    ExecuteAuditObservationTypeChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      observationType: Nullable.value(event.observationType),
      observationTypeValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditObservationPriorityLevelChanged(
    ExecuteAuditObservationPriorityLevelChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      priorityLevel: Nullable.value(event.priorityLevel),
      priorityLevelValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  Future<void> _onExecuteAuditObservationSiteChanged(
    ExecuteAuditObservationSiteChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    if (event.isInit) {
      emit(state.copyWith(initialSite: Nullable.value(event.site)));
    }

    emit(state.copyWith(
      site: Nullable.value(event.site),
      siteValidationMessage: '',
    ));

    List<CompanySite> companyList =
        await _sitesRepository.getCompanyListForSite(event.site.id!);

    emit(state.copyWith(
      companyList: companyList
          .map((e) => Company(id: e.companyId, name: e.companyName))
          .toList(),
      company: const Nullable.value(null),
    ));

    List<Project> projectList =
        await _sitesRepository.getProjectListForSite(event.site.id!);

    emit(state.copyWith(
      projectList: projectList,
      project: const Nullable.value(null),
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditObservationNameChanged(
    ExecuteAuditObservationNameChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      observation: event.observation,
      observationValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditObservationResponseChanged(
    ExecuteAuditObservationResponseChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(response: event.response));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditObservationAreaChanged(
    ExecuteAuditObservationAreaChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      area: event.area,
      areaValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditObservationCompanyChanged(
    ExecuteAuditObservationCompanyChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      company: Nullable.value(event.company),
      companyValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditObservationProjectChanged(
    ExecuteAuditObservationProjectChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      project: Nullable.value(event.project),
      projectValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditObservationFileListChanged(
    ExecuteAuditObservationFileListChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(fileList: event.fileList));
  }

  Future<void> _onExecuteAuditObservationImageListLoaded(
    ExecuteAuditObservationImageListLoaded event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    emit(state.copyWith(imageListLoadStatus: EntityStatus.loading));

    try {
      List<Document> imageList = await _documentsRepository.getDocumentList(
        ownerId: event.observationId,
        ownerType: 'observation',
      );

      emit(state.copyWith(
        imageList: imageList,
        imageListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(imageListLoadStatus: EntityStatus.failure));
    }
  }

  void _onExecuteAuditObservationInited(
    ExecuteAuditObservationInited event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(const ExecuteAuditObservationState());
  }
}
