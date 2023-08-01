// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class ExecuteAuditActionItemNameChanged extends ExecuteAuditActionItemEvent {
  final String actionItem;

  const ExecuteAuditActionItemNameChanged({required this.actionItem});

  @override
  List<Object> get props => [actionItem];
}

class ExecuteAuditActionItemSiteChanged extends ExecuteAuditActionItemEvent {
  final Site site;
  final bool isInit;

  const ExecuteAuditActionItemSiteChanged({
    required this.site,
    this.isInit = false,
  });

  @override
  List<Object> get props => [
        site,
        isInit,
      ];
}

class ExecuteAuditActionItemAssigneeChanged
    extends ExecuteAuditActionItemEvent {
  final User assignee;

  const ExecuteAuditActionItemAssigneeChanged({required this.assignee});

  @override
  List<Object> get props => [assignee];
}

class ExecuteAuditActionItemDueByChanged extends ExecuteAuditActionItemEvent {
  final DateTime dueBy;

  const ExecuteAuditActionItemDueByChanged({required this.dueBy});

  @override
  List<Object> get props => [dueBy];
}

class ExecuteAuditActionItemCompanyChanged extends ExecuteAuditActionItemEvent {
  final Company company;

  const ExecuteAuditActionItemCompanyChanged({required this.company});

  @override
  List<Object> get props => [company];
}

class ExecuteAuditActionItemCategoryChanged
    extends ExecuteAuditActionItemEvent {
  final AwarenessCategory category;

  const ExecuteAuditActionItemCategoryChanged({required this.category});

  @override
  List<Object> get props => [category];
}

class ExecuteAuditActionItemProjectChanged extends ExecuteAuditActionItemEvent {
  final Project project;

  const ExecuteAuditActionItemProjectChanged({required this.project});

  @override
  List<Object> get props => [project];
}

class ExecuteAuditActionItemAreaChanged extends ExecuteAuditActionItemEvent {
  final String area;

  const ExecuteAuditActionItemAreaChanged({required this.area});

  @override
  List<Object> get props => [area];
}

class ExecuteAuditActionItemNotesChanged extends ExecuteAuditActionItemEvent {
  final String notes;

  const ExecuteAuditActionItemNotesChanged({required this.notes});

  @override
  List<Object> get props => [notes];
}

class ExecuteAuditActionItemIsClosedChanged
    extends ExecuteAuditActionItemEvent {
  final bool isClosed;

  const ExecuteAuditActionItemIsClosedChanged({required this.isClosed});

  @override
  List<Object> get props => [isClosed];
}

class ExecuteAuditActionItemFileListChanged
    extends ExecuteAuditActionItemEvent {
  final List<PlatformFile> fileList;

  const ExecuteAuditActionItemFileListChanged({required this.fileList});

  @override
  List<Object> get props => [fileList];
}

class ExecuteAuditActionItemInited extends ExecuteAuditActionItemEvent {}