import '/common_libraries.dart';

part 'audit_questions_event.dart';
part 'audit_questions_state.dart';

class AuditQuestionsBloc
    extends Bloc<AuditQuestionsEvent, AuditQuestionsState> {
  final BuildContext context;
  final String auditId;
  late AuditsRepository auditsRepository;
  late String userId;
  late AuditDetailBloc _auditDetailBloc;
  AuditQuestionsBloc(this.context, {required this.auditId})
      : super(const AuditQuestionsState()) {
    auditsRepository = context.read();
    userId = context.read<AuthBloc>().state.authUser!.id;
    _auditDetailBloc = context.read();

    on<AuditQuestionsAuditSectionListLoaded>(
        _onAuditQuestionsAuditSectionListLoaded);
    on<AuditQuestionsSelectedAuditSectionChanged>(
        _onAuditQuestionsSelectedAuditSectionChanged);
    on<AuditQuestionsIncludedChanged>(_onAuditQuestionsIncludedChanged);
    on<AuditQuestionCopied>(_onAuditQuestionCopied);
    on<AuditSectionCopied>(_onAuditSectionCopied);
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
        await auditsRepository.getAuditSectionList(auditId);

    auditSectionList.sort((first, second) => first.name.compareTo(second.name));

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
    emit(state.copyWith(questionListLoadStatus: EntityStatus.loading));
    try {
      final auditQuestionList = await auditsRepository.getAuditQuestionList(
          auditId, state.selectedAuditSectionId!);

      emit(state.copyWith(
        auditQuestionList: auditQuestionList,
        questionListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {}
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
        _getInformation();
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
        _getInformation();
      }
    } catch (e) {}
  }

  Future<void> _onAuditQuestionCopied(
      AuditQuestionCopied event, Emitter<AuditQuestionsState> emit) async {
    emit(state.copyWith(status: EntityStatus.loading));

    EntityResponse response =
        await auditsRepository.copyQuestion(auditId, event.questionId);

    if (response.isSuccess) {
      _getInformation();
    }
  }

  Future<void> _onAuditSectionCopied(
      AuditSectionCopied event, Emitter<AuditQuestionsState> emit) async {
    emit(state.copyWith(status: EntityStatus.loading));

    EntityResponse response =
        await auditsRepository.copySection(auditId, event.sectionId);

    if (response.isSuccess) {
      _getInformation();
    }
  }

  void _getInformation() {
    add(AuditQuestionsAuditSectionListLoaded());
    add(AuditQuestionsAuditQuestionListLoaded());
    _auditDetailBloc.add(AuditDetailAuditSectionListLoaded());
    _auditDetailBloc.add(AuditDetailLoaded(auditId: auditId));
  }
}
