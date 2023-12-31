import '/common_libraries.dart';

part 'execute_audit_event.dart';
part 'execute_audit_state.dart';

class ExecuteAuditBloc extends Bloc<ExecuteAuditEvent, ExecuteAuditState> {
  final BuildContext context;
  final String auditId;
  late AuditsRepository _auditsRepository;
  late PriorityLevelsRepository _priorityLevelsRepository;
  late ObservationTypesRepository _observationTypesRepository;
  late SitesRepository _sitesRepository;
  late UsersRepository _usersRepository;
  late AwarenessCategoriesRepository _awarenessCategoriesRepository;
  ExecuteAuditBloc({
    required this.context,
    required this.auditId,
  }) : super(const ExecuteAuditState()) {
    _auditsRepository = context.read();
    _priorityLevelsRepository = context.read();
    _observationTypesRepository = context.read();
    _sitesRepository = context.read();
    _usersRepository = context.read();
    _awarenessCategoriesRepository = context.read();

    on<ExecuteAuditQuestionViewOptionLoaded>(
        _onExecuteAuditQuestionViewOptionLoaded);
    on<ExecuteAuditQuestionViewOptionSelected>(
        _onExecuteAuditQuestionViewOptionSelected);
    on<ExecuteAuditPriorityLevelListLoaded>(
        _onExecuteAuditPriorityLevelListLoaded);
    on<ExecuteAuditObservationTypeListLoaded>(
        _onExecuteAuditObservationTypeListLoaded);
    on<ExecuteAuditSiteListLoaded>(_onExecuteAuditSiteListLoaded);
    on<ExecuteAuditAssigneeListLoaded>(_onExecuteAuditAssigneeListLoaded);
    on<ExecuteAuditCategoryListLoaded>(_onExecuteAuditCategoryListLoaded);
  }

  @override
  void onChange(Change<ExecuteAuditState> change) {
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
          auditQuestionListStatus: EntityStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          auditQuestionListStatus: EntityStatus.failure,
        ));
      }
    }
  }

  Future<void> _onExecuteAuditPriorityLevelListLoaded(
    ExecuteAuditPriorityLevelListLoaded event,
    Emitter<ExecuteAuditState> emit,
  ) async {
    try {
      List<Entity> priorityLevelList =
          await _priorityLevelsRepository.getActivePriorityLevelList();

      emit(state.copyWith(
          priorityLevelList: priorityLevelList
              .map((e) => PriorityLevel(
                    colorCode: Colors.white,
                    priorityType: '',
                    id: e.id,
                    name: e.name,
                  ))
              .toList()));
    } catch (e) {}
  }

  Future<void> _onExecuteAuditObservationTypeListLoaded(
    ExecuteAuditObservationTypeListLoaded event,
    Emitter<ExecuteAuditState> emit,
  ) async {
    try {
      List<Entity> observationTypeList =
          await _observationTypesRepository.getActiveObservationTypeList();

      emit(state.copyWith(
        observationTypeList: observationTypeList
            .map((e) => ObservationType(severity: '', id: e.id, name: e.name))
            .toList(),
      ));
    } catch (e) {}
  }

  Future<void> _onExecuteAuditSiteListLoaded(
    ExecuteAuditSiteListLoaded event,
    Emitter<ExecuteAuditState> emit,
  ) async {
    try {
      List<Entity> siteList = await _sitesRepository.getActiveSiteList();

      emit(state.copyWith(
          siteList:
              siteList.map((e) => Site(id: e.id, name: e.name)).toList()));
    } catch (e) {}
  }

  Future<void> _onExecuteAuditAssigneeListLoaded(
    ExecuteAuditAssigneeListLoaded event,
    Emitter<ExecuteAuditState> emit,
  ) async {
    try {
      List<User> assigneeList = await _usersRepository.getUserList();

      emit(state.copyWith(assigneeList: assigneeList));
    } catch (e) {}
  }

  Future<void> _onExecuteAuditCategoryListLoaded(
    ExecuteAuditCategoryListLoaded event,
    Emitter<ExecuteAuditState> emit,
  ) async {
    try {
      List<Entity> categoryList = await _awarenessCategoriesRepository
          .getActiveAwarenessCategorieList();

      emit(state.copyWith(
          categoryList: categoryList
              .map((e) => AwarenessCategory(id: e.id, name: e.name))
              .toList()));
    } catch (e) {}
  }
}
