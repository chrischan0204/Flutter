import '/common_libraries.dart';

part 'add_action_item_event.dart';
part 'add_action_item_state.dart';

class AddActionItemBloc extends Bloc<AddActionItemEvent, AddActionItemState> {
  late ActionItemsRepository _actionItemsRepository;
  late ObservationsRepository _observationsRepository;
  final BuildContext context;
  final String observationId;
  AddActionItemBloc(
    this.context,
    this.observationId,
  ) : super(const AddActionItemState()) {
    _actionItemsRepository = RepositoryProvider.of(context);
    _observationsRepository = RepositoryProvider.of(context);

    _bindEvents();
  }

  void _bindEvents() {
    on<AddActionItemListLoaded>(_onAddActionItemListLoaded);
    on<AddActionItemTaskChanged>(_onAddActionItemTaskChanged);
    on<AddActionItemDueByChanged>(_onAddActionItemDueByChanged);
    on<AddActionItemAssigneeChanged>(_onAddActionItemAssigneeChanged);
    on<AddActionItemCategoryChanged>(_onAddActionItemCategoryChanged);
    on<AddActionItemCompanyChanged>(_onAddActionItemCompanyChanged);
    on<AddActionItemProjectChanged>(_onAddActionItemProjectChanged);
    on<AddActionItemLocationChanged>(_onAddActionItemLocationChanged);
    on<AddActionItemNotesChanged>(_onAddActionItemNotesChanged);
    on<AddActionItemAddActionItemButtonClicked>(
        _onAddActionItemAddActionItemButtonClicked);
    on<AddActionItemActionItemListButtonClicked>(
        _onAddActionItemActionItemListButtonClicked);
    on<AddActionItemSaved>(_onAddActionItemSaved);
    on<AddActionItemDetailShown>(_onAddActionItemDetailShown);
    on<AddActionItemDetailEdited>(_onAddActionItemDetailEdited);
  }

  Future<void> _onAddActionItemListLoaded(
    AddActionItemListLoaded event,
    Emitter<AddActionItemState> emit,
  ) async {
    try {
      final List<ActionItem> actionItemList =
          await _observationsRepository.getActionItemList(event.observationId);
      emit(state.copyWith(actionItemList: actionItemList));
    } catch (e) {}
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

  Future<void> _onAddActionItemDetailEdited(
    AddActionItemDetailEdited event,
    Emitter<AddActionItemState> emit,
  ) async {
    try {
      final actionItem =
          await _actionItemsRepository.getActionItemById(event.actionItem.id!);

      emit(state.copyWith(
        actionItem: Nullable.value(actionItem),
        task: actionItem.name,
        dueBy: Nullable.value(actionItem.dueBy),
        assignee: Nullable.value(User(
          id: actionItem.assigneeId,
          firstName: actionItem.assigneeName.split(' ')[0],
          lastName: actionItem.assigneeName.split(' ')[1],
        )),
        category: Nullable.value(AwarenessCategory(
          name: actionItem.awarenessCategoryName,
          id: actionItem.awarenessCategoryId,
        )),
        company: Nullable.value(Company(
          name: actionItem.companyName,
          id: actionItem.companyId,
        )),
        project: Nullable.value(Project(
          name: actionItem.projectName,
          id: actionItem.projectId,
        )),
        location: actionItem.area,
        notes: actionItem.notes,
        isEditing: true,
      ));
    } catch (e) {}
  }

  void _onAddActionItemTaskChanged(
    AddActionItemTaskChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(task: event.task));
  }

  void _onAddActionItemDueByChanged(
    AddActionItemDueByChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(dueBy: Nullable.value(event.dueBy)));
  }

  void _onAddActionItemAssigneeChanged(
    AddActionItemAssigneeChanged event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(assignee: Nullable.value(event.assignee)));
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

  void _onAddActionItemAddActionItemButtonClicked(
    AddActionItemAddActionItemButtonClicked event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(
      isEditing: true,
      task: '',
      dueBy: const Nullable.value(null),
      assignee: const Nullable.value(null),
      category: const Nullable.value(null),
      company: const Nullable.value(null),
      project: const Nullable.value(null),
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
    try {
      late EntityResponse response;

      if (state.actionItem == null) {
        response = await _actionItemsRepository.addActionItem(
            state.actionItemCreate.copyWith(observationId: observationId));
      } else {
        response = await _actionItemsRepository.editActionItem(
            state.actionItemCreate.copyWith(observationId: observationId));
      }

      if (response.isSuccess) {
        emit(state.copyWith(
          isEditing: false,
          actionItem: const Nullable.value(null),
          message: response.message,
          status: EntityStatus.success,
        ));
      }

      add(AddActionItemListLoaded(observationId: observationId));
    } catch (e) {}
  }
}
