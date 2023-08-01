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
    on<AddEditIsWithConfirmationChanged>(_onAddEditIsWithConfirmationChanged);
  }

  void _onAddEditIsWithConfirmationChanged(
    AddEditIsWithConfirmationChanged event,
    Emitter<AddEditAuditState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(isWithConfirmation: event.isWithConfirmation));
    }
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

        final now = DateTime.now();

        if (response.isSuccess) {
          emit(state.copyWith(
            createdAuditId: response.data?.id ?? emptyGuid,
            initialArea: '',
            initialAuditDate: now,
            initialAuditName: '',
            initialCompanies: '',
            initialInspectors: '',
            initialProject: const Nullable.value(null),
            initialSite: const Nullable.value(null),
            initialTemplate: const Nullable.value(null),
            loadedAudit: const Nullable.value(null),
            area: '',
            auditDate: now,
            auditName: '',
            companies: '',
            inspectors: '',
            project: const Nullable.value(null),
            site: const Nullable.value(null),
            template: const Nullable.value(null),
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
            initialProject: Nullable.value(state.project),
            initialSite: Nullable.value(state.site),
            initialTemplate: Nullable.value(state.template),
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

      final project = audit.projectId == null
          ? null
          : Project(id: audit.projectId, name: audit.projectName);

      final template = Template(id: audit.templateId, name: audit.templateName);

      emit(state.copyWith(
        loadedAudit: Nullable.value(audit),
        initialAuditName: audit.name,
        auditName: audit.name,
        auditDate: audit.auditDate,
        initialAuditDate: audit.auditDate,
        site: Nullable.value(site),
        initialSite: Nullable.value(site),
        project: Nullable.value(project),
        initialProject: Nullable.value(project),
        template: Nullable.value(template),
        initialTemplate: Nullable.value(template),
        area: audit.area,
        initialArea: audit.area,
        companies: audit.companies,
        initialCompanies: audit.companies,
        inspectors: audit.inspectors,
        initialInspectors: audit.inspectors,
      ));

      add(AddEditAuditSiteListLoaded());
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
      List<UserSite> siteList = await _usersRepository
          .getSiteListForUser(context.read<AuthBloc>().state.authUser!.id);
      emit(state.copyWith(
        siteList:
            siteList.map((e) => Site(id: e.siteId, name: e.siteName)).toList(),
      ));

      if (siteList
          .where((element) => element.siteId == state.loadedAudit?.siteId)
          .isEmpty) {
        emit(state.copyWith(
          site: const Nullable.value(null),
          projectList: [],
          project: const Nullable.value(null),
          template: const Nullable.value(null),
          templateList: [],
        ));
      } else {
        add(AddEditAuditProjectListLoaded(siteId: state.loadedAudit!.siteId));
        add(AddEditAuditTemplateListLoaded(siteId: state.loadedAudit!.siteId));
      }
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
      site: Nullable.value(event.site),
      project: const Nullable.value(null),
      template: const Nullable.value(null),
      siteValidationMessage: '',
    ));

    add(AddEditAuditProjectListLoaded(siteId: event.site.id!));
    add(AddEditAuditTemplateListLoaded(siteId: event.site.id!));

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
