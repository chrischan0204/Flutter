import '/common_libraries.dart';

part 'add_edit_action_item_event.dart';
part 'add_edit_action_item_state.dart';

class AddEditActionItemBloc
    extends Bloc<AddEditActionItemEvent, AddEditActionItemState> {
  final BuildContext context;
  late SitesRepository _sitesRepository;
  late AwarenessCategoriesRepository _awarenessCategoriesRepository;
  late UsersRepository _usersRepository;
  late ActionItemsRepository _actionItemsRepository;
  late FormDirtyBloc _formDirtyBloc;
  late AuthBloc _authBloc;
  AddEditActionItemBloc(this.context) : super(AddEditActionItemState()) {
    _sitesRepository = RepositoryProvider.of(context);
    _awarenessCategoriesRepository = RepositoryProvider.of(context);
    _usersRepository = RepositoryProvider.of(context);
    _actionItemsRepository = RepositoryProvider.of(context);

    _formDirtyBloc = context.read();
    _authBloc = context.read();

    on<AddEditActionItemCompanyListLoaded>(
        _onAddEditActionItemCompanyListLoaded);
    on<AddEditActionItemSiteListLoaded>(_onAddEditActionItemSiteListLoaded);
    on<AddEditActionItemProjectListLoaded>(
        _onAddEditActionItemProjectListLoaded);
    on<AddEditActionItemAwarenessCategoryListLoaded>(
        _onAddEditActionItemAwarenessCategoryListLoaded);
    on<AddEditActionItemUserListLoaded>(_onAddEditActionItemUserListLoaded);

    on<AddEditActionItemNameChanged>(_onAddEditActionItemNameChanged);
    on<AddEditActionItemSiteChanged>(_onAddEditActionItemSiteChanged);
    on<AddEditActionItemDueByChanged>(_onAddEditActionItemDueByChanged);
    on<AddEditActionItemAssigneeChanged>(_onAddEditActionItemAssigneeChanged);
    on<AddEditActionItemCategoryChanged>(_onAddEditActionItemCategoryChanged);
    on<AddEditActionItemCompanyChanged>(_onAddEditActionItemCompanyChanged);
    on<AddEditActionItemProjectChanged>(_onAddEditActionItemProjectChanged);
    on<AddEditActionItemLocationChanged>(_onAddEditActionItemLocationChanged);
    on<AddEditActionItemNotesChanged>(_onAddEditActionItemNotesChanged);

    on<AddEditActionItemLoaded>(_onAddEditActionItemLoaded);
    on<AddEditActionItemAdded>(_onAddEditActionItemAdded);
    on<AddEditActionItemEdited>(_onAddEditActionItemEdited);
  }

  Future<void> _onAddEditActionItemAwarenessCategoryListLoaded(
    AddEditActionItemAwarenessCategoryListLoaded event,
    Emitter<AddEditActionItemState> emit,
  ) async {
    try {
      List<AwarenessCategory> awarenessCategoryList =
          await _awarenessCategoriesRepository.getAwarenessCategorieList();

      emit(state.copyWith(awarenessCategoryList: awarenessCategoryList));
    } catch (e) {}
  }

  Future<void> _onAddEditActionItemSiteListLoaded(
    AddEditActionItemSiteListLoaded event,
    Emitter<AddEditActionItemState> emit,
  ) async {
    try {
      List<UserSite> siteList = await _usersRepository
          .getSiteListForUser(_authBloc.state.authUser!.id);

      emit(state.copyWith(
          siteList: siteList
              .map((e) => Site(
                    id: e.siteId,
                    name: e.siteName,
                  ))
              .toList()));
    } catch (e) {}
  }

  Future<void> _onAddEditActionItemCompanyListLoaded(
    AddEditActionItemCompanyListLoaded event,
    Emitter<AddEditActionItemState> emit,
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

  Future<void> _onAddEditActionItemProjectListLoaded(
    AddEditActionItemProjectListLoaded event,
    Emitter<AddEditActionItemState> emit,
  ) async {
    try {
      List<Project> projectList =
          await _sitesRepository.getProjectListForSite(event.siteId);

      emit(state.copyWith(projectList: projectList));
    } catch (e) {}
  }

  Future<void> _onAddEditActionItemUserListLoaded(
    AddEditActionItemUserListLoaded event,
    Emitter<AddEditActionItemState> emit,
  ) async {
    try {
      List<Entity> userList =
          await _sitesRepository.getUserListForSite(event.siteId);

      emit(state.copyWith(userList: userList));
    } catch (e) {}
  }

  void _onAddEditActionItemNameChanged(
    AddEditActionItemNameChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      nameValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditActionItemSiteChanged(
    AddEditActionItemSiteChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(
      site: Nullable.value(event.site),
      assignee: const Nullable.value(null),
      project: const Nullable.value(null),
      company: const Nullable.value(null),
      siteValidationMessage: '',
    ));

    add(AddEditActionItemUserListLoaded(siteId: event.site.id!));
    add(AddEditActionItemProjectListLoaded(siteId: event.site.id!));
    add(AddEditActionItemCompanyListLoaded(siteId: event.site.id!));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditActionItemDueByChanged(
    AddEditActionItemDueByChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(
      dueBy: Nullable.value(event.dueBy),
      dueByValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditActionItemAssigneeChanged(
    AddEditActionItemAssigneeChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(
      assignee: Nullable.value(event.assignee),
      assigneeValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditActionItemCategoryChanged(
    AddEditActionItemCategoryChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(category: Nullable.value(event.category)));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditActionItemCompanyChanged(
    AddEditActionItemCompanyChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(company: Nullable.value(event.company)));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditActionItemProjectChanged(
    AddEditActionItemProjectChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(project: Nullable.value(event.project)));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditActionItemLocationChanged(
    AddEditActionItemLocationChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(location: event.location));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditActionItemNotesChanged(
    AddEditActionItemNotesChanged event,
    Emitter<AddEditActionItemState> emit,
  ) {
    emit(state.copyWith(notes: event.notes));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  Future<void> _onAddEditActionItemAdded(
    AddEditActionItemAdded event,
    Emitter<AddEditActionItemState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response =
            await _actionItemsRepository.addActionItem(state.actionItemCreate);

        if (response.isSuccess) {
          emit(state.copyWith(
            initialAssignee: Nullable.value(state.assignee),
            initialCategory: Nullable.value(state.category),
            initialCompany: Nullable.value(state.company),
            initialDueBy: Nullable.value(state.dueBy),
            initialLocation: state.location,
            initialName: state.name,
            initialNotes: state.notes,
            initialProject: Nullable.value(state.project),
            initialSite: Nullable.value(state.site),
            message: response.message,
            status: EntityStatus.success,
          ));

          _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        }
      } catch (e) {
        emit(state.copyWith(
          message: 'Some thing went wrong.',
          status: EntityStatus.failure,
        ));
      }
    }
  }

  Future<void> _onAddEditActionItemEdited(
    AddEditActionItemEdited event,
    Emitter<AddEditActionItemState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response =
            await _actionItemsRepository.editActionItem(state.actionItemCreate);

        if (response.isSuccess) {
          emit(state.copyWith(
            message: response.message,
            status: EntityStatus.success,
            initialAssignee: Nullable.value(state.assignee),
            initialCategory: Nullable.value(state.category),
            initialCompany: Nullable.value(state.company),
            initialDueBy: Nullable.value(state.dueBy),
            initialLocation: state.location,
            initialName: state.name,
            initialNotes: state.notes,
            initialProject: Nullable.value(state.project),
            initialSite: Nullable.value(state.site),
          ));

          _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        }
      } catch (e) {
        emit(state.copyWith(
          message: 'Some thing went wrong.',
          status: EntityStatus.failure,
        ));
      }
    }
  }

  bool _validate(Emitter<AddEditActionItemState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.name)) {
      emit(state.copyWith(
          nameValidationMessage:
              FormValidationMessage(fieldName: 'Action item').requiredMessage));

      success = false;
    }

    if (state.dueBy == null) {
      emit(state.copyWith(
          dueByValidationMessage:
              FormValidationMessage(fieldName: 'Due by').requiredMessage));

      success = false;
    }

    if (state.site == null) {
      emit(state.copyWith(
          siteValidationMessage:
              FormValidationMessage(fieldName: 'Site').requiredMessage));

      success = false;
    }

    if (state.assignee == null) {
      emit(state.copyWith(
          assigneeValidationMessage:
              FormValidationMessage(fieldName: 'Assignee').requiredMessage));

      success = false;
    }

    return success;
  }

  Future<void> _onAddEditActionItemLoaded(
    AddEditActionItemLoaded event,
    Emitter<AddEditActionItemState> emit,
  ) async {
    try {
      ActionItem actionItem =
          await _actionItemsRepository.getActionItemById(event.actionItemId);

      add(AddEditActionItemProjectListLoaded(siteId: actionItem.siteId));
      add(AddEditActionItemCompanyListLoaded(siteId: actionItem.siteId));
      add(AddEditActionItemUserListLoaded(siteId: actionItem.siteId));

      emit(state.copyWith(
        actionItem: Nullable.value(actionItem),
        name: actionItem.name,
        initialName: actionItem.name,
        dueBy: Nullable.value(actionItem.dueBy),
        initialDueBy: Nullable.value(actionItem.dueBy),
        assignee: Nullable.value(User(
          id: actionItem.assigneeId,
          firstName: actionItem.assigneeName.split(' ')[0],
          lastName: actionItem.assigneeName.split(' ')[1],
        )),
        initialAssignee: Nullable.value(User(
          id: actionItem.assigneeId,
          firstName: actionItem.assigneeName.split(' ')[0],
          lastName: actionItem.assigneeName.split(' ')[1],
        )),
        site: Nullable.value(Site(
          id: actionItem.siteId,
          name: actionItem.siteName,
        )),
        initialSite: Nullable.value(Site(
          id: actionItem.siteId,
          name: actionItem.siteName,
        )),
        category: Nullable.value(AwarenessCategory(
          name: actionItem.awarenessCategoryName,
          id: actionItem.awarenessCategoryId,
        )),
        initialCategory: Nullable.value(AwarenessCategory(
          name: actionItem.awarenessCategoryName,
          id: actionItem.awarenessCategoryId,
        )),
        company: Nullable.value(Company(
          name: actionItem.companyName,
          id: actionItem.companyId,
        )),
        initialCompany: Nullable.value(Company(
          name: actionItem.companyName,
          id: actionItem.companyId,
        )),
        project: Nullable.value(Project(
          name: actionItem.projectName,
          id: actionItem.projectId,
        )),
        initialProject: Nullable.value(Project(
          name: actionItem.projectName,
          id: actionItem.projectId,
        )),
        location: actionItem.area,
        initialLocation: actionItem.area,
        notes: actionItem.notes,
        initialNotes: actionItem.notes,
      ));
    } catch (e) {}
  }
}
