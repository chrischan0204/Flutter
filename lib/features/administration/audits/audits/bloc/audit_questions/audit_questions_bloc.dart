import '/common_libraries.dart';

part 'audit_questions_event.dart';
part 'audit_questions_state.dart';

class AuditQuestionsBloc
    extends Bloc<AuditQuestionsEvent, AuditQuestionsState> {
  final BuildContext context;
  late AuditsRepository auditsRepository;
  AuditQuestionsBloc(this.context) : super(const AuditQuestionsState()) {
    auditsRepository = context.read();

    on<AuditQuestionsSnapshotListLoaded>(_onAuditQuestionsSnapshotListLoaded);
    on<AuditQuestionsAuditSectionListLoaded>(
        _onAuditQuestionsAuditSectionListLoaded);
    on<AuditQuestionsSelectedAuditSectionChanged>(
        _onAuditQuestionsSelectedAuditSectionChanged);
    on<AuditQuestionsIncludedChanged>(_onAuditQuestionsIncludedChanged);
  }

  Future<void> _onAuditQuestionsSnapshotListLoaded(
    AuditQuestionsSnapshotListLoaded event,
    Emitter<AuditQuestionsState> emit,
  ) async {
    final auditQuestionSnapshotList =
        await auditsRepository.getAuditQuestionSnapshotList(event.auditId);

    emit(state.copyWith(auditQuestionSnapshotList: auditQuestionSnapshotList));
  }

  Future<void> _onAuditQuestionsAuditSectionListLoaded(
    AuditQuestionsAuditSectionListLoaded event,
    Emitter<AuditQuestionsState> emit,
  ) async {
    final auditSectionList =
        await auditsRepository.getAuditSectionList(event.auditId);

    emit(state.copyWith(
      auditSectionList: auditSectionList,
      selectedAuditSection:
          auditSectionList.isNotEmpty ? auditSectionList.first : null,
    ));
  }

  void _onAuditQuestionsSelectedAuditSectionChanged(
    AuditQuestionsSelectedAuditSectionChanged event,
    Emitter<AuditQuestionsState> emit,
  ) {
    emit(state.copyWith(selectedAuditSection: event.auditSection));
  }

  void _onAuditQuestionsIncludedChanged(
    AuditQuestionsIncludedChanged event,
    Emitter<AuditQuestionsState> emit,
  ) {
    if (event.questionId != null) {
      emit(state.copyWith(
          selectedAuditSection: state.selectedAuditSection!.copyWith(
              auditQuestionList: state.selectedAuditSection!.auditQuestionList
                  .map((question) => question.id == event.questionId
                      ? question.copyWith(included: !question.included)
                      : question)
                  .toList()),
          auditSectionList: state.auditSectionList
              .map((e) => e.copyWith(
                  auditQuestionList: e.auditQuestionList
                      .map((question) => question.id == event.questionId
                          ? question.copyWith(included: !question.included)
                          : question)
                      .toList()))
              .toList()));
    } else {
      emit(state.copyWith(
          selectedAuditSection: state.selectedAuditSection!.copyWith(
              auditQuestionList: state.selectedAuditSection!.auditQuestionList
                  .map((question) =>
                      question.copyWith(included: state.isAllExcluded))
                  .toList()),
          auditSectionList: state.auditSectionList
              .map((e) => e.id == state.selectedAuditSection!.id
                  ? e.copyWith(
                      auditQuestionList: e.auditQuestionList
                          .map((question) =>
                              question.copyWith(included: state.isAllExcluded))
                          .toList())
                  : e)
              .toList()));
    }
  }
}
