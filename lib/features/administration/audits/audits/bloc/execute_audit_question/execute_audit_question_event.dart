part of 'execute_audit_question_bloc.dart';

abstract class ExecuteAuditQuestionEvent extends Equatable {
  const ExecuteAuditQuestionEvent();

  @override
  List<Object> get props => [];
}

class ExecuteAuditQuestionLoaded extends ExecuteAuditQuestionEvent {
  final String responseId;
  final int questionIndex;

  const ExecuteAuditQuestionLoaded({
    required this.responseId,
    required this.questionIndex,
  });

  @override
  List<Object> get props => [
        responseId,
        questionIndex,
      ];
}

