part of 'execute_audit_question_bloc.dart';

class ExecuteAuditQuestionState extends Equatable {
  final AuditQuestion auditQuestion;
  final EntityStatus questionLoadStatus;
  final AuditResponseScaleItem? selectedResponse;
  const ExecuteAuditQuestionState({
    required this.auditQuestion,
    this.questionLoadStatus = EntityStatus.initial,
    this.selectedResponse,
  });

  @override
  List<Object?> get props => [
        auditQuestion,
        questionLoadStatus,
        selectedResponse,
      ];

  ExecuteAuditQuestionState copyWith({
    AuditQuestion? auditQuestion,
    EntityStatus? questionLoadStatus,
    AuditResponseScaleItem? selectedResponse,
  }) {
    return ExecuteAuditQuestionState(
      auditQuestion:
          auditQuestion ?? this.auditQuestion,
      questionLoadStatus: questionLoadStatus ?? this.questionLoadStatus,
      selectedResponse: selectedResponse ?? this.selectedResponse,
    );
  }
}
