// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_action_item_bloc.dart';

abstract class AddActionItemEvent extends Equatable {
  const AddActionItemEvent();

  @override
  List<Object?> get props => [];
}

/// event to change task to create action item
class AddActionItemTaskChanged extends AddActionItemEvent {
  final String task;
  const AddActionItemTaskChanged({required this.task});

  @override
  List<Object> get props => [task];
}

/// event to change due by to create action item
class AddActionItemDueByChanged extends AddActionItemEvent {
  final DateTime dueBy;
  const AddActionItemDueByChanged({required this.dueBy});

  @override
  List<Object> get props => [dueBy];
}

/// event to change assignee to create action item
class AddActionItemAssigneeChanged extends AddActionItemEvent {
  final User assignee;
  const AddActionItemAssigneeChanged({required this.assignee});

  @override
  List<Object> get props => [assignee];
}

/// event to change category create action item
class AddActionItemCategoryChanged extends AddActionItemEvent {
  final AwarenessCategory category;
  const AddActionItemCategoryChanged({required this.category});

  @override
  List<Object> get props => [category];
}

/// event to change company to create action item
class AddActionItemCompanyChanged extends AddActionItemEvent {
  final Company company;
  const AddActionItemCompanyChanged({required this.company});

  @override
  List<Object> get props => [company];
}

/// event to change project to create action item
class AddActionItemProjectChanged extends AddActionItemEvent {
  final Project project;
  const AddActionItemProjectChanged({required this.project});

  @override
  List<Object> get props => [project];
}

/// event to change location to create action item
class AddActionItemLocationChanged extends AddActionItemEvent {
  final String location;
  const AddActionItemLocationChanged({required this.location});

  @override
  List<Object> get props => [location];
}

/// event to change change to create action item
class AddActionItemNotesChanged extends AddActionItemEvent {
  final String notes;
  const AddActionItemNotesChanged({required this.notes});

  @override
  List<Object> get props => [notes];
}

/// event to change is closed to update action item
class AddActionItemIsClosedChanged extends AddActionItemEvent {
  final bool isClosed;
  const AddActionItemIsClosedChanged({required this.isClosed});

  @override
  List<Object> get props => [isClosed];
}

/// event to load acion item list
class AddActionItemListLoaded extends AddActionItemEvent {
  /// observation id to load action item list
  final String observationId;
  const AddActionItemListLoaded({required this.observationId});

  @override
  List<Object> get props => [observationId];
}

/// event to clikc add action item button
class AddActionItemAddActionItemButtonClicked extends AddActionItemEvent {}

/// event to click action item list button
class AddActionItemActionItemListButtonClicked extends AddActionItemEvent {}

/// event to create or update action item
class AddActionItemSaved extends AddActionItemEvent {}

/// event to display detail of selected action item
class AddActionItemDetailShown extends AddActionItemEvent {
  final ActionItem actionItem;
  const AddActionItemDetailShown({required this.actionItem});

  @override
  List<Object> get props => [actionItem];
}

/// event to open the edit form with existing detail of action item
class AddActionItemDetailEdited extends AddActionItemEvent {
  final ActionItem actionItem;
  const AddActionItemDetailEdited({required this.actionItem});

  @override
  List<Object> get props => [actionItem];
}

/// event to change editing status
class AddActionItemIsEditingChanged extends AddActionItemEvent {
  final bool isEditing;

  const AddActionItemIsEditingChanged({required this.isEditing});

  @override
  List<Object> get props => [isEditing];
}

/// event to change site to create action item
class AddActionItemSiteChanged extends AddActionItemEvent {
  final Site? site;

  const AddActionItemSiteChanged({this.site});

  @override
  List<Object?> get props => [site];
}

/// event to change image list to create action item
class AddActionItemImageListChanged extends AddActionItemEvent {
  final List<PlatformFile> imageList;
  const AddActionItemImageListChanged({required this.imageList});

  @override
  List<Object> get props => [imageList];
}
