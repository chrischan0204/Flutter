import '/common_libraries.dart';

part 'audit_detail_event.dart';
part 'audit_detail_state.dart';

class AuditDetailBloc extends Bloc<AuditDetailEvent, AuditDetailState> {
  final BuildContext context;
  late AuditsRepository _auditsRepository;
  late SitesRepository _sitesRepository;
  final String auditId;
  AuditDetailBloc(
    this.context,
    this.auditId,
  ) : super(const AuditDetailState()) {
    _auditsRepository = RepositoryProvider.of(context);
    _sitesRepository = context.read();

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
    on<AuditDetailAuditMarkCompleted>(_onAuditDetailAuditMarkCompleted);
    on<AuditDetailAuditMarkClosed>(_onAuditDetailAuditMarkClosed);
    on<AuditDetailAuditMarkInReview>(_onAuditDetailAuditMarkInReview);
    on<AuditDetailReviewersSaved>(_onAuditDetailReviewersSaved);
    on<AuditDetailReviewListLoaded>(_onAuditDetailReviewListLoaded);
    on<AuditDetailCommentChanged>(_onAuditDetailCommentChanged);
    on<AuditDetailCommentSaved>(_onAuditDetailCommentSaved);
    on<AuditDetailAuditCompletedQuestionsWithFollowupsListLoaded>(
        _onAuditDetailAuditCompletedQuestionsWithFollowupsListLoaded);
    on<AuditDetailAuditActionItemsStatsLoaded>(
        _onAuditDetailAuditActionItemsStatsLoaded);
  }

  Future<void> _onAuditDetailAuditActionItemsStatsLoaded(
    AuditDetailAuditActionItemsStatsLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    try {
      ActionItemsStats actionItemsStats =
          await _auditsRepository.getActionItemsStats(auditId);

      emit(state.copyWith(actionItemsStats: actionItemsStats));
    } catch (e) {}
  }

  Future<void> _onAuditDetailAuditCompletedQuestionsWithFollowupsListLoaded(
    AuditDetailAuditCompletedQuestionsWithFollowupsListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    try {
      List<AuditCompletedQuestionsWithFollowups>
          auditCompletedQuestionsWithFollowupsList = await _auditsRepository
              .getAuditCompletedQuestionsWithFollowups(auditId);

      emit(state.copyWith(
          auditCompletedQuestionsWithFollowupsList:
              auditCompletedQuestionsWithFollowupsList));
    } catch (e) {}
  }

  Future<void> _onAuditDetailCommentSaved(
    AuditDetailCommentSaved event,
    Emitter<AuditDetailState> emit,
  ) async {
    if (state.auditReviewList.length == 1) {
      AuditReview auditReview = state.auditReviewList[0];
      emit(state.copyWith(auditReviewCommentSaveStatus: EntityStatus.loading));
      try {
        await _auditsRepository.updateAuditReview(auditReview.reviewUpate);

        emit(state.copyWith(
          auditReviewCommentSaveStatus: EntityStatus.success,
          message: 'Comment saved successfully.',
        ));
      } catch (e) {
        emit(
            state.copyWith(auditReviewCommentSaveStatus: EntityStatus.failure));
      }
    }
  }

  void _onAuditDetailCommentChanged(
    AuditDetailCommentChanged event,
    Emitter<AuditDetailState> emit,
  ) async {
    if (state.auditReviewList.length == 1) {
      AuditReview auditReview = state.auditReviewList[0];

      emit(state.copyWith(auditReviewList: [
        auditReview.copyWith(reviewComments: event.comment)
      ]));
    }
  }

  Future<void> _onAuditDetailReviewListLoaded(
    AuditDetailReviewListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(auditReviewListLoadStatus: EntityStatus.loading));

    try {
      List<AuditReview> auditReviewList =
          await _auditsRepository.getAuditReviewList(auditId);

      emit(state.copyWith(
        auditReviewListLoadStatus: EntityStatus.success,
        auditReviewList: auditReviewList,
      ));
    } catch (e) {
      emit(state.copyWith(auditReviewListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAuditDetailReviewersSaved(
    AuditDetailReviewersSaved event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(auditReviewersSaveStatus: EntityStatus.loading));

    try {
      await _auditsRepository.saveAuditReviewers(AuditReviewersCreate(
          auditId: auditId,
          reviewers: state.selectedReviewerList.map((e) => e!.id!).toList()));

      emit(state.copyWith(
          auditReviewersSaveStatus: EntityStatus.success,
          auditSummary: state.auditSummary?.copyWith(
            auditStatusName: 'In Review',
          )));
      add(AuditDetailAuditMarkInReview());
      add(AuditDetailReviewListLoaded());
    } catch (e) {
      emit(state.copyWith(auditReviewersSaveStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAuditDetailAuditMarkInReview(
    AuditDetailAuditMarkInReview event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(auditStatusChangeStatus: EntityStatus.loading));
    try {
      await _auditsRepository.setAuditStatus(auditId, 'inreview');

      emit(state.copyWith(auditStatusChangeStatus: EntityStatus.success));
    } catch (e) {
      emit(state.copyWith(auditStatusChangeStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAuditDetailAuditMarkCompleted(
    AuditDetailAuditMarkCompleted event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(auditStatusChangeStatus: EntityStatus.loading));
    try {
      await _auditsRepository.setAuditStatus(auditId, 'completed');

      emit(state.copyWith(auditStatusChangeStatus: EntityStatus.success));
    } catch (e) {
      emit(state.copyWith(auditStatusChangeStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAuditDetailAuditMarkClosed(
    AuditDetailAuditMarkClosed event,
    Emitter<AuditDetailState> emit,
  ) async {
    emit(state.copyWith(auditStatusChangeStatus: EntityStatus.loading));
    try {
      await _auditsRepository.setAuditStatus(auditId, 'closed');

      emit(state.copyWith(auditStatusChangeStatus: EntityStatus.success));

      add(AuditDetailLoaded(auditId: auditId));
    } catch (e) {
      emit(state.copyWith(auditStatusChangeStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAuditDetailReviewerListLoaded(
    AuditDetailReviewerListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    try {
      final List<Entity> reviewerList =
          await _sitesRepository.getUserListForSite(state.auditSummary!.siteId);

      reviewerList
          .removeWhere((element) => element.id == state.auditSummary!.ownerId);

      emit(state.copyWith(
          reviewerList: reviewerList
              .map((e) => User(
                  id: e.id,
                  firstName: e.name!.split(' ')[0],
                  lastName: e.name!.split(' ')[1]))
              .toList()));
    } catch (e) {}
  }

  void _onAuditDetailReviewerSelected(
    AuditDetailReviewerSelected event,
    Emitter<AuditDetailState> emit,
  ) {
    final List<User?> selectedReviewerList =
        List.from(state.selectedReviewerList);

    User? removedUser = selectedReviewerList.removeAt(event.index);

    selectedReviewerList.insert(event.index, event.reviewer);

    final List<User> reviewerList = List.from(state.reviewerList);

    reviewerList.removeWhere((element) => element.id == event.reviewer.id);

    if (removedUser != null) {
      reviewerList.add(removedUser);
    }

    emit(state.copyWith(
      selectedReviewerList: selectedReviewerList,
      reviewerList: reviewerList,
    ));
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

      if (auditSummary.auditStatusName == 'In Review') {
        add(AuditDetailReviewListLoaded());
      }

      if (!state.isEditable) {
        add(AuditDetailReviewerListLoaded());
      }
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
