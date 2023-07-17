import '/common_libraries.dart';

part 'action_item_list_event.dart';
part 'action_item_list_state.dart';

class ActionItemListBloc
    extends Bloc<ActionItemListEvent, ActionItemListState> {
  final BuildContext context;
  late ActionItemsRepository _actionItemsRepository;
  ActionItemListBloc(this.context) : super(const ActionItemListState()) {
    _actionItemsRepository = RepositoryProvider.of(context);

    on<ActionItemListLoaded>(_onActionItemListLoaded);
    on<ActionItemListFiltered>(_onActionItemListFiltered);
    on<ActionItemListActionItemForSideDetailLoaded>(
        _onActionItemListActionItemForSideDetailLoaded);
  }

  Future<void> _onActionItemListLoaded(
    ActionItemListLoaded event,
    Emitter<ActionItemListState> emit,
  ) async {
    // emit(state.copyWith(actionItemListLoadStatus: EntityStatus.loading));
    // try {
    //   List<ActionItem> actionItemList =
    //       await _actionItemsRepository.getActionItemList();
    //   emit(state.copyWith(
    //     actionItemListLoadStatus: EntityStatus.success,
    //     actionItemList: actionItemList,
    //   ));
    // } catch (e) {
    //   emit(state.copyWith(actionItemListLoadStatus: EntityStatus.failure));
    // }
  }

  Future<void> _onActionItemListFiltered(
    ActionItemListFiltered event,
    Emitter<ActionItemListState> emit,
  ) async {
    emit(state.copyWith(actionItemListLoadStatus: EntityStatus.loading));

    try {
      final filteredactionItemData =
          await _actionItemsRepository.getFilteredActionItemList(event.option);
      final List<String> columns = List.from(filteredactionItemData.headers
          .where((e) => !e.isHidden)
          .map((e) => e.title));

      emit(state.copyWith(
        actionItemList: filteredactionItemData.data
            .map((e) => e.actionItem.copyWith(columns: columns))
            .toList(),
        actionItemListLoadStatus: EntityStatus.success,
        totalRows: filteredactionItemData.totalRows,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(actionItemListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onActionItemListActionItemForSideDetailLoaded(
    ActionItemListActionItemForSideDetailLoaded event,
    Emitter<ActionItemListState> emit,
  ) async {
    emit(state.copyWith(actionItemLoadStatus: EntityStatus.loading));

    try {
      ActionItem actionItem =
          await _actionItemsRepository.getActionItemById(event.actionItemId);

      emit(state.copyWith(
        actionItemLoadStatus: EntityStatus.success,
        actionItem: actionItem,
      ));
    } catch (e) {
      emit(state.copyWith(actionItemLoadStatus: EntityStatus.failure));
    }
  }
}
