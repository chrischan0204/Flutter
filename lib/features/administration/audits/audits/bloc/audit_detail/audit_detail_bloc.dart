import '/common_libraries.dart';

part 'audit_detail_event.dart';
part 'audit_detail_state.dart';

class AuditDetailBloc extends Bloc<AuditDetailEvent, AuditDetailState> {
  final BuildContext context;
  late AuditsRepository _auditsRepository;
  late UsersRepository _usersRepository;
  final String auditId;
  AuditDetailBloc(
    this.context,
    this.auditId,
  ) : super(const AuditDetailState()) {
    _auditsRepository = RepositoryProvider.of(context);
    _usersRepository = context.read();

    on<AuditDetailLoaded>(_onAuditDetailLoaded);
    on<AuditDetailAuditDeleted>(_onAuditDetailAuditDeleted);
    on<AuditDetailAuditSectionListLoaded>(_onAuditDetailAuditSectionListLoaded);
    on<AuditDetailSelectedAuditSectionChanged>(
        _onAuditDetailSelectedAuditSectionChanged);
    on<AuditDetailDocumentListLoaded>(_onAuditDetailDocumentListLoaded);
    on<AuditDetailObservationListLoaded>(_onAuditDetailObservationListLoaded);
    on<AuditDetailActionItemListLoaded>(_onAuditDetailActionItemListLoaded);
    on<AuditDetailMethodSelected>(_onAuditDetailMethodSelected);
    on<AuditDetailReviewerItemIncreased>(_onAuditDetailReviewerItemIncreased);
    on<AuditDetailReviewerSelected>(_onAuditDetailReviewerSelected);
    on<AuditDetailReviewerListLoaded>(_onAuditDetailReviewerListLoaded);
  }

  Future<void> _onAuditDetailReviewerListLoaded(
    AuditDetailReviewerListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    try {
      final List<User> reviewerList = await _usersRepository.getUserList();
      emit(state.copyWith(reviewerList: reviewerList));
    } catch (e) {}
  }

  void _onAuditDetailReviewerSelected(
    AuditDetailReviewerSelected event,
    Emitter<AuditDetailState> emit,
  ) {
    final List<User?> selectedReviewerList =
        List.from(state.selectedReviewerList);

    selectedReviewerList.removeAt(event.index);

    selectedReviewerList.insert(event.index, event.reviewer);

    emit(state.copyWith(selectedReviewerList: selectedReviewerList));
  }

  void _onAuditDetailReviewerItemIncreased(
    AuditDetailReviewerItemIncreased event,
    Emitter<AuditDetailState> emit,
  ) {
    final List<User?> selectedReviewerList =
        List.from(state.selectedReviewerList);

    selectedReviewerList.insert(event.index + 1, null);

    emit(state.copyWith(selectedReviewerList: selectedReviewerList));
  }

  void _onAuditDetailMethodSelected(
    AuditDetailMethodSelected event,
    Emitter<AuditDetailState> emit,
  ) {
    if (event.method == 'Close Audit') {
      emit(state.copyWith(selectedMethod: event.method));
    } else {
      emit(state.copyWith(selectedMethod: event.method));
    }
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
    emit(state.copyWith(auditLoadStatus: EntityStatus.loading));
    try {
      AuditSummary auditSummary =
          await _auditsRepository.getAuditSummary(event.auditId);

      emit(state.copyWith(
        auditSummary: auditSummary,
        auditLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(auditLoadStatus: EntityStatus.loading));
    }
  }

  Future<void> _onAuditDetailAuditDeleted(
    AuditDetailAuditDeleted event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      EntityResponse response = await _auditsRepository.deleteAudit(auditId);

      if (response.isSuccess) {
        emit(state.copyWith(
          status: EntityStatus.success,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

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
