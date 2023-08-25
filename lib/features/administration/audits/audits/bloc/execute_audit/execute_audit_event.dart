part of 'execute_audit_bloc.dart';

abstract class ExecuteAuditEvent extends Equatable {
  const ExecuteAuditEvent();

  @override
  List<Object> get props => [];
}

/// event to load question view option
class ExecuteAuditQuestionViewOptionLoaded extends ExecuteAuditEvent {}

/// event to select view option
class ExecuteAuditQuestionViewOptionSelected extends ExecuteAuditEvent {
  final Entity questionViewOption;
  const ExecuteAuditQuestionViewOptionSelected({
    required this.questionViewOption,
  });

  @override
  List<Object> get props => [questionViewOption];
}

/// event to load priority level list
class ExecuteAuditPriorityLevelListLoaded extends ExecuteAuditEvent {}

/// event to load observation type list
class ExecuteAuditObservationTypeListLoaded extends ExecuteAuditEvent {}

/// event to load site list
class ExecuteAuditSiteListLoaded extends ExecuteAuditEvent {}

/// event to load assignee list
class ExecuteAuditAssigneeListLoaded extends ExecuteAuditEvent {}

/// event to load category list
class ExecuteAuditCategoryListLoaded extends ExecuteAuditEvent {}
