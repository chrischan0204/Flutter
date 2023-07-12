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

