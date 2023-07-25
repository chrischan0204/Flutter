import '/common_libraries.dart';

part 'action_item_detail_event.dart';
part 'action_item_detail_state.dart';

class ActionItemDetailBloc
    extends Bloc<ActionItemDetailEvent, ActionItemDetailState> {
  final BuildContext context;
  final String actionItemId;
  late ActionItemsRepository _actionItemsRepository;
  late ObservationsRepository _observationsRepository;
  ActionItemDetailBloc(
    this.context,
    this.actionItemId,
  ) : super(const ActionItemDetailState()) {
    _actionItemsRepository = RepositoryProvider.of(context);
    _observationsRepository = context.read();

    on<ActionItemDetailLoaded>(_onActionItemDetailLoaded);
    on<ActionItemDetailActionItemDeleted>(_onActionItemDetailActionItemDeleted);
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
        AuditQuestionOnActionItem auditQuestionOnActionitem =
            await _actionItemsRepository.getAuditQuestionForActionItem(
                actionItemId: actionItemId,
                questionId: actionItem.auditSectionItemId);

        emit(state.copyWith(
            auditQuestionOnActionitem: auditQuestionOnActionitem));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onActionItemDetailActionItemDeleted(
    ActionItemDetailActionItemDeleted event,
    Emitter<ActionItemDetailState> emit,
  ) async {
    emit(state.copyWith(actionItemDeleteStatus: EntityStatus.loading));

    try {
      EntityResponse response =
          await _actionItemsRepository.deleteActionItem(actionItemId);
      emit(state.copyWith(
        actionItemDeleteStatus: EntityStatus.success,
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(actionItemDeleteStatus: EntityStatus.failure));
    }
  }
}
