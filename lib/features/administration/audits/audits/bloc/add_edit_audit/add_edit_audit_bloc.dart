import '/common_libraries.dart';

part 'add_edit_audit_event.dart';
part 'add_edit_audit_state.dart';

class AddEditAuditBloc extends Bloc<AddEditAuditEvent, AddEditAuditState> {
  late FormDirtyBloc formDirtyBloc;
  late AuditsRepository auditsRepository;
  late SitesRepository sitesRepository;
  late TemplatesRepository templatesRepository;
  late ProjectsRepository projectsRepository;
  final BuildContext context;
  AddEditAuditBloc(this.context) : super(const AddEditAuditState()) {
    formDirtyBloc = context.read();
    auditsRepository = RepositoryProvider.of(context);
    sitesRepository = RepositoryProvider.of(context);
    templatesRepository = RepositoryProvider.of(context);
    projectsRepository = RepositoryProvider.of(context);

    _bindEvents();
  }

  void _bindEvents() {
    on<AddEditAuditAdded>(_onAddEditAuditAdded);
    on<AddEditAuditEdited>(_onAddEditAuditEdited);
    on<AddEditAuditLoaded>(_onAddEditAuditLoaded);
    on<AddEditAuditSiteListLoaded>(_onAddEditAuditSiteListLoaded);
    on<AddEditAuditSiteTemplateLoaded>(_onAddEditAuditSiteTemplateLoaded);
    on<AddEditAuditProjectListLoaded>(_onAddEditAuditProjectListLoaded);
    on<AddEditAuditNameChanged>(_onAddEditAuditNameChanged);
    on<AddEditAuditDateChanged>(_onAddEditAuditDateChanged);
    on<AddEditAuditSiteChanged>(_onAddEditAuditSiteChanged);
    on<AddEditAuditTemplateChanged>(_onAddEditAuditTemplateChanged);
    on<AddEditAuditCompaniesChanged>(_onAddEditAuditCompaniesChanged);
    on<AddEditAuditProjectChanged>(_onAddEditAuditProjectChanged);
    on<AddEditAuditAreaChanged>(_onAddEditAuditAreaChanged);
    on<AddEditAuditInspectorsChanged>(_onAddEditAuditInspectorsChanged);
  }

  Future<void> _onAddEditAuditAdded(
    AddEditAuditAdded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        Audit audit = await auditsRepository
            .addAudit(state.audit.copyWith(userId: event.userId));

        emit(state.copyWith(
          createdAuditId: audit.id,
          message: 'Audit successfully added.',
          status: EntityStatus.success,
        ));
        // emit(state.copyWith(
        //   auditNameValidationMessage: response.message,
        //   status: EntityStatus.initial,
        // ));
      } catch (e) {
        print(e);
        emit(state.copyWith(
          status: EntityStatus.failure,
          // message: addErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditAuditEdited(
    AddEditAuditEdited event,
    Emitter<AddEditAuditState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        // EntityResponse response = await auditsRepository
        //     .editAudit(state.audit.copyWith(id: event.id));

        // if (response.isSuccess) {
        //   emit(state.copyWith(
        //     initialAuditName: state.auditName,
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

  Future<void> _onAddEditAuditLoaded(
    AddEditAuditLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      Audit audit = await auditsRepository.getAuditById(event.id);

      emit(state.copyWith(
        loadedAudit: audit,
        initialAuditName: audit.name,
        auditName: audit.name,
        auditDate: DateTime.parse(audit.auditDate),
        initialAuditDate: DateTime.parse(audit.auditDate),
      ));
    } catch (e) {}
  }

  bool _checkValidation(Emitter<AddEditAuditState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.auditName)) {
      emit(state.copyWith(
          auditNameValidationMessage:
              FormValidationMessage(fieldName: 'Audit name').requiredMessage));
      success = false;
    }

    if (state.auditDate == null) {
      emit(state.copyWith(
          auditDateValidationMessage:
              FormValidationMessage(fieldName: 'Audit date').requiredMessage));
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

    return success;
  }

  Future<void> _onAddEditAuditSiteListLoaded(
    AddEditAuditSiteListLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      List<Site> siteList = await sitesRepository.getSiteList();
      emit(state.copyWith(siteList: siteList));
    } catch (e) {}
  }

  Future<void> _onAddEditAuditSiteTemplateLoaded(
    AddEditAuditSiteTemplateLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      List<Template> templateList = await templatesRepository.getTemplateList();
      emit(state.copyWith(templateList: templateList));
    } catch (e) {}
  }

  Future<void> _onAddEditAuditProjectListLoaded(
    AddEditAuditProjectListLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      List<Project> projectList = await projectsRepository.getProjectList();
      emit(state.copyWith(projectList: projectList));
    } catch (e) {}
  }

  void _onAddEditAuditNameChanged(
    AddEditAuditNameChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      auditName: event.auditName,
      auditNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditDateChanged(
    AddEditAuditDateChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      auditDate: event.date,
      auditDateValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditSiteChanged(
    AddEditAuditSiteChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      site: event.site,
      siteValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditTemplateChanged(
    AddEditAuditTemplateChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      template: event.template,
      templateValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditCompaniesChanged(
    AddEditAuditCompaniesChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      companies: event.companies,
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditAreaChanged(
    AddEditAuditAreaChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      area: event.area,
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditInspectorsChanged(
    AddEditAuditInspectorsChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      inspectors: event.inspectors,
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditProjectChanged(
    AddEditAuditProjectChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(project: event.project));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }
}
