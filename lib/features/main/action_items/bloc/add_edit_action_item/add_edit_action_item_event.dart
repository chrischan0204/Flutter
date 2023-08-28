// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_action_item_bloc.dart';

abstract class AddEditActionItemEvent extends Equatable {
  const AddEditActionItemEvent();

  @override
  List<Object> get props => [];
}

/// event to load category list to create action item
class AddEditActionItemAwarenessCategoryListLoaded
    extends AddEditActionItemEvent {}

/// event to load site list to create action item
class AddEditActionItemSiteListLoaded extends AddEditActionItemEvent {}

/// event to load company list to create action item
class AddEditActionItemCompanyListLoaded extends AddEditActionItemEvent {
  /// site id to load company list
  final String siteId;

  const AddEditActionItemCompanyListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

/// event to load project list to create action item
class AddEditActionItemProjectListLoaded extends AddEditActionItemEvent {
  /// site id to load project list
  final String siteId;

  const AddEditActionItemProjectListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

/// event to load user list to create action item
class AddEditActionItemUserListLoaded extends AddEditActionItemEvent {
  final String siteId;

  const AddEditActionItemUserListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

/// event to change name to create action item
class AddEditActionItemNameChanged extends AddEditActionItemEvent {
  final String name;
  const AddEditActionItemNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

/// event to change due by to create action item
class AddEditActionItemDueByChanged extends AddEditActionItemEvent {
  final DateTime dueBy;
  const AddEditActionItemDueByChanged({required this.dueBy});

  @override
  List<Object> get props => [dueBy];
}

/// event to change assignee to create action item
class AddEditActionItemAssigneeChanged extends AddEditActionItemEvent {
  final User assignee;
  const AddEditActionItemAssigneeChanged({required this.assignee});

  @override
  List<Object> get props => [assignee];
}

/// event to change category to create action item
class AddEditActionItemCategoryChanged extends AddEditActionItemEvent {
  final AwarenessCategory category;
  const AddEditActionItemCategoryChanged({required this.category});

  @override
  List<Object> get props => [category];
}

/// event to change site to create action item
class AddEditActionItemSiteChanged extends AddEditActionItemEvent {
  final Site site;
  const AddEditActionItemSiteChanged({required this.site});

  @override
  List<Object> get props => [site];
}

/// event to change company to create action item
class AddEditActionItemCompanyChanged extends AddEditActionItemEvent {
  final Company company;
  const AddEditActionItemCompanyChanged({required this.company});

  @override
  List<Object> get props => [company];
}

/// event to change project to create action item
class AddEditActionItemProjectChanged extends AddEditActionItemEvent {
  final Project project;
  const AddEditActionItemProjectChanged({required this.project});

  @override
  List<Object> get props => [project];
}

/// event to change location to create action item
class AddEditActionItemLocationChanged extends AddEditActionItemEvent {
  final String location;
  const AddEditActionItemLocationChanged({required this.location});

  @override
  List<Object> get props => [location];
}

/// event to change notes to create action item 
class AddEditActionItemNotesChanged extends AddEditActionItemEvent {
  final String notes;
  const AddEditActionItemNotesChanged({required this.notes});

  @override
  List<Object> get props => [notes];
}

/// event to change image list to create action item
class AddEditActionItemImageListChanged extends AddEditActionItemEvent {
  final List<PlatformFile> imageList;
  const AddEditActionItemImageListChanged({required this.imageList});

  @override
  List<Object> get props => [imageList];
}

/// event to change is closed to update action item
class AddEditActionItemIsClosedChanged extends AddEditActionItemEvent {
  final bool isClosed;
  const AddEditActionItemIsClosedChanged({required this.isClosed});

  @override
  List<Object> get props => [isClosed];
}

/// event to add new action item
class AddEditActionItemAdded extends AddEditActionItemEvent {}

/// event to edit action item
class AddEditActionItemEdited extends AddEditActionItemEvent {}

/// event to load action item detail by id
class AddEditActionItemLoaded extends AddEditActionItemEvent {
  final String actionItemId;
  const AddEditActionItemLoaded({required this.actionItemId});
  @override
  List<Object> get props => [actionItemId];
}
