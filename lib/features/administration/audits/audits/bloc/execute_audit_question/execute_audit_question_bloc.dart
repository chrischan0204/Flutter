import '/common_libraries.dart';

part 'execute_audit_question_event.dart';
part 'execute_audit_question_state.dart';

class ExecuteAuditQuestionBloc
    extends Bloc<ExecuteAuditQuestionEvent, ExecuteAuditQuestionState> {
  final BuildContext context;
  final String auditId;
  final AuditQuestion auditQuestion;

  late ExecuteAuditBloc _executeAuditBloc;
  late AuthBloc _authBloc;
  late AuditsRepository _auditsRepository;
  ExecuteAuditQuestionBloc({
    required this.context,
    required this.auditId,
    required this.auditQuestion,
  }) : super(ExecuteAuditQuestionState(
          auditQuestion: auditQuestion,
          selectedResponse: auditQuestion.responseScaleItems
                  .where((element) => element.isSelected)
                  .isNotEmpty
              ? auditQuestion.responseScaleItems
                  .firstWhere((element) => element.isSelected)
              : null,
        )) {
    _authBloc = context.read();
    _executeAuditBloc = context.read();
    _auditsRepository = context.read();

    on<ExecuteAuditQuestionLoaded>(_onExecuteAuditQuestionLoaded);
    on<ExecuteAuditQuestionResponseSelected>(
        _onExecuteAuditQuestionResponseSelected);
  }

  Future<void> _onExecuteAuditQuestionLoaded(
    ExecuteAuditQuestionLoaded event,
    Emitter<ExecuteAuditQuestionState> emit,
  ) async {
    emit(state.copyWith(questionLoadStatus: EntityStatus.loading));

    try {
      final question = await _auditsRepository
          .getFollowupAuditQuestionForExecute(auditId, event.responseId);

      emit(state.copyWith(
        auditQuestion: question,
        questionLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(questionLoadStatus: EntityStatus.failure));
    }
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
      emit(state.copyWith(selectedResponse: event.response));
    }
  }
}
