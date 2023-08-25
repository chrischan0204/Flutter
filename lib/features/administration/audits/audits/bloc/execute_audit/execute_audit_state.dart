// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_bloc.dart';

class ExecuteAuditState extends Equatable {
  final AuditQuestionViewOption? auditQuestionViewOption;
  final Entity? selectedQuestionViewOption;
  final List<AuditQuestion> auditQuestionList;
  final EntityStatus auditQuestionListStatus;

  /// lists to create observation
  final List<PriorityLevel> priorityLevelList;
  final List<ObservationType> observationTypeList;
  final List<Site> siteList;

  /// lists to create action item
  final List<User> assigneeList;

  final List<AwarenessCategory> categoryList;

  const ExecuteAuditState({
    this.auditQuestionViewOption,
    this.selectedQuestionViewOption,
    this.auditQuestionList = const [],
    this.auditQuestionListStatus = EntityStatus.initial,
    this.priorityLevelList = const [],
    this.observationTypeList = const [],
    this.siteList = const [],
    this.assigneeList = const [],
    this.categoryList = const [],
  });

  List<Entity> get optionViewList {
    if (auditQuestionViewOption == null) {
      return [];
    }
    return [
      const Entity(name: '----- By Section -----'),
      ...auditQuestionViewOption!.sections
          .map((e) => Entity(
                id: e.id,
                name: e.name,
                active: true,
              ))
          .toList(),
      const Entity(name: '----- By Question Status -----'),
      ...auditQuestionViewOption!.statuses
          .map((e) => Entity(
                id: e.id,
                name: e.name,
                active: false,
              ))
          .toList(),
    ];
  }

  @override
  List<Object?> get props => [
        auditQuestionViewOption,
        selectedQuestionViewOption,
        auditQuestionList,
        auditQuestionListStatus,
        siteList,
        priorityLevelList,
        observationTypeList,
        assigneeList,
        categoryList,
      ];

  ExecuteAuditState copyWith({
    AuditQuestionViewOption? auditQuestionViewOption,
    Entity? selectedQuestionViewOption,
    List<AuditQuestion>? auditQuestionList,
    EntityStatus? auditQuestionListStatus,
    List<PriorityLevel>? priorityLevelList,
    List<ObservationType>? observationTypeList,
    List<Site>? siteList,
    List<User>? assigneeList,
    List<AwarenessCategory>? categoryList,
  }) {
    return ExecuteAuditState(
      auditQuestionViewOption:
          auditQuestionViewOption ?? this.auditQuestionViewOption,
      selectedQuestionViewOption:
          selectedQuestionViewOption ?? this.selectedQuestionViewOption,
      auditQuestionList: auditQuestionList ?? this.auditQuestionList,
      auditQuestionListStatus:
          auditQuestionListStatus ?? this.auditQuestionListStatus,
      priorityLevelList: priorityLevelList ?? this.priorityLevelList,
      observationTypeList: observationTypeList ?? this.observationTypeList,
      siteList: siteList ?? this.siteList,
      assigneeList: assigneeList ?? this.assigneeList,
      categoryList: categoryList ?? this.categoryList,
    );
  }
}
