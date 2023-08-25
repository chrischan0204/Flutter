// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'execute_audit_action_item_bloc.dart';

abstract class ExecuteAuditActionItemEvent extends Equatable {
  const ExecuteAuditActionItemEvent();

  @override
  List<Object> get props => [];
}

/// event to load project list
class ExecuteAuditActionItemProjectListLoaded
    extends ExecuteAuditActionItemEvent {
  final String siteId;

  const ExecuteAuditActionItemProjectListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

/// event to load company list
class ExecuteAuditActionItemCompanyListLoaded
    extends ExecuteAuditActionItemEvent {
  final String siteId;

  const ExecuteAuditActionItemCompanyListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}


/// event to load action item list 
class ExecuteAuditActionItemListLoaded extends ExecuteAuditActionItemEvent {}

/// event to created action item
class ExecuteAuditActionItemCreated extends ExecuteAuditActionItemEvent {}

/// event to update action item
class ExecuteAuditActionItemUpdated extends ExecuteAuditActionItemEvent {}

/// event to select action item
class ExecuteAuditActionItemSelected extends ExecuteAuditActionItemEvent {}

/// event to delete action item by id
class ExecuteAuditActionItemDeleted extends ExecuteAuditActionItemEvent {
  final String actionItemId;

  const ExecuteAuditActionItemDeleted({
    required this.actionItemId,
  });

  @override
  List<Object> get props => [actionItemId];
}

/// event to change view - list, create, update, detail
class ExecuteAuditActionItemViewChanged extends ExecuteAuditActionItemEvent {
  final CrudView view;

  const ExecuteAuditActionItemViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}

/// event to load action item detail
class ExecuteAuditActionItemLoaded extends ExecuteAuditActionItemEvent {
  final String actionItemId;

  const ExecuteAuditActionItemLoaded({required this.actionItemId});

  @override
  List<Object> get props => [actionItemId];
}

/// event to change action required
class ExecuteAuditActionItemNameChanged extends ExecuteAuditActionItemEvent {
  final String actionItem;

  const ExecuteAuditActionItemNameChanged({required this.actionItem});

  @override
  List<Object> get props => [actionItem];
}

/// event to change site
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

/// event to change assignee
class ExecuteAuditActionItemAssigneeChanged
    extends ExecuteAuditActionItemEvent {
  final User assignee;

  const ExecuteAuditActionItemAssigneeChanged({required this.assignee});

  @override
  List<Object> get props => [assignee];
}

/// event to change due by
class ExecuteAuditActionItemDueByChanged extends ExecuteAuditActionItemEvent {
  final DateTime dueBy;

  const ExecuteAuditActionItemDueByChanged({required this.dueBy});

  @override
  List<Object> get props => [dueBy];
}

/// event to change company
class ExecuteAuditActionItemCompanyChanged extends ExecuteAuditActionItemEvent {
  final Company company;

  const ExecuteAuditActionItemCompanyChanged({required this.company});

  @override
  List<Object> get props => [company];
}

/// event to change category
class ExecuteAuditActionItemCategoryChanged
    extends ExecuteAuditActionItemEvent {
  final AwarenessCategory category;

  const ExecuteAuditActionItemCategoryChanged({required this.category});

  @override
  List<Object> get props => [category];
}

/// event to change project
class ExecuteAuditActionItemProjectChanged extends ExecuteAuditActionItemEvent {
  final Project project;

  const ExecuteAuditActionItemProjectChanged({required this.project});

  @override
  List<Object> get props => [project];
}

/// event to change area
class ExecuteAuditActionItemAreaChanged extends ExecuteAuditActionItemEvent {
  final String area;

  const ExecuteAuditActionItemAreaChanged({required this.area});

  @override
  List<Object> get props => [area];
}

/// event to change notes
class ExecuteAuditActionItemNotesChanged extends ExecuteAuditActionItemEvent {
  final String notes;

  const ExecuteAuditActionItemNotesChanged({required this.notes});

  @override
  List<Object> get props => [notes];
}

/// event to change isClosed
class ExecuteAuditActionItemIsClosedChanged
    extends ExecuteAuditActionItemEvent {
  final bool isClosed;

  const ExecuteAuditActionItemIsClosedChanged({required this.isClosed});

  @override
  List<Object> get props => [isClosed];
}

/// event to change file list
class ExecuteAuditActionItemFileListChanged
    extends ExecuteAuditActionItemEvent {
  final List<PlatformFile> fileList;

  const ExecuteAuditActionItemFileListChanged({required this.fileList});

  @override
  List<Object> get props => [fileList];
}

/// event to init state
class ExecuteAuditActionItemInited extends ExecuteAuditActionItemEvent {}