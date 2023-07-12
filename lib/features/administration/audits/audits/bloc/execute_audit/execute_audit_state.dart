// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_bloc.dart';

class ExecuteAuditState extends Equatable {
  final AuditQuestionViewOption? auditQuestionViewOption;
  final Entity? selectedQuestionViewOption;
  final List<AuditQuestion> auditQuestionList;
  final EntityStatus auditQuestionListStatus;
  final List<bool> collapsibleList;
  const ExecuteAuditState({
    this.auditQuestionViewOption,
    this.selectedQuestionViewOption,
    this.auditQuestionList = const [],
    this.auditQuestionListStatus = EntityStatus.initial,
    this.collapsibleList = const [],
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
        collapsibleList,
      ];

  ExecuteAuditState copyWith({
    AuditQuestionViewOption? auditQuestionViewOption,
    Entity? selectedQuestionViewOption,
    List<AuditQuestion>? auditQuestionList,
    EntityStatus? auditQuestionListStatus,
    List<bool>? collapsibleList,
  }) {
    return ExecuteAuditState(
      auditQuestionViewOption:
          auditQuestionViewOption ?? this.auditQuestionViewOption,
      selectedQuestionViewOption:
          selectedQuestionViewOption ?? this.selectedQuestionViewOption,
      auditQuestionList: auditQuestionList ?? this.auditQuestionList,
      auditQuestionListStatus:
          auditQuestionListStatus ?? this.auditQuestionListStatus,
      collapsibleList: collapsibleList ?? this.collapsibleList,
    );
  }
}
