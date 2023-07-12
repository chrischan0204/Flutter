import '/common_libraries.dart';

part 'execute_audit_event.dart';
part 'execute_audit_state.dart';

class ExecuteAuditBloc extends Bloc<ExecuteAuditEvent, ExecuteAuditState> {
  final BuildContext context;
  final String auditId;
  late AuditsRepository _auditsRepository;
  late AuthBloc _authBloc;
  ExecuteAuditBloc({
    required this.context,
    required this.auditId,
  }) : super(const ExecuteAuditState()) {
    _auditsRepository = context.read();
    _authBloc = context.read();

    on<ExecuteAuditQuestionViewOptionLoaded>(
        _onExecuteAuditQuestionViewOptionLoaded);
    on<ExecuteAuditQuestionViewOptionSelected>(
        _onExecuteAuditQuestionViewOptionSelected);
    on<ExecuteAuditQuestionMenuCollapsed>(_onExecuteAuditQuestionMenuCollapsed);
    on<ExecuteAuditFollowUpQuestionLoaded>(
        _onExecuteAuditFollowUpQuestionLoaded);
    on<ExecuteAuditLevelChanged>(_onExecuteAuditLevelChanged);
    on<ExecuteAuditResponseSelected>(_onExecuteAuditResponseSelected);
  }

  @override
  void onChange(Change<ExecuteAuditState> change) {
    final currentState = change.currentState;
    final nextState = change.nextState;

    print('current');
    print(currentState.followUpLevel1QuestionList);
    print(currentState.followUpLevel2QuestionList);
    print('next');
    print(nextState.followUpLevel1QuestionList);
    print(nextState.followUpLevel2QuestionList);

    super.onChange(change);
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
          followUpLevel1QuestionList:
              auditQuestionList.map((e) => null).toList(),
          followUpLevel2QuestionList:
              auditQuestionList.map((e) => null).toList(),
          selectedResponseList: auditQuestionList
              .map((e) => e.responseScaleItems
                      .where((element) => element.isSelected)
                      .isNotEmpty
                  ? e.responseScaleItems
                      .firstWhere((element) => element.isSelected)
                  : null)
              .toList(),
          selectedResponseListForFollowUpLevel1:
              auditQuestionList.map((e) => null).toList(),
          selectedResponseListForFollowUpLevel2:
              auditQuestionList.map((e) => null).toList(),
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

  void _onExecuteAuditFollowUpQuestionLoaded(
    ExecuteAuditFollowUpQuestionLoaded event,
    Emitter<ExecuteAuditState> emit,
  ) {
    List<AuditQuestion?> followUpLevel1QuestionList =
        List.from(state.followUpLevel1QuestionList);

    List<AuditQuestion?> followUpLevel2QuestionList =
        List.from(state.followUpLevel2QuestionList);

    if (followUpLevel1QuestionList[event.questionIndex] == null) {
      followUpLevel1QuestionList[event.questionIndex] = event.question;

      emit(state.copyWith(
        followUpLevel1QuestionList: followUpLevel1QuestionList,
        selectedResponseListForFollowUpLevel1: followUpLevel1QuestionList
            .map((e) => e == null
                ? null
                : e.responseScaleItems
                        .where((element) => element.isSelected)
                        .isNotEmpty
                    ? e.responseScaleItems
                        .firstWhere((element) => element.isSelected)
                    : null)
            .toList(),
      ));
    } else {
      followUpLevel2QuestionList[event.questionIndex] = event.question;

      emit(state.copyWith(
        followUpLevel2QuestionList: followUpLevel2QuestionList,
        selectedResponseListForFollowUpLevel2: followUpLevel2QuestionList
            .map((e) => e == null
                ? null
                : e.responseScaleItems
                        .where((element) => element.isSelected)
                        .isNotEmpty
                    ? e.responseScaleItems
                        .firstWhere((element) => element.isSelected)
                    : null)
            .toList(),
      ));
    }
  }

  void _onExecuteAuditLevelChanged(
    ExecuteAuditLevelChanged event,
    Emitter<ExecuteAuditState> emit,
  ) {
    List<AuditQuestion?> followUpLevel1QuestionList =
        List.from(state.followUpLevel1QuestionList);

    List<AuditQuestion?> followUpLevel2QuestionList =
        List.from(state.followUpLevel2QuestionList);

    followUpLevel2QuestionList[event.questionIndex] = null;
    if (event.isLevel0) {
      followUpLevel1QuestionList[event.questionIndex] = null;
    }

    emit(state.copyWith(
      followUpLevel1QuestionList: followUpLevel1QuestionList,
      followUpLevel2QuestionList: followUpLevel2QuestionList,
    ));
  }

  Future<void> _onExecuteAuditResponseSelected(
    ExecuteAuditResponseSelected event,
    Emitter<ExecuteAuditState> emit,
  ) async {
    EntityResponse response = await _auditsRepository
        .recordQuestionResponse(RecordQuestionResponseOnAudit(
      auditId: auditId,
      questionId: event.questionId,
      selectedResponseId: event.response.id,
      userId: _authBloc.state.authUser!.id,
    ));

    late List<AuditResponseScaleItem?> selectedResponseList;

    if (state.followUpLevel2QuestionList[event.questionIndex] != null) {
      selectedResponseList =
          List.from(state.selectedResponseListForFollowUpLevel2);

      selectedResponseList[event.questionIndex] = event.response;

      if (response.isSuccess) {
        emit(state.copyWith(
            selectedResponseListForFollowUpLevel2: selectedResponseList));
      }
    } else if (state.followUpLevel1QuestionList[event.questionIndex] != null) {
      selectedResponseList =
          List.from(state.selectedResponseListForFollowUpLevel1);

      selectedResponseList[event.questionIndex] = event.response;

      if (response.isSuccess) {
        emit(state.copyWith(
            selectedResponseListForFollowUpLevel1: selectedResponseList));
      }
    } else {
      selectedResponseList = List.from(state.selectedResponseList);

      selectedResponseList[event.questionIndex] = event.response;

      if (response.isSuccess) {
        emit(state.copyWith(selectedResponseList: selectedResponseList));
      }
    }
  }
}
