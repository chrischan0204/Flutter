import '/common_libraries.dart';

part 'audit_questions_event.dart';
part 'audit_questions_state.dart';

class AuditQuestionsBloc
    extends Bloc<AuditQuestionsEvent, AuditQuestionsState> {
  final BuildContext context;
  final String auditId;
  late AuditsRepository auditsRepository;
  late String userId;
  AuditQuestionsBloc(this.context, {required this.auditId})
      : super(const AuditQuestionsState()) {
    auditsRepository = context.read();
    userId = context.read<AuthBloc>().state.authUser!.id;

    on<AuditQuestionsAuditSectionListLoaded>(
        _onAuditQuestionsAuditSectionListLoaded);
    on<AuditQuestionsSelectedAuditSectionChanged>(
        _onAuditQuestionsSelectedAuditSectionChanged);
    on<AuditQuestionsIncludedChanged>(_onAuditQuestionsIncludedChanged);
    on<AuditQuestionsCopied>(_onAuditQuestionsCopied);
    on<AuditQuestionsAuditQuestionListLoaded>(
        _onAuditQuestionsAuditQuestionListLoaded);
    on<AuditQuestionsSectionIncludedChanged>(
        _onAuditQuestionsSectionIncludedChanged);
  }

  @override
  void onChange(Change<AuditQuestionsState> change) {
    final current = change.currentState;
    final next = change.nextState;

    if (current.selectedAuditSectionId != next.selectedAuditSectionId &&
        next.selectedAuditSectionId != null) {
      add(AuditQuestionsAuditQuestionListLoaded());
    }

    super.onChange(change);
  }

  Future<void> _onAuditQuestionsAuditSectionListLoaded(
    AuditQuestionsAuditSectionListLoaded event,
    Emitter<AuditQuestionsState> emit,
  ) async {
    final auditSectionList =
        await auditsRepository.getAuditSectionList(event.auditId);

    emit(state.copyWith(
      auditSectionList: auditSectionList,
      selectedAuditSectionId:
          state.selectedAuditSectionId == null && auditSectionList.isNotEmpty
              ? auditSectionList.first.id
              : null,
    ));
  }

  Future<void> _onAuditQuestionsAuditQuestionListLoaded(
    AuditQuestionsAuditQuestionListLoaded event,
    Emitter<AuditQuestionsState> emit,
  ) async {
    final auditQuestionList = await auditsRepository.getAuditQuestionList(
        auditId, state.selectedAuditSectionId!);

    emit(state.copyWith(auditQuestionList: auditQuestionList));
  }

  Future<void> _onAuditQuestionsSelectedAuditSectionChanged(
    AuditQuestionsSelectedAuditSectionChanged event,
    Emitter<AuditQuestionsState> emit,
  ) async {
    emit(state.copyWith(selectedAuditSectionId: event.auditSection.id));
  }

  Future<void> _onAuditQuestionsIncludedChanged(
    AuditQuestionsIncludedChanged event,
    Emitter<AuditQuestionsState> emit,
  ) async {
    try {
      EntityResponse response =
          await auditsRepository.toggleIncludeQuestion(AuditQuestionAssociation(
        auditId: auditId,
        questionId: event.questionId,
        userId: userId,
        isIncluded: event.isIncluded,
      ));

      if (response.isSuccess) {
        add(AuditQuestionsAuditSectionListLoaded(auditId: auditId));
        add(AuditQuestionsAuditQuestionListLoaded());
      }
    } catch (e) {}
  }

  Future<void> _onAuditQuestionsSectionIncludedChanged(
    AuditQuestionsSectionIncludedChanged event,
    Emitter<AuditQuestionsState> emit,
  ) async {
    try {
      EntityResponse response =
          await auditsRepository.toggleIncludeSection(AuditSectionAssociation(
        auditId: auditId,
        sectionId: event.sectionId,
        userId: userId,
        isIncluded: event.isIncluded,
      ));

      if (response.isSuccess) {
        add(AuditQuestionsAuditSectionListLoaded(auditId: auditId));
        add(AuditQuestionsAuditQuestionListLoaded());
      }
    } catch (e) {}
  }

  Future<void> _onAuditQuestionsCopied(
      AuditQuestionsCopied event, Emitter<AuditQuestionsState> emit) async {
    emit(state.copyWith(status: EntityStatus.loading));

    EntityResponse response =
        await auditsRepository.copySection(auditId, event.sectionId);

    if (response.isSuccess) {
      emit(state.copyWith(
        status: EntityStatus.success,
        message: response.message,
      ));
    }

    // if (response.isSuccess) {
    //   for (final question in state.auditQuestionList) {
    //     if (question.isNew) {
    //       await auditsRepository.copyQuestion(auditId, question.id);
    //     }
    //   }
    // }
  }
}
