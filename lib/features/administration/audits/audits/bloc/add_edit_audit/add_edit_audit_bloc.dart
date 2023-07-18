import '/common_libraries.dart';

part 'add_edit_audit_event.dart';
part 'add_edit_audit_state.dart';

class AddEditAuditBloc extends Bloc<AddEditAuditEvent, AddEditAuditState> {
  late FormDirtyBloc _formDirtyBloc;
  late AuditsRepository _auditsRepository;
  late UsersRepository _usersRepository;
  late SitesRepository _sitesRepository;

  final BuildContext context;
  final String? auditId;
  AddEditAuditBloc(this.context, {this.auditId}) : super(AddEditAuditState()) {
    _formDirtyBloc = context.read();
    _auditsRepository = RepositoryProvider.of(context);
    _usersRepository = RepositoryProvider.of(context);
    _sitesRepository = RepositoryProvider.of(context);
    _bindEvents();
  }

  @override
  void onChange(Change<AddEditAuditState> change) {
    final current = change.currentState;
    final next = change.nextState;

    if (current.site?.id != next.site?.id && next.site?.id != null) {
      add(AddEditAuditProjectListLoaded(siteId: next.site!.id!));
      add(AddEditAuditTemplateListLoaded(siteId: next.site!.id!));
    }

    super.onChange(change);
  }

  void _bindEvents() {
    on<AddEditAuditAdded>(_onAddEditAuditAdded);
    on<AddEditAuditEdited>(_onAddEditAuditEdited);
    on<AddEditAuditLoaded>(_onAddEditAuditLoaded);
    on<AddEditAuditSiteListLoaded>(_onAddEditAuditSiteListLoaded);
    on<AddEditAuditTemplateListLoaded>(_onAddEditAuditSiteTemplateLoaded);
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
        EntityResponse response = await _auditsRepository
            .addAudit(state.audit.copyWith(userId: event.userId));

        if (response.isSuccess) {
          emit(state.copyWith(
            createdAuditId: response.data?.id ?? emptyGuid,
            initialArea: state.area,
            initialAuditDate: state.auditDate,
            initialAuditName: state.auditName,
            initialCompanies: state.companies,
            initialInspectors: state.inspectors,
            initialProject: state.project,
            initialSite: state.site,
            initialTemplate: state.template,
            message: 'Audit successfully added.',
            status: EntityStatus.success,
          ));

          _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          if (response.message.contains('already') == true) {
            emit(state.copyWith(
              auditNameValidationMessage: response.message,
              status: EntityStatus.initial,
            ));
          } else {
            emit(state.copyWith(
              status: EntityStatus.failure,
              message: response.message,
            ));
          }
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: ErrorMessage('audit').add,
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
        EntityResponse response = await _auditsRepository
            .editAudit(state.audit.copyWith(id: event.id));

        if (response.isSuccess) {
          emit(state.copyWith(
            initialArea: state.area,
            initialAuditDate: state.auditDate,
            initialAuditName: state.auditName,
            initialCompanies: state.companies,
            initialInspectors: state.inspectors,
            initialProject: state.project,
            initialSite: state.site,
            initialTemplate: state.template,
            message: 'Audit successfully updated.',
            status: EntityStatus.success,
          ));

          _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          if (response.message.contains('already') == true) {
            emit(state.copyWith(
              auditNameValidationMessage: response.message,
              status: EntityStatus.initial,
            ));
          } else {
            emit(state.copyWith(
              status: EntityStatus.failure,
              message: response.message,
            ));
          }
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: ErrorMessage('audit').edit,
        ));
      }
    }
  }

  Future<void> _onAddEditAuditLoaded(
    AddEditAuditLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      Audit audit = await _auditsRepository.getAuditById(event.id);

      final site = Site(id: audit.siteId, name: audit.siteName);

      final project = Project(id: audit.projectId, name: audit.projectName);

      final template = Template(id: audit.templateId, name: audit.templateName);

      emit(state.copyWith(
        loadedAudit: audit,
        initialAuditName: audit.name,
        auditName: audit.name,
        auditDate: audit.auditDate,
        initialAuditDate: audit.auditDate,
        site: site,
        initialSite: site,
        project: Nullable.value(project),
        initialProject: project,
        template: Nullable.value(template),
        initialTemplate: template,
        area: audit.area,
        initialArea: audit.area,
        companies: audit.companies,
        initialCompanies: audit.companies,
        inspectors: audit.inspectors,
        initialInspectors: audit.inspectors,
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
              FormValidationMessage(fieldName: 'Audit Date/Time')
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

    return success;
  }

  Future<void> _onAddEditAuditSiteListLoaded(
    AddEditAuditSiteListLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      List<UserSite> siteList =
          await _usersRepository.getSiteListForUser(event.userId);
      emit(state.copyWith(
        siteList:
            siteList.map((e) => Site(id: e.siteId, name: e.siteName)).toList(),
      ));
    } catch (e) {}
  }

  Future<void> _onAddEditAuditSiteTemplateLoaded(
    AddEditAuditTemplateListLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      List<Template> templateList =
          await _sitesRepository.getTemplateListForSite(event.siteId);
      emit(state.copyWith(templateList: templateList));
    } catch (e) {}
  }

  Future<void> _onAddEditAuditProjectListLoaded(
    AddEditAuditProjectListLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      List<Project> projectList =
          await _sitesRepository.getProjectListForSite(event.siteId);
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

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditDateChanged(
    AddEditAuditDateChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      auditDate: event.date,
      auditDateValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditSiteChanged(
    AddEditAuditSiteChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      site: event.site,
      project: const Nullable.value(null),
      template: const Nullable.value(null),
      siteValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditTemplateChanged(
    AddEditAuditTemplateChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      template: Nullable.value(event.template),
      templateValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditCompaniesChanged(
    AddEditAuditCompaniesChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      companies: event.companies,
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditAreaChanged(
    AddEditAuditAreaChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      area: event.area,
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditInspectorsChanged(
    AddEditAuditInspectorsChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(
      inspectors: event.inspectors,
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAuditProjectChanged(
    AddEditAuditProjectChanged event,
    Emitter<AddEditAuditState> emit,
  ) {
    emit(state.copyWith(project: Nullable.value(event.project)));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }
}
