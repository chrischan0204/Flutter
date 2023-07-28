// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_action_item_bloc.dart';

abstract class AddEditActionItemEvent extends Equatable {
  const AddEditActionItemEvent();

  @override
  List<Object> get props => [];
}

class AddEditActionItemAwarenessCategoryListLoaded
    extends AddEditActionItemEvent {}

class AddEditActionItemSiteListLoaded extends AddEditActionItemEvent {}

class AddEditActionItemCompanyListLoaded extends AddEditActionItemEvent {
  /// site id to load company list
  final String siteId;

  const AddEditActionItemCompanyListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

class AddEditActionItemProjectListLoaded extends AddEditActionItemEvent {
  /// site id to load project list
  final String siteId;

  const AddEditActionItemProjectListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

class AddEditActionItemUserListLoaded extends AddEditActionItemEvent {
  final String siteId;

  const AddEditActionItemUserListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

class AddEditActionItemNameChanged extends AddEditActionItemEvent {
  final String name;
  const AddEditActionItemNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class AddEditActionItemDueByChanged extends AddEditActionItemEvent {
  final DateTime dueBy;
  const AddEditActionItemDueByChanged({required this.dueBy});

  @override
  List<Object> get props => [dueBy];
}

class AddEditActionItemAssigneeChanged extends AddEditActionItemEvent {
  final User assignee;
  const AddEditActionItemAssigneeChanged({required this.assignee});

  @override
  List<Object> get props => [assignee];
}

class AddEditActionItemCategoryChanged extends AddEditActionItemEvent {
  final AwarenessCategory category;
  const AddEditActionItemCategoryChanged({required this.category});

  @override
  List<Object> get props => [category];
}

class AddEditActionItemSiteChanged extends AddEditActionItemEvent {
  final Site site;
  const AddEditActionItemSiteChanged({required this.site});

  @override
  List<Object> get props => [site];
}

class AddEditActionItemCompanyChanged extends AddEditActionItemEvent {
  final Company company;
  const AddEditActionItemCompanyChanged({required this.company});

  @override
  List<Object> get props => [company];
}

class AddEditActionItemProjectChanged extends AddEditActionItemEvent {
  final Project project;
  const AddEditActionItemProjectChanged({required this.project});

  @override
  List<Object> get props => [project];
}

class AddEditActionItemLocationChanged extends AddEditActionItemEvent {
  final String location;
  const AddEditActionItemLocationChanged({required this.location});

  @override
  List<Object> get props => [location];
}

class AddEditActionItemNotesChanged extends AddEditActionItemEvent {
  final String notes;
  const AddEditActionItemNotesChanged({required this.notes});

  @override
  List<Object> get props => [notes];
}

class AddEditActionItemImageListChanged extends AddEditActionItemEvent {
  final List<PlatformFile> imageList;
  const AddEditActionItemImageListChanged({required this.imageList});

  @override
  List<Object> get props => [imageList];
}

class AddEditActionItemIsClosedChanged extends AddEditActionItemEvent {
  final bool isClosed;
  const AddEditActionItemIsClosedChanged({required this.isClosed});

  @override
  List<Object> get props => [isClosed];
}

class AddEditActionItemAdded extends AddEditActionItemEvent {}

class AddEditActionItemEdited extends AddEditActionItemEvent {}

class AddEditActionItemLoaded extends AddEditActionItemEvent {
  final String actionItemId;
  const AddEditActionItemLoaded({required this.actionItemId});
  @override
  List<Object> get props => [actionItemId];
}
