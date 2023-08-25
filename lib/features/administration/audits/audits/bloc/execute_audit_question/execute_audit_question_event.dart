// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_question_bloc.dart';

abstract class ExecuteAuditQuestionEvent extends Equatable {
  const ExecuteAuditQuestionEvent();

  @override
  List<Object> get props => [];
}

/// event to load audit question
class ExecuteAuditQuestionLoaded extends ExecuteAuditQuestionEvent {
  final String responseId;

  const ExecuteAuditQuestionLoaded({
    required this.responseId,
  });

  @override
  List<Object> get props => [responseId];
}

/// event to select question response
class ExecuteAuditQuestionResponseSelected extends ExecuteAuditQuestionEvent {
  final AuditResponseScaleItem response;

  const ExecuteAuditQuestionResponseSelected({required this.response});

  @override
  List<Object> get props => [response];
}

/// event to change question level
class ExecuteAuditQuestionLevelChanged extends ExecuteAuditQuestionEvent {
  final int level;
  const ExecuteAuditQuestionLevelChanged({required this.level});

  @override
  List<Object> get props => [level];
}

/// event to load question detail
class ExecuteAuditQuestionDetailLoaded extends ExecuteAuditQuestionEvent {
  final String questionId;
  const ExecuteAuditQuestionDetailLoaded({required this.questionId});

  @override
  List<Object> get props => [questionId];
}
