// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_questions_bloc.dart';

class AuditQuestionsState extends Equatable {
  final List<AuditQuestionSnapshot> auditQuestionSnapshotList;
  const AuditQuestionsState({
    this.auditQuestionSnapshotList = const [],
  });

  @override
  List<Object> get props => [auditQuestionSnapshotList];

  AuditQuestionsState copyWith({
    List<AuditQuestionSnapshot>? auditQuestionSnapshotList,
  }) {
    return AuditQuestionsState(
      auditQuestionSnapshotList:
          auditQuestionSnapshotList ?? this.auditQuestionSnapshotList,
    );
  }
}
