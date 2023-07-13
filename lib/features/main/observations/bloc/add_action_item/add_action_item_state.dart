// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_action_item_bloc.dart';

class AddActionItemState extends Equatable {
  /// action item to display or edit
  final ActionItem? actionItem;

  /// action item list to display or edit
  final List<ActionItem> actionItemList;

  /// task to create action item
  final String task;

  /// dueBy to create action item
  final DateTime? dueBy;

  /// assignee to create action item
  final User? assignee;

  /// category to create action item
  final AwarenessCategory? category;

  /// company to create action item
  final Company? company;

  /// project to create action item
  final Project? project;

  /// location to create action item
  final String location;

  /// notes to create action item
  final String notes;

  /// check if it is editing
  final bool isEditing;

  /// response message
  final String message;

  /// action item create or update status
  final EntityStatus status;

  const AddActionItemState({
    this.actionItem,
    this.actionItemList = const [],
    this.task = '',
    this.dueBy,
    this.assignee,
    this.category,
    this.company,
    this.project,
    this.location = '',
    this.notes = '',
    this.isEditing = false,
    this.message = '',
    this.status = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        actionItem,
        actionItemList,
        task,
        dueBy,
        assignee,
        category,
        company,
        project,
        location,
        notes,
        isEditing,
        message,
        status,
      ];

  ActionItemCreate get actionItemCreate => ActionItemCreate(
        id: actionItem?.id,
        name: task,
        siteId: '',
        dueBy: dueBy!.toIso8601String(),
        assigneeId: assignee!.id!,
        categoryId: category!.id!,
        companyId: company!.id!,
        projectId: project!.id!,
        location: location,
        notes: notes,
      );

  AddActionItemState copyWith({
    Nullable<ActionItem?>? actionItem,
    List<ActionItem>? actionItemList,
    String? task,
    Nullable<DateTime?>? dueBy,
    Nullable<User?>? assignee,
    Nullable<AwarenessCategory?>? category,
    Nullable<Company?>? company,
    Nullable<Project?>? project,
    String? location,
    String? notes,
    bool? isEditing,
    String? message,
    EntityStatus? status,
  }) {
    return AddActionItemState(
      actionItem: actionItem != null ? actionItem.value : this.actionItem,
      actionItemList: actionItemList ?? this.actionItemList,
      task: task ?? this.task,
      dueBy: dueBy != null ? dueBy.value : this.dueBy,
      assignee: assignee != null ? assignee.value : this.assignee,
      category: category != null ? category.value : this.category,
      company: company != null ? company.value : this.company,
      project: project != null ? project.value : this.project,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      isEditing: isEditing ?? this.isEditing,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
