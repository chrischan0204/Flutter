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

class ExecuteAuditPriorityLevelListLoaded extends ExecuteAuditEvent {}

class ExecuteAuditObservationTypeListLoaded extends ExecuteAuditEvent {}

class ExecuteAuditSiteListLoaded extends ExecuteAuditEvent {}

class ExecuteAuditAssigneeListLoaded extends ExecuteAuditEvent {}

class ExecuteAuditCategoryListLoaded extends ExecuteAuditEvent {}
