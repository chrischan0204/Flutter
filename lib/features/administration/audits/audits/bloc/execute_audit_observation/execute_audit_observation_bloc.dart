import 'package:file_picker/file_picker.dart';

import '/common_libraries.dart';

part 'execute_audit_observation_event.dart';
part 'execute_audit_observation_state.dart';

class ExecuteAuditObservationBloc
    extends Bloc<ExecuteAuditObservationEvent, ExecuteAuditObservationState> {
  final BuildContext context;
  final AuditQuestion auditQuestion;

  late ExecuteAuditBloc _executeAuditBloc;
  late AuthBloc _authBloc;
  late AuditsRepository _auditsRepository;
  late DocumentsRepository _documentsRepository;

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
    on<ExecuteAuditObservationFileListChanged>(
        _onExecuteAuditObservationFileListChanged);
  }

  Future<void> _onExecuteAuditObservationListLoaded(
    ExecuteAuditObservationListLoaded event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    emit(state.copyWith(auditObservationListLoadStatus: EntityStatus.loading));

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
    emit(state.copyWith(auditObservationLoadStatus: EntityStatus.loading));

    try {
      final auditObservation = await _auditsRepository.getAuditObservationById(
        questionId: _auditId,
        observationId: event.observationId,
      );
      emit(state.copyWith(
        auditObservation: auditObservation,
        auditObservationLoadStatus: EntityStatus.success,
        response: auditObservation.response,
        area: auditObservation.area,
        observation: auditObservation.description,
        site: Nullable.value(Site(
          id: auditObservation.assessmentSiteId,
          name: auditObservation.assessmentSiteName,
        )),
        priorityLevel: Nullable.value(PriorityLevel(
          id: auditObservation.assessmentPriorityLevelId,
          name: auditObservation.assessmentPriorityLevelName,
          colorCode: Colors.white,
          priorityType: '',
        )),
        observationType: Nullable.value(ObservationType(
          id: auditObservation.assessmentObservationTypeId,
          name: auditObservation.assessmentObservationTypeName,
          severity: '',
        )),
      ));
    } catch (e) {
      emit(state.copyWith(auditObservationLoadStatus: EntityStatus.failure));
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
      fileList: [],
    ));
  }

  Future<void> _onExecuteAuditObservationCreated(
    ExecuteAuditObservationCreated event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

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
        ));

        _clearForm(emit);

        add(ExecuteAuditObservationListLoaded());

        add(const ExecuteAuditObservationViewChanged(view: CrudView.list));
      } catch (e) {
        emit(state.copyWith(status: EntityStatus.failure));
      }
    }
  }

  Future<void> _onExecuteAuditObservationUpdated(
    ExecuteAuditObservationUpdated event,
    Emitter<ExecuteAuditObservationState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        await _auditsRepository.editObservationForAudit(
          observationUpdate: ObservationCreate(
            name: state.observation,
            siteId: state.site!.id!,
            location: state.area,
            response: state.response,
            priorityLevelId: state.priorityLevel!.id!,
            observationTypeId: state.observationType!.id!,
            auditId: _auditId,
            auditSectionItemId: _questionId,
            reportedBy: _authBloc.state.authUser!.name,
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
          status: EntityStatus.success,
        ));

        _clearForm(emit);

        add(ExecuteAuditObservationListLoaded());

        add(const ExecuteAuditObservationViewChanged(view: CrudView.list));
      } catch (e) {
        emit(state.copyWith(status: EntityStatus.failure));
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
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      EntityResponse response = await _auditsRepository.deleteAuditObservation(
        observationId: event.observationId,
        questionId: _questionId,
      );

      if (response.isSuccess) {
        emit(state.copyWith(status: EntityStatus.success));

        add(ExecuteAuditObservationListLoaded());
      }
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
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
  }

  void _onExecuteAuditObservationPriorityLevelChanged(
    ExecuteAuditObservationPriorityLevelChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      priorityLevel: Nullable.value(event.priorityLevel),
      priorityLevelValidationMessage: '',
    ));
  }

  void _onExecuteAuditObservationSiteChanged(
    ExecuteAuditObservationSiteChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      site: Nullable.value(event.site),
      siteValidationMessage: '',
    ));
  }

  void _onExecuteAuditObservationNameChanged(
    ExecuteAuditObservationNameChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      observation: event.observation,
      observationValidationMessage: '',
    ));
  }

  void _onExecuteAuditObservationResponseChanged(
    ExecuteAuditObservationResponseChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(response: event.response));
  }

  void _onExecuteAuditObservationAreaChanged(
    ExecuteAuditObservationAreaChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(
      area: event.area,
      areaValidationMessage: '',
    ));
  }

  void _onExecuteAuditObservationFileListChanged(
    ExecuteAuditObservationFileListChanged event,
    Emitter<ExecuteAuditObservationState> emit,
  ) {
    emit(state.copyWith(fileList: event.fileList));
  }
}
