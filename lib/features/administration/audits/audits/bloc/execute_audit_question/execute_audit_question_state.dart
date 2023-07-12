// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_question_bloc.dart';

class ExecuteAuditQuestionState extends Equatable {
  final AuditQuestion auditQuestion;
  final EntityStatus questionLoadStatus;
  final int level;
  const ExecuteAuditQuestionState({
    required this.auditQuestion,
    this.questionLoadStatus = EntityStatus.initial,
    this.level = 0,
  });

  @override
  List<Object?> get props => [
        auditQuestion,
        questionLoadStatus,
        level,
      ];

  ExecuteAuditQuestionState copyWith({
    AuditQuestion? auditQuestion,
    EntityStatus? questionLoadStatus,
    int? level,
  }) {
    return ExecuteAuditQuestionState(
      auditQuestion: auditQuestion ?? this.auditQuestion,
      questionLoadStatus: questionLoadStatus ?? this.questionLoadStatus,
      level: level ?? this.level,
    );
  }
}
