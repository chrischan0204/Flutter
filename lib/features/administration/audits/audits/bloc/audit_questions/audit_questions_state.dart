// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_questions_bloc.dart';

class AuditQuestionsState extends Equatable {
  final List<AuditQuestionSnapshot> auditQuestionSnapshotList;
  final List<AuditSection> auditSectionList;
  final AuditSection? selectedAuditSection;

  final List<AuditQuestion> auditQuestionList;
  const AuditQuestionsState({
    this.auditQuestionSnapshotList = const [],
    this.auditSectionList = const [],
    this.selectedAuditSection,
    this.auditQuestionList = const [],
  });

  @override
  List<Object?> get props => [
        auditQuestionSnapshotList,
        auditSectionList,
        selectedAuditSection,
        auditQuestionList,
      ];

  bool get isAllExcluded => selectedAuditSection!.auditQuestionList
      .where((element) => element.questionIncluded)
      .isEmpty;

  List<AuditQuestionSnapshot> get snapshotList => auditSectionList
      .map((section) => AuditQuestionSnapshot(
            section: section.name,
            totalQuestionCount: section.auditQuestionList.length,
            includedQuestionCount: section.auditQuestionList
                .where((element) => element.questionIncluded)
                .length,
            maxScore: [
              ...section.auditQuestionList.map((e) => e.questionScore),
              0.0,
            ].reduce((value, element) => value > element ? value : element),
            includedScore: [
              ...section.auditQuestionList
                  .where((element) => element.questionIncluded)
                  .map((e) => e.questionScore),
              0.0,
            ].reduce((value, element) => value + element),
          ))
      .toList();

  AuditQuestionsState copyWith({
    List<AuditQuestionSnapshot>? auditQuestionSnapshotList,
    List<AuditSection>? auditSectionList,
    AuditSection? selectedAuditSection,
    List<AuditQuestion>? auditQuestionList,
  }) {
    return AuditQuestionsState(
      auditQuestionSnapshotList:
          auditQuestionSnapshotList ?? this.auditQuestionSnapshotList,
      auditSectionList: auditSectionList ?? this.auditSectionList,
      selectedAuditSection: selectedAuditSection ?? this.selectedAuditSection,
      auditQuestionList: auditQuestionList ?? this.auditQuestionList,
    );
  }
}
