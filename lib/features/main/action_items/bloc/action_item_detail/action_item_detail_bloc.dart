import '/common_libraries.dart';

part 'action_item_detail_event.dart';
part 'action_item_detail_state.dart';

class ActionItemDetailBloc
    extends Bloc<ActionItemDetailEvent, ActionItemDetailState> {
  final BuildContext context;
  final String actionItemId;
  late ActionItemsRepository _actionItemsRepository;
  ActionItemDetailBloc(
    this.context,
    this.actionItemId,
  ) : super(const ActionItemDetailState()) {
    _actionItemsRepository = RepositoryProvider.of(context);

    on<ActionItemDetailLoaded>(_onActionItemDetailLoaded);
    on<ActionItemDetailActionItemDeleted>(_onActionItemDetailActionItemDeleted);
    on<ActionItemDetailParentInfoLoaded>(_onActionItemDetailParentInfoLoaded);
  }

  Future<void> _onActionItemDetailLoaded(
    ActionItemDetailLoaded event,
    Emitter<ActionItemDetailState> emit,
  ) async {
    try {
      ActionItem actionItem =
          await _actionItemsRepository.getActionItemById(actionItemId);

      emit(state.copyWith(actionItem: actionItem));
    } catch (e) {}
  }

  Future<void> _onActionItemDetailActionItemDeleted(
    ActionItemDetailActionItemDeleted event,
    Emitter<ActionItemDetailState> emit,
  ) async {}

  Future<void> _onActionItemDetailParentInfoLoaded(
    ActionItemDetailParentInfoLoaded event,
    Emitter<ActionItemDetailState> emit,
  ) async {
    ActionItemParentInfo actionItemParentInfo =
        await _actionItemsRepository.getActionItemParentInfo(actionItemId);

    emit(state.copyWith(actionItemParentInfo: actionItemParentInfo));
  }
}
