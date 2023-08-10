import 'package:file_picker/file_picker.dart';

import '/common_libraries.dart';

part 'add_action_item_event.dart';
part 'add_action_item_state.dart';

class AddActionItemBloc extends Bloc<AddActionItemEvent, AddActionItemState> {
  late ActionItemsRepository _actionItemsRepository;
  late ObservationsRepository _observationsRepository;
  late SitesRepository _sitesRepository;
  late DocumentsRepository _documentsRepository;
  late ObservationDetailBloc _observationDetailBloc;

  final BuildContext context;
  final String observationId;
  AddActionItemBloc({
    required this.context,
    required this.observationId,
  }) : super(AddActionItemState()) {
    _actionItemsRepository = RepositoryProvider.of(context);
    _observationsRepository = RepositoryProvider.of(context);
    _observationDetailBloc = context.read();
    _documentsRepository = context.read();
    _sitesRepository = context.read();

    _bindEvents();
  }

  void _bindEvents() {
    on<AddActionItemListLoaded>(_onAddActionItemListLoaded);
    on<AddActionItemTaskChanged>(_onAddActionItemTaskChanged);
    on<AddActionItemDueByChanged>(_onAddActionItemDueByChanged);
    on<AddActionItemAssigneeChanged>(_onAddActionItemAssigneeChanged);
    on<AddActionItemCategoryChanged>(_onAddActionItemCategoryChanged);
    on<AddActionItemSiteChanged>(_onAddActionItemSiteChanged);
    on<AddActionItemCompanyChanged>(_onAddActionItemCompanyChanged);
    on<AddActionItemProjectChanged>(_onAddActionItemProjectChanged);
    on<AddActionItemLocationChanged>(_onAddActionItemLocationChanged);
    on<AddActionItemNotesChanged>(_onAddActionItemNotesChanged);
    on<AddActionItemIsClosedChanged>(_onAddActionItemIsClosedChanged);
    on<AddActionItemAddActionItemButtonClicked>(
        _onAddActionItemAddActionItemButtonClicked);
    on<AddActionItemActionItemListButtonClicked>(
        _onAddActionItemActionItemListButtonClicked);
    on<AddActionItemSaved>(_onAddActionItemSaved);
    on<AddActionItemDetailShown>(_onAddActionItemDetailShown);
    on<AddActionItemDetailEdited>(_onAddActionItemDetailEdited);
    on<AddActionItemIsEditingChanged>(_onAddActionItemIsEditingChanged);
    on<AddActionItemImageListChanged>(_onAddActionItemImageListChanged);
  }

  void _onAddActionItemImageListChanged(
    AddActionItemImageListChanged event,
    Emitter<AddActionItemState> emit,
  ) async {
    emit(state.copyWith(imageList: event.imageList));
  }

