// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_bloc.dart';

abstract class ExecuteAuditEvent extends Equatable {
  const ExecuteAuditEvent();

  @override
  List<Object> get props => [];
}

class ExecuteAuditQuestionViewOptionLoaded extends ExecuteAuditEvent {}

class ExecuteAuditQuestionViewOptionSelected extends ExecuteAuditEvent {
  final Entity questionViewOption;
  const ExecuteAuditQuestionViewOptionSelected({
    required this.questionViewOption,
  });

  @override
  List<Object> get props => [questionViewOption];
}

class ExecuteAuditQuestionMenuCollapsed extends ExecuteAuditEvent {
  final int index;
  const ExecuteAuditQuestionMenuCollapsed({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class ExecuteAuditFollowUpQuestionLoaded extends ExecuteAuditEvent {
  final AuditQuestion question;
  final int questionIndex;

  const ExecuteAuditFollowUpQuestionLoaded({
    required this.question,
    required this.questionIndex,
  });

  @override
  List<Object> get props => [
        question,
        questionIndex,
      ];
}

class ExecuteAuditLevelChanged extends ExecuteAuditEvent {
  final int questionIndex;
  final bool isLevel0;

  const ExecuteAuditLevelChanged({
    required this.questionIndex,
    required this.isLevel0,
  });

  @override
  List<Object> get props => [
        questionIndex,
        isLevel0,
      ];
}

class ExecuteAuditResponseSelected extends ExecuteAuditEvent {
  final int questionIndex;
  final AuditResponseScaleItem response;
  final String questionId;

  const ExecuteAuditResponseSelected({
    required this.questionIndex,
    required this.response,
    required this.questionId,
  });

  @override
  List<Object> get props => [
        questionIndex,
        response,
        questionId,
      ];
}
