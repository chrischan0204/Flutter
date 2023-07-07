import '/common_libraries.dart';

part 'action_item_detail_event.dart';
part 'action_item_detail_state.dart';

class ActionItemDetailBloc
    extends Bloc<ActionItemDetailEvent, ActionItemDetailState> {
  final BuildContext context;
  final String actionItemId;
  late ActionItemsRepository _actionItemsRepository;
  late ObservationsRepository _observationsRepository;
  late AuditsRepository _auditsRepository;
  ActionItemDetailBloc(
    this.context,
    this.actionItemId,
  ) : super(const ActionItemDetailState()) {
    _actionItemsRepository = RepositoryProvider.of(context);
    _observationsRepository = context.read();
    _auditsRepository = context.read();

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

      if (actionItem.source == 'Observation') {
        ObservationDetail observation = await _observationsRepository
            .getObservationById(actionItem.observationId);

        emit(state.copyWith(observation: observation));
      } else if (actionItem.source == 'Audit') {
        Audit audit = await _auditsRepository.getAuditById(actionItem.auditId);

        emit(state.copyWith(audit: audit));
      }
    } catch (e) {
      print(e);
    }
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
