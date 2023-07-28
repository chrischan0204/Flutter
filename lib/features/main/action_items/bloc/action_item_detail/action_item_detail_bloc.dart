import '/common_libraries.dart';

part 'action_item_detail_event.dart';
part 'action_item_detail_state.dart';

class ActionItemDetailBloc
    extends Bloc<ActionItemDetailEvent, ActionItemDetailState> {
  final BuildContext context;
  final String actionItemId;
  late ActionItemsRepository _actionItemsRepository;
  late ObservationsRepository _observationsRepository;
  late DocumentsRepository _documentsRepository;
  ActionItemDetailBloc(
    this.context,
    this.actionItemId,
  ) : super(const ActionItemDetailState()) {
    _actionItemsRepository = RepositoryProvider.of(context);
    _observationsRepository = context.read();
    _documentsRepository = context.read();

    on<ActionItemDetailLoaded>(_onActionItemDetailLoaded);
    on<ActionItemDetailActionItemDeleted>(_onActionItemDetailActionItemDeleted);
    on<ActionItemDetailDocumentListLoaded>(
        _onActionItemDetailDocumentListLoaded);
    on<ActionItemDetailDocumentDeleted>(_onActionItemDetailDocumentDeleted);
  }

  Future<void> _onActionItemDetailDocumentDeleted(
    ActionItemDetailDocumentDeleted event,
    Emitter<ActionItemDetailState> emit,
  ) async {
    emit(state.copyWith(documentDeleteStatus: EntityStatus.loading));
    try {
      EntityResponse response =
          await _documentsRepository.deleteDocument(event.documentId);

      if (response.isSuccess) {
        emit(state.copyWith(documentDeleteStatus: EntityStatus.success));

        add(ActionItemDetailDocumentListLoaded());
      }
    } catch (e) {
      emit(state.copyWith(documentDeleteStatus: EntityStatus.failure));
    }
  }

  Future<void> _onActionItemDetailDocumentListLoaded(
    ActionItemDetailDocumentListLoaded event,
    Emitter<ActionItemDetailState> emit,
  ) async {
    emit(state.copyWith(documentListLoadStatus: EntityStatus.loading));
    try {
      List<Document> documentList = await _documentsRepository.getDocumentList(
        ownerId: actionItemId,
        ownerType: 'actionitem',
      );

      emit(state.copyWith(
        documentList: documentList,
        documentListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(documentListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onActionItemDetailLoaded(
    ActionItemDetailLoaded event,
    Emitter<ActionItemDetailState> emit,
  ) async {
    emit(state.copyWith(actionItemLoadStatus: EntityStatus.loading));
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

      emit(state.copyWith(actionItemLoadStatus: EntityStatus.success));
    } catch (e) {
      emit(state.copyWith(actionItemLoadStatus: EntityStatus.failure));
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
