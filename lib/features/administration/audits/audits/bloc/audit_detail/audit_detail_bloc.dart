import '/common_libraries.dart';

part 'audit_detail_event.dart';
part 'audit_detail_state.dart';

class AuditDetailBloc extends Bloc<AuditDetailEvent, AuditDetailState> {
  final BuildContext context;
  late AuditsRepository _auditsRepository;
  final String auditId;
  AuditDetailBloc(
    this.context,
    this.auditId,
  ) : super(const AuditDetailState()) {
    _auditsRepository = RepositoryProvider.of(context);
    on<AuditDetailLoaded>(_onAuditDetailLoaded);
    on<AuditDetailAuditDeleted>(_onAuditDetailAuditDeleted);
    on<AuditDetailAuditSectionListLoaded>(_onAuditDetailAuditSectionListLoaded);
    on<AuditDetailSelectedAuditSectionChanged>(
        _onAuditDetailSelectedAuditSectionChanged);
    on<AuditDetailDocumentListLoaded>(_onAuditDetailDocumentListLoaded);
    on<AuditDetailObservationListLoaded>(_onAuditDetailObservationListLoaded);
    on<AuditDetailActionItemListLoaded>(_onAuditDetailActionItemListLoaded);
  }

  Future<void> _onAuditDetailDocumentListLoaded(
    AuditDetailDocumentListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      List<Document> documentList =
          await _auditsRepository.getDocumentListForDetail(auditId);

      emit(state.copyWith(
        status: EntityStatus.success,
        documentList: documentList,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  Future<void> _onAuditDetailObservationListLoaded(
    AuditDetailObservationListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      List<ObservationDetail> observationList =
          await _auditsRepository.getAuditObservationListForDetail(auditId);

      emit(state.copyWith(
        status: EntityStatus.success,
        observationList: observationList,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  Future<void> _onAuditDetailActionItemListLoaded(
    AuditDetailActionItemListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      List<AuditActionItem> actionItemList =
          await _auditsRepository.getAuditActionItemListForDetail(auditId);

      emit(state.copyWith(
        status: EntityStatus.success,
        actionItemList: actionItemList,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  Future<void> _onAuditDetailLoaded(
    AuditDetailLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    try {
      AuditSummary auditSummary =
          await _auditsRepository.getAuditSummary(event.auditId);

      emit(state.copyWith(auditSummary: auditSummary));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onAuditDetailAuditDeleted(
    AuditDetailAuditDeleted event,
    Emitter<AuditDetailState> emit,
  ) async {}

  Future<void> _onAuditDetailAuditSectionListLoaded(
    AuditDetailAuditSectionListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    final auditSectionAndQuestion =
        await _auditsRepository.getAuditSectionAndQuestionList(auditId);

    emit(state.copyWith(
      auditSectionAndQuestionList: auditSectionAndQuestion,
      selectedAuditSection: auditSectionAndQuestion.isNotEmpty
          ? auditSectionAndQuestion.first
          : null,
    ));
  }

  void _onAuditDetailSelectedAuditSectionChanged(
    AuditDetailSelectedAuditSectionChanged event,
    Emitter<AuditDetailState> emit,
  ) {
    emit(state.copyWith(selectedAuditSection: event.auditSection));
  }
}
