part of 'execute_audit_action_item_bloc.dart';

abstract class ExecuteAuditActionItemEvent extends Equatable {
  const ExecuteAuditActionItemEvent();

  @override
  List<Object> get props => [];
}

class ExecuteAuditActionItemProjectListLoaded
    extends ExecuteAuditActionItemEvent {
  final String siteId;

  const ExecuteAuditActionItemProjectListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

class ExecuteAuditActionItemCompanyListLoaded
    extends ExecuteAuditActionItemEvent {
  final String siteId;

  const ExecuteAuditActionItemCompanyListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

class ExecuteAuditActionItemListLoaded extends ExecuteAuditActionItemEvent {}

class ExecuteAuditActionItemCreated extends ExecuteAuditActionItemEvent {}

class ExecuteAuditActionItemUpdated extends ExecuteAuditActionItemEvent {}

class ExecuteAuditActionItemSelected extends ExecuteAuditActionItemEvent {}

class ExecuteAuditActionItemTextChanged extends ExecuteAuditActionItemEvent {
  final String actionItemText;

  const ExecuteAuditActionItemTextChanged({required this.actionItemText});

  @override
  List<Object> get props => [actionItemText];
}

class ExecuteAuditActionItemDeleted extends ExecuteAuditActionItemEvent {
  final String actionItemId;

  const ExecuteAuditActionItemDeleted({
    required this.actionItemId,
  });

  @override
  List<Object> get props => [actionItemId];
}

class ExecuteAuditActionItemViewChanged extends ExecuteAuditActionItemEvent {
  final CrudView view;

  const ExecuteAuditActionItemViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}

class ExecuteAuditActionItemLoaded extends ExecuteAuditActionItemEvent {
  final String actionItemId;

  const ExecuteAuditActionItemLoaded({required this.actionItemId});

  @override
  List<Object> get props => [actionItemId];
}
