import '/common_libraries.dart';

part 'execute_audit_event.dart';
part 'execute_audit_state.dart';

class ExecuteAuditBloc extends Bloc<ExecuteAuditEvent, ExecuteAuditState> {
  final BuildContext context;
  final String auditId;
  late AuditsRepository _auditsRepository;
  ExecuteAuditBloc({
    required this.context,
    required this.auditId,
  }) : super(const ExecuteAuditState()) {
    _auditsRepository = context.read();

    on<ExecuteAuditQuestionViewOptionLoaded>(
        _onExecuteAuditQuestionViewOptionLoaded);
    on<ExecuteAuditQuestionViewOptionSelected>(
        _onExecuteAuditQuestionViewOptionSelected);
    on<ExecuteAuditQuestionMenuCollapsed>(_onExecuteAuditQuestionMenuCollapsed);
  }

  Future<void> _onExecuteAuditQuestionViewOptionLoaded(
    ExecuteAuditQuestionViewOptionLoaded event,
    Emitter<ExecuteAuditState> emit,
  ) async {
    final auditQuestionViewOption =
        await _auditsRepository.getQuestionViewOptionList(auditId);

    emit(state.copyWith(auditQuestionViewOption: auditQuestionViewOption));
  }

  Future<void> _onExecuteAuditQuestionViewOptionSelected(
    ExecuteAuditQuestionViewOptionSelected event,
    Emitter<ExecuteAuditState> emit,
  ) async {
    emit(state.copyWith(selectedQuestionViewOption: event.questionViewOption));

    if (event.questionViewOption.id?.isEmpty == false &&
        event.questionViewOption.id != emptyGuid) {
      emit(state.copyWith(auditQuestionListStatus: EntityStatus.loading));

      try {
        List<AuditQuestion> auditQuestionList = await _auditsRepository
            .getAuditQuestionListForExecute(QuestionsForViewOptionParameter(
          auditId: auditId,
          optionType: event.questionViewOption.active ? 'section' : 'status',
          optionId: event.questionViewOption.id!,
        ));

        emit(state.copyWith(
          auditQuestionList: auditQuestionList,
          auditQuestionListStatus: EntityStatus.success,
          collapsibleList: auditQuestionList.map((e) => false).toList(),
        ));
      } catch (e) {
        emit(state.copyWith(
          auditQuestionListStatus: EntityStatus.failure,
        ));
      }
    }
  }

  void _onExecuteAuditQuestionMenuCollapsed(
    ExecuteAuditQuestionMenuCollapsed event,
    Emitter<ExecuteAuditState> emit,
  ) {
    final List<bool> collapsibleList = List.from(state.collapsibleList);

    collapsibleList[event.index] = !collapsibleList[event.index];
    emit(state.copyWith(collapsibleList: collapsibleList));
  }
}