  Future<void> _onAddActionItemListLoaded(
    AddActionItemListLoaded event,
    Emitter<AddActionItemState> emit,
  ) async {
    emit(state.copyWith(
      status: EntityStatus.loading,
      message: '',
    ));
    try {
      final List<ActionItem> actionItemList =
          await _observationsRepository.getActionItemList(event.observationId);
      emit(state.copyWith(
        actionItemList: actionItemList,
        status: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  void _onAddActionItemDetailShown(
    AddActionItemDetailShown event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(
      actionItem: Nullable.value(event.actionItem),
      isEditing: false,
    ));
  }

  bool _validate(Emitter<AddActionItemState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.task)) {
      emit(state.copyWith(
          actionItemValidationMessage:
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

  Future<void> _onAddActionItemDetailEdited(
    AddActionItemDetailEdited event,
    Emitter<AddActionItemState> emit,
  ) async {
    emit(state.copyWith(
      status: EntityStatus.loading,
      message: '',
    ));
    try {
      final actionItem =
          await _actionItemsRepository.getActionItemById(event.actionItem.id!);

      if (actionItem.siteId.isNotEmpty) {
        final List<CompanySite> companyList =
            await _sitesRepository.getCompanyListForSite(actionItem.siteId);

        final List<Project> projectList =
            await _sitesRepository.getProjectListForSite(actionItem.siteId);

        final List<Entity> userList =
            await _sitesRepository.getUserListForSite(actionItem.siteId);

        emit(state.copyWith(
          companyList: companyList
              .map((e) => Company(id: e.companyId, name: e.companyName))
              .toList(),
          projectList: projectList,
          userList: userList,
        ));
      }

      emit(state.copyWith(
        actionItem:
            Nullable.value(actionItem.copyWith(id: event.actionItem.id)),
        task: actionItem.name,
        dueBy: Nullable.value(actionItem.dueBy),
        initialDueBy: Nullable.value(actionItem.dueBy),
        assignee: Nullable.value(User(
          id: actionItem.assigneeId,
          firstName: actionItem.assigneeName.split(' ')[0],
          lastName: actionItem.assigneeName.split(' ')[1],
        )),
        site: Nullable.value(Site(
          id: actionItem.siteId,
          name: actionItem.siteName,
        )),
        category: actionItem.awarenessCategoryId.isNotEmpty
            ? Nullable.value(AwarenessCategory(
                name: actionItem.awarenessCategoryName,
                id: actionItem.awarenessCategoryId,
              ))
            : const Nullable.value(null),
        company: actionItem.companyId.isNotEmpty
            ? Nullable.value(Company(
                name: actionItem.companyName,
                id: actionItem.companyId,
              ))
            : const Nullable.value(null),
        project: actionItem.projectId.isNotEmpty
            ? Nullable.value(Project(
                name: actionItem.projectName,
                id: actionItem.projectId,
              ))
            : const Nullable.value(null),
        location: actionItem.area,
        notes: actionItem.notes,
        isClosed: false,
        isEditing: true,
        status: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  void _onAddActionItemTaskChanged(
    AddActionItemTaskChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(
      task: event.task,
      actionItemValidationMessage: '',
    ));
  }

  void _onAddActionItemDueByChanged(
    AddActionItemDueByChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(
      dueBy: Nullable.value(event.dueBy),
      dueByValidationMessage: '',
    ));
  }

  void _onAddActionItemAssigneeChanged(
    AddActionItemAssigneeChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(
      assignee: Nullable.value(event.assignee),
      assigneeValidationMessage: '',
    ));
  }

  Future<void> _onAddActionItemSiteChanged(
    AddActionItemSiteChanged event,
    Emitter<AddActionItemState> emit,
  ) async {
    emit(state.copyWith(
      site: Nullable.value(event.site),
      siteValidationMessage: '',
      company: const Nullable.value(null),
      project: const Nullable.value(null),
      assignee: const Nullable.value(null),
    ));

    if (event.site != null) {
      List<CompanySite> companyList =
          await _sitesRepository.getCompanyListForSite(event.site!.id!);

      List<Project> projectList =
          await _sitesRepository.getProjectListForSite(event.site!.id!);

      final List<Entity> userList =
          await _sitesRepository.getUserListForSite(event.site!.id!);

      emit(state.copyWith(
        projectList: projectList,
        userList: userList,
        companyList: companyList
            .map((e) => Company(
                  id: e.companyId,
                  name: e.companyName,
                ))
            .toList(),
      ));
    }
  }

  void _onAddActionItemCategoryChanged(
    AddActionItemCategoryChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(category: Nullable.value(event.category)));
  }

  void _onAddActionItemCompanyChanged(
    AddActionItemCompanyChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(company: Nullable.value(event.company)));
  }

  void _onAddActionItemProjectChanged(
    AddActionItemProjectChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(project: Nullable.value(event.project)));
  }

  void _onAddActionItemLocationChanged(
    AddActionItemLocationChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(location: event.location));
  }

  void _onAddActionItemNotesChanged(
    AddActionItemNotesChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(notes: event.notes));
  }

  void _onAddActionItemIsClosedChanged(
    AddActionItemIsClosedChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(isClosed: event.isClosed));
  }

  void _onAddActionItemAddActionItemButtonClicked(
    AddActionItemAddActionItemButtonClicked event,
    Emitter<AddActionItemState> emit,
  ) {
    // if (_observationDetailBloc.state.observation != null) {
    //   emit(state.copyWith(
    //     site: Nullable.value(Site(
    //       id: _observationDetailBloc.state.observation!.userReportedSiteId,
    //       name: _observationDetailBloc.state.observation!.userReportedSiteName,
    //     )),
    //   ));
    // } else {
    //   emit(state.copyWith(site: const Nullable.value(null)));
    // }

    emit(state.copyWith(
      isEditing: true,
      task: '',
      actionItemValidationMessage: '',
      dueBy: const Nullable.value(null),
      dueByValidationMessage: '',
      assignee: const Nullable.value(null),
      assigneeValidationMessage: '',
      category: const Nullable.value(null),
      company: const Nullable.value(null),
      project: const Nullable.value(null),
      site: const Nullable.value(null),
      siteValidationMessage: '',
      location: '',
      notes: '',
      actionItem: const Nullable.value(null),
    ));
  }

  void _onAddActionItemActionItemListButtonClicked(
    AddActionItemActionItemListButtonClicked event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(
      isEditing: false,
      actionItem: const Nullable.value(null),
    ));
  }

  Future<void> _onAddActionItemSaved(
    AddActionItemSaved event,
    Emitter<AddActionItemState> emit,
  ) async {
    if (!_validate(emit)) {
      return;
    }
    try {
      late EntityResponse response;

      emit(state.copyWith(status: EntityStatus.loading));

      late String id;

      if (state.actionItem == null) {
        response = await _actionItemsRepository.addActionItem(
            state.actionItemCreate.copyWith(observationId: observationId));

        id = response.data!.id!;
      } else {
        response = await _actionItemsRepository.editActionItem(
            state.actionItemCreate.copyWith(observationId: observationId));

        id = state.actionItem!.id!;
      }

      if (response.isSuccess) {
        if (state.imageList.isNotEmpty) {
          await _documentsRepository.uploadDocuments(
            ownerId: id,
            ownerType: 'actionitem',
            documentList: state.imageList,
          );
        }

        emit(state.copyWith(
          isEditing: false,
          actionItem: const Nullable.value(null),
          message: response.message,
          status: EntityStatus.success,
        ));

        add(AddActionItemListLoaded(observationId: observationId));
      }
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  void _onAddActionItemIsEditingChanged(
    AddActionItemIsEditingChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(
      isEditing: event.isEditing,
      actionItem: const Nullable.value(null),
    ));
  }
}
