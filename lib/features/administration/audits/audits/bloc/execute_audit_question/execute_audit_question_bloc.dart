import '/common_libraries.dart';

part 'execute_audit_question_event.dart';
part 'execute_audit_question_state.dart';

class ExecuteAuditQuestionBloc
    extends Bloc<ExecuteAuditQuestionEvent, ExecuteAuditQuestionState> {
  final BuildContext context;
  final String auditId;
  final AuditQuestion auditQuestion;

  late ExecuteAuditBloc _executeAuditBloc;
  late AuditsRepository _auditsRepository;
  ExecuteAuditQuestionBloc({
    required this.context,
    required this.auditId,
    required this.auditQuestion,
  }) : super(ExecuteAuditQuestionState(
          auditQuestion: auditQuestion,
        )) {
    _executeAuditBloc = context.read();
    _auditsRepository = context.read();

    on<ExecuteAuditQuestionLoaded>(_onExecuteAuditQuestionLoaded);
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

      _executeAuditBloc.add(ExecuteAuditFollowUpQuestionLoaded(
        question: question,
        questionIndex: event.questionIndex,
      ));
    } catch (e) {
      emit(state.copyWith(questionLoadStatus: EntityStatus.failure));
    }
  }
}
