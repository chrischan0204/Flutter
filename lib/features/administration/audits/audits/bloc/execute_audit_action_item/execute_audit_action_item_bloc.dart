import 'package:file_picker/file_picker.dart';

import '/common_libraries.dart';

part 'execute_audit_action_item_event.dart';
part 'execute_audit_action_item_state.dart';

class ExecuteAuditActionItemBloc
    extends Bloc<ExecuteAuditActionItemEvent, ExecuteAuditActionItemState> {
  final BuildContext context;
  final AuditQuestion auditQuestion;

  late ExecuteAuditBloc _executeAuditBloc;
  late FormDirtyBloc _formDirtyBloc;
  late ExecuteAuditQuestionBloc _executeAuditQuestionBloc;
  late AuditsRepository _auditsRepository;
  late SitesRepository _sitesRepository;
  late DocumentsRepository _documentsRepository;
  late String _questionId;
  late String _auditId;
  ExecuteAuditActionItemBloc({
    required this.context,
    required this.auditQuestion,
  }) : super(ExecuteAuditActionItemState()) {
    _executeAuditBloc = context.read();
    _executeAuditQuestionBloc = context.read();
    _auditsRepository = context.read();
    _sitesRepository = context.read();
    _documentsRepository = context.read();
    _formDirtyBloc = context.read();

    _questionId = auditQuestion.id;

    _auditId = _executeAuditBloc.auditId;

    on<ExecuteAuditActionItemListLoaded>(_onExecuteAuditActionItemListLoaded);
    on<ExecuteAuditActionItemCreated>(_onExecuteAuditActionItemCreated);
    on<ExecuteAuditActionItemDeleted>(_onExecuteAuditActionItemDeleted);
    on<ExecuteAuditActionItemViewChanged>(_onExecuteAuditActionItemViewChanged);
    on<ExecuteAuditActionItemLoaded>(_onExecuteAuditActionItemLoaded);
    on<ExecuteAuditActionItemUpdated>(_onExecuteAuditActionItemUpdated);

    on<ExecuteAuditActionItemProjectListLoaded>(
        _onExecuteAuditActionItemProjectListLoaded);
    on<ExecuteAuditActionItemCompanyListLoaded>(
        _onExecuteAuditActionItemCompanyListLoaded);

    on<ExecuteAuditActionItemNameChanged>(_onExecuteAuditActionItemNameChanged);
    on<ExecuteAuditActionItemSiteChanged>(_onExecuteAuditActionItemSiteChanged);
    on<ExecuteAuditActionItemAssigneeChanged>(
        _onExecuteAuditActionItemAssigneeChanged);
    on<ExecuteAuditActionItemDueByChanged>(
        _onExecuteAuditActionItemDueByChanged);
    on<ExecuteAuditActionItemCompanyChanged>(
        _onExecuteAuditActionItemCompanyChanged);
    on<ExecuteAuditActionItemCategoryChanged>(
        _onExecuteAuditActionItemCategoryChanged);
    on<ExecuteAuditActionItemProjectChanged>(
        _onExecuteAuditActionItemProjectChanged);
    on<ExecuteAuditActionItemAreaChanged>(_onExecuteAuditActionItemAreaChanged);
    on<ExecuteAuditActionItemNotesChanged>(
        _onExecuteAuditActionItemNotesChanged);
    on<ExecuteAuditActionItemIsClosedChanged>(
        _onExecuteAuditActionItemIsClosedChanged);
    on<ExecuteAuditActionItemFileListChanged>(
        _onExecuteAuditActionItemFileListChanged);
    on<ExecuteAuditActionItemInited>(_onExecuteAuditActionItemInited);
  }

  void _onExecuteAuditActionItemNameChanged(
    ExecuteAuditActionItemNameChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(
      name: event.actionItem,
      nameValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemSiteChanged(
    ExecuteAuditActionItemSiteChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    if (event.isInit) {
      emit(state.copyWith(initialSite: Nullable.value(event.site)));
    }

    emit(state.copyWith(
      site: Nullable.value(event.site),
      siteValidationMessage: '',
      project: const Nullable.value(null),
      company: const Nullable.value(null),
    ));

    add(ExecuteAuditActionItemProjectListLoaded(siteId: event.site.id!));
    add(ExecuteAuditActionItemCompanyListLoaded(siteId: event.site.id!));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemAssigneeChanged(
    ExecuteAuditActionItemAssigneeChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(
      assignee: Nullable.value(event.assignee),
      assigneeValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemDueByChanged(
    ExecuteAuditActionItemDueByChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(
      dueBy: event.dueBy,
      dueByValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemCompanyChanged(
    ExecuteAuditActionItemCompanyChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(company: Nullable.value(event.company)));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemCategoryChanged(
    ExecuteAuditActionItemCategoryChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(category: Nullable.value(event.category)));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemProjectChanged(
    ExecuteAuditActionItemProjectChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(project: Nullable.value(event.project)));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemAreaChanged(
    ExecuteAuditActionItemAreaChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(area: event.area));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemNotesChanged(
    ExecuteAuditActionItemNotesChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(notes: event.notes));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditActionItemIsClosedChanged(
    ExecuteAuditActionItemIsClosedChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(isClosed: event.isClosed));
  }

  void _onExecuteAuditActionItemFileListChanged(
    ExecuteAuditActionItemFileListChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(fileList: event.fileList));
  }

  Future<void> _onExecuteAuditActionItemProjectListLoaded(
    ExecuteAuditActionItemProjectListLoaded event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) async {
    try {
      List<Project> projectList =
          await _sitesRepository.getProjectListForSite(event.siteId);

      emit(state.copyWith(projectList: projectList));
    } catch (e) {}
  }

  Future<void> _onExecuteAuditActionItemCompanyListLoaded(
    ExecuteAuditActionItemCompanyListLoaded event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) async {
    try {
      List<CompanySite> companyList =
          await _sitesRepository.getCompanyListForSite(event.siteId);

      emit(state.copyWith(
          companyList: companyList
              .map((e) => Company(id: e.companyId, name: e.companyName))
              .toList()));
    } catch (e) {}
  }

  Future<void> _onExecuteAuditActionItemListLoaded(
    ExecuteAuditActionItemListLoaded event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) async {
    _formDirtyBloc.add(const FormDirtyChanged(isDirty: false));
    _executeAuditQuestionBloc
        .add(ExecuteAuditQuestionDetailLoaded(questionId: _questionId));

    emit(state.copyWith(auditActionItemListLoadStatus: EntityStatus.loading));

    try {
      List<AuditActionItem> auditActionItemList =
          await _auditsRepository.getAuditActionItemList(_questionId);

      emit(state.copyWith(
        auditActionItemList: auditActionItemList,
        auditActionItemListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(auditActionItemListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onExecuteAuditActionItemLoaded(
    ExecuteAuditActionItemLoaded event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      final auditActionItem = await _auditsRepository.getAuditActionItemById(
        questionId: _questionId,
        actionItemId: event.actionItemId,
      );

      List<Project> projectList =
          await _sitesRepository.getProjectListForSite(auditActionItem.siteId!);

      List<CompanySite> companyList =
          await _sitesRepository.getCompanyListForSite(auditActionItem.siteId!);

      final assignee = Nullable.value(User(
        id: auditActionItem.assigneeId,
        firstName: auditActionItem.assigneeName!.split(' ').first,
        lastName: auditActionItem.assigneeName!.split(' ').last,
      ));

      final site = Nullable.value(Site(
        id: auditActionItem.siteId,
        name: auditActionItem.siteName,
      ));

      final category =
          Nullable.value(auditActionItem.awarenessCategoryId == null
              ? null
              : AwarenessCategory(
                  id: auditActionItem.awarenessCategoryId,
                  name: auditActionItem.awarenessCategoryName,
                ));

      final company = Nullable.value(auditActionItem.companyId == null
          ? null
          : Company(
              id: auditActionItem.companyId,
              name: auditActionItem.companyName,
            ));

      final project = Nullable.value(auditActionItem.projectId == null
          ? null
          : Project(
              id: auditActionItem.projectId,
              name: auditActionItem.projectName,
            ));

      emit(state.copyWith(
        auditActionItem: Nullable.value(auditActionItem),
        companyList: companyList
            .map((e) => Company(
                  id: e.companyId,
                  name: e.companyName,
                ))
            .toList(),
        projectList: projectList,
        status: EntityStatus.success,
        area: auditActionItem.area,
        initialArea: auditActionItem.area,
        name: auditActionItem.description,
        initialName: auditActionItem.description,
        assignee: assignee,
        initialAssignee: assignee,
        dueBy: auditActionItem.dueBy,
        initialDueBy: auditActionItem.dueBy,
        category: category,
        initialCategory: category,
        site: site,
        initialSite: site,
        company: company,
        initialCompany: company,
        project: project,
        initialProject: project,
        initialNotes: auditActionItem.notes,
        notes: auditActionItem.notes,
        isClosed: false,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  void _clearForm(Emitter<ExecuteAuditActionItemState> emit) {
    emit(state.copyWith(
      area: '',
      name: '',
      assignee: const Nullable.value(null),
      dueBy: DateTime.now(),
      category: const Nullable.value(null),
      site: const Nullable.value(null),
      company: const Nullable.value(null),
      project: const Nullable.value(null),
      notes: '',
      fileList: [],
    ));
  }

  bool _validate(Emitter<ExecuteAuditActionItemState> emit) {
    bool valid = true;

    if (Validation.isEmpty(state.name)) {
      emit(state.copyWith(
          nameValidationMessage:
              FormValidationMessage(fieldName: 'Action item').requiredMessage));

      valid = false;
    }

    if (state.site == null) {
      emit(state.copyWith(
          siteValidationMessage:
              FormValidationMessage(fieldName: 'Site').requiredMessage));

      valid = false;
    }

    if (state.assignee == null) {
      emit(state.copyWith(
          assigneeValidationMessage:
              FormValidationMessage(fieldName: 'Assignee').requiredMessage));

      valid = false;
    }

    if (state.dueBy == null) {
      emit(state.copyWith(
          dueByValidationMessage:
              FormValidationMessage(fieldName: 'Due by').requiredMessage));

      valid = false;
    }

    return valid;
  }

  Future<void> _onExecuteAuditActionItemCreated(
    ExecuteAuditActionItemCreated event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) async {
    if (!_validate(emit)) {
      return;
    }
    emit(state.copyWith(
      status: EntityStatus.loading,
      crudStatus: EntityStatus.loading,
    ));

    try {
      EntityResponse response =
          await _auditsRepository.addActionItemForAudit(ActionItemCreate(
        name: state.name,
        dueBy: state.dueBy!.toIso8601String(),
        assigneeId: state.assignee!.id!,
        siteId: state.site!.id!,
        location: state.area,
        notes: state.notes,
        projectId: state.project?.id,
        companyId: state.company?.id,
        categoryId: state.category?.id,
        auditSectionItemId: _questionId,
        auditId: _auditId,
      ));

      if (state.fileList.isNotEmpty) {
        await _documentsRepository.uploadDocuments(
          ownerId: response.data!.id!,
          ownerType: 'actionitem',
          documentList: state.fileList,
        );
      }

      emit(state.copyWith(
        status: EntityStatus.success,
        crudStatus: EntityStatus.success,
        message: 'Action item added successfully.',
      ));

      _clearForm(emit);

      add(ExecuteAuditActionItemListLoaded());

      add(const ExecuteAuditActionItemViewChanged(view: CrudView.list));
    } catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        crudStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onExecuteAuditActionItemUpdated(
    ExecuteAuditActionItemUpdated event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) async {
    if (!_validate(emit)) {
      return;
    }
    emit(state.copyWith(
      status: EntityStatus.loading,
      crudStatus: EntityStatus.loading,
    ));

    try {
      await _auditsRepository.editActionItemForAudit(
        actionItemCreate: ActionItemCreate(
          id: state.auditActionItem!.id,
          name: state.name,
          dueBy: state.dueBy!.toIso8601String(),
          assigneeId: state.assignee!.id!,
          siteId: state.site!.id!,
          location: state.area,
          notes: state.notes,
          projectId: state.project?.id,
          companyId: state.company?.id,
          categoryId: state.category?.id,
          auditSectionItemId: _questionId,
          auditId: _auditId,
          isClosed: state.isClosed,
        ),
        actionItemId: state.auditActionItem!.id,
      );

      if (state.fileList.isNotEmpty) {
        await _documentsRepository.uploadDocuments(
          ownerId: state.auditActionItem!.id,
          ownerType: 'actionitem',
          documentList: state.fileList,
        );
      }

      emit(state.copyWith(
        status: EntityStatus.success,
        auditActionItem: const Nullable.value(null),
        crudStatus: EntityStatus.success,
        message: 'Action item updated successfully.',
      ));

      _clearForm(emit);

      add(ExecuteAuditActionItemListLoaded());

      add(const ExecuteAuditActionItemViewChanged(view: CrudView.list));
    } catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        crudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onExecuteAuditActionItemViewChanged(
    ExecuteAuditActionItemViewChanged event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(state.copyWith(view: event.view));
  }

  Future<void> _onExecuteAuditActionItemDeleted(
    ExecuteAuditActionItemDeleted event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) async {
    emit(state.copyWith(
      status: EntityStatus.loading,
      crudStatus: EntityStatus.loading,
    ));

    try {
      EntityResponse response = await _auditsRepository.deleteAuditActionItem(
        actionItemId: event.actionItemId,
        questionId: _questionId,
      );

      if (response.isSuccess) {
        emit(state.copyWith(
          status: EntityStatus.success,
          crudStatus: EntityStatus.success,
          message: 'Action item deleted successfully.',
        ));

        add(ExecuteAuditActionItemListLoaded());
      }
    } catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        crudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onExecuteAuditActionItemInited(
    ExecuteAuditActionItemInited event,
    Emitter<ExecuteAuditActionItemState> emit,
  ) {
    emit(ExecuteAuditActionItemState());
  }
}
