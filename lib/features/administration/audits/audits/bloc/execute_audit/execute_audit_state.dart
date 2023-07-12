// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_bloc.dart';

class ExecuteAuditState extends Equatable {
  final AuditQuestionViewOption? auditQuestionViewOption;
  final Entity? selectedQuestionViewOption;
  final List<AuditQuestion> auditQuestionList;
  final EntityStatus auditQuestionListStatus;
  final List<bool> collapsibleList;
  final List<AuditQuestion?> followUpLevel1QuestionList;
  final List<AuditQuestion?> followUpLevel2QuestionList;
  final List<AuditResponseScaleItem?> selectedResponseList;
  final List<AuditResponseScaleItem?> selectedResponseListForFollowUpLevel1;
  final List<AuditResponseScaleItem?> selectedResponseListForFollowUpLevel2;
  const ExecuteAuditState({
    this.auditQuestionViewOption,
    this.selectedQuestionViewOption,
    this.auditQuestionList = const [],
    this.auditQuestionListStatus = EntityStatus.initial,
    this.collapsibleList = const [],
    this.followUpLevel1QuestionList = const [],
    this.followUpLevel2QuestionList = const [],
    this.selectedResponseList = const [],
    this.selectedResponseListForFollowUpLevel1 = const [],
    this.selectedResponseListForFollowUpLevel2 = const [],
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
        followUpLevel1QuestionList,
        followUpLevel2QuestionList,
        selectedResponseList,
        selectedResponseListForFollowUpLevel1,
        selectedResponseListForFollowUpLevel2,
      ];

  ExecuteAuditState copyWith({
    AuditQuestionViewOption? auditQuestionViewOption,
    Entity? selectedQuestionViewOption,
    List<AuditQuestion>? auditQuestionList,
    EntityStatus? auditQuestionListStatus,
    List<bool>? collapsibleList,
    List<AuditQuestion?>? followUpLevel1QuestionList,
    List<AuditQuestion?>? followUpLevel2QuestionList,
    List<AuditResponseScaleItem?>? selectedResponseList,
    List<AuditResponseScaleItem?>? selectedResponseListForFollowUpLevel1,
    List<AuditResponseScaleItem?>? selectedResponseListForFollowUpLevel2,
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
      followUpLevel1QuestionList:
          followUpLevel1QuestionList ?? this.followUpLevel1QuestionList,
      followUpLevel2QuestionList:
          followUpLevel2QuestionList ?? this.followUpLevel2QuestionList,
      selectedResponseList: selectedResponseList ?? this.selectedResponseList,
      selectedResponseListForFollowUpLevel1:
          selectedResponseListForFollowUpLevel1 ??
              this.selectedResponseListForFollowUpLevel1,
      selectedResponseListForFollowUpLevel2:
          selectedResponseListForFollowUpLevel2 ??
              this.selectedResponseListForFollowUpLevel2,
    );
  }
}
