import '/common_libraries.dart';

part 'action_item_detail_event.dart';
part 'action_item_detail_state.dart';

class ActionItemDetailBloc
    extends Bloc<ActionItemDetailEvent, ActionItemDetailState> {
  final BuildContext context;
  late ActionItemsRepository _actionItemsRepository;
  ActionItemDetailBloc(this.context) : super(const ActionItemDetailState()) {

    _actionItemsRepository = RepositoryProvider.of(context);

    on<ActionItemDetailLoaded>(_onActionItemDetailLoaded);
    on<ActionItemDetailActionItemDeleted>(
        _onActionItemDetailActionItemDeleted);
  }

  Future<void> _onActionItemDetailLoaded(
    ActionItemDetailLoaded event,
    Emitter<ActionItemDetailState> emit,
  ) async {
    try {
      ActionItem actionItem =
          await _actionItemsRepository.getActionItemById(event.actionItemId);

      emit(state.copyWith(actionItem: actionItem));
    } catch (e) {}
  }

  Future<void> _onActionItemDetailActionItemDeleted(
    ActionItemDetailActionItemDeleted event,
    Emitter<ActionItemDetailState> emit,
  ) async {}
}
