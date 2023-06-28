import '/common_libraries.dart';

part 'add_action_item_event.dart';
part 'add_action_item_state.dart';

class AddActionItemBloc extends Bloc<AddActionItemEvent, AddActionItemState> {
  late ActionItemsRepository _actionItemsRepository;
  final BuildContext context;
  AddActionItemBloc(this.context) : super(const AddActionItemState()) {
    _actionItemsRepository = RepositoryProvider.of(context);

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
          await _actionItemsRepository.getActionItemList(event.observationId);
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

  void _onAddActionItemDetailEdited(
    AddActionItemDetailEdited event,
    Emitter<AddActionItemState> emit,
  ) {
    // emit(state.copyWith(
    //   actionItem: Nullable.value(event.actionItem),
    //   task: event.actionItem.task,
    //   dueBy: Nullable.value(event.actionItem.due),
    //   assignee: Nullable.value(User(
    //     firstName: event.actionItem.assignee.split(' ')[0],
    //     lastName: event.actionItem.assignee.split(' ')[1],
    //   )),
    //   category:
    //       Nullable.value(AwarenessCategory(name: event.actionItem.category)),
    //   company: Nullable.value(Company(name: event.actionItem.company)),
    //   project: Nullable.value(Project(name: event.actionItem.project)),
    //   location: event.actionItem.location,
    //   notes: event.actionItem.notes,
    //   isEditing: true,
    // ));
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

  void _onAddActionItemSaved(
    AddActionItemSaved event,
    Emitter<AddActionItemState> emit,
  ) {
    emit(state.copyWith(
      isEditing: false,
      actionItem: const Nullable.value(null),
    ));
  }
}
