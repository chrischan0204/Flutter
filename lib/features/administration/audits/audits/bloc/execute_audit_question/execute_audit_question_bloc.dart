import '/common_libraries.dart';

part 'execute_audit_question_event.dart';
part 'execute_audit_question_state.dart';

class ExecuteAuditQuestionBloc
    extends Bloc<ExecuteAuditQuestionEvent, ExecuteAuditQuestionState> {
  final BuildContext context;
  final String auditId;
  final AuditQuestion auditQuestion;

  late AuditsRepository _auditsRepository;
  late AuthBloc _authBloc;
  ExecuteAuditQuestionBloc({
    required this.context,
    required this.auditId,
    required this.auditQuestion,
  }) : super(ExecuteAuditQuestionState(
          level0: auditQuestion,
          selectedlevel0Response: auditQuestion.responseScaleItems
                  .where(
                    (element) => element.isSelected,
                  )
                  .isNotEmpty
              ? auditQuestion.responseScaleItems.firstWhere(
                  (element) => element.isSelected,
                )
              : null,
        )) {
    _auditsRepository = context.read();
    _authBloc = context.read();

    on<ExecuteAuditQuestionLoaded>(_onExecuteAuditQuestionLoaded);
    on<ExecuteAuditQuestionResponseSelected>(
        _onExecuteAuditQuestionResponseSelected);
    on<ExecuteAuditQuestionLevelChanged>(_onExecuteAuditQuestionLevelChanged);
  }

  Future<void> _onExecuteAuditQuestionLoaded(
    ExecuteAuditQuestionLoaded event,
    Emitter<ExecuteAuditQuestionState> emit,
  ) async {
    emit(state.copyWith(questionLoadStatus: EntityStatus.loading));

    try {
      final question = await _auditsRepository
          .getFollowupAuditQuestionForExecute(auditId, event.responseId);

      final selectedResponse = Nullable.value(question.responseScaleItems
              .where((element) => element.isSelected)
              .isNotEmpty
          ? question.responseScaleItems
              .firstWhere((element) => element.isSelected)
          : null);

      if (state.level == 0) {
        emit(state.copyWith(
          level1Followup: Nullable.value(question),
          selectedlevel1Response: selectedResponse,
        ));
      } else if (state.level == 1) {
        emit(state.copyWith(
          level2Followup: Nullable.value(question),
          selectedlevel2Response: selectedResponse,
        ));
      }

      emit(state.copyWith(
        level: state.level + 1,
        questionLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(questionLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onExecuteAuditQuestionLevelChanged(
    ExecuteAuditQuestionLevelChanged event,
    Emitter<ExecuteAuditQuestionState> emit,
  ) async {
    if (event.level == 0) {
      emit(state.copyWith(
        level1Followup: const Nullable.value(null),
        level2Followup: const Nullable.value(null),
      ));
    } else if (event.level == 1) {
      emit(state.copyWith(
        level2Followup: const Nullable.value(null),
      ));
    }

    emit(state.copyWith(level: event.level));
  }

  Future<void> _onExecuteAuditQuestionResponseSelected(
    ExecuteAuditQuestionResponseSelected event,
    Emitter<ExecuteAuditQuestionState> emit,
  ) async {
    EntityResponse response = await _auditsRepository
        .recordQuestionResponse(RecordQuestionResponseOnAudit(
      auditId: auditId,
      questionId: auditQuestion.id,
      selectedResponseId: event.response.id,
      userId: _authBloc.state.authUser!.id,
    ));

    if (response.isSuccess) {
      if (state.level == 0) {
        emit(state.copyWith(
            selectedlevel0Response: Nullable.value(event.response)));
      } else if (state.level == 1) {
        emit(state.copyWith(
            selectedlevel1Response: Nullable.value(event.response)));
      } else {
        emit(state.copyWith(
            selectedlevel2Response: Nullable.value(event.response)));
      }
    }
  }
}
