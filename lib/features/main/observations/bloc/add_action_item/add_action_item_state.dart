// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_action_item_bloc.dart';

class AddActionItemState extends Equatable {
  /// action item to display or edit
  final ActionItem? actionItem;

  /// action item list to display or edit
  final List<ActionItem> actionItemList;

  /// task to create action item
  final String task;
  final String actionItemValidationMessage;

  /// dueBy to create action item
  DateTime? dueBy;
  DateTime? initialDueBy;
  final String dueByValidationMessage;

  /// assignee to create action item
  final User? assignee;
  final String assigneeValidationMessage;

  final Site? site;
  final String siteValidationMessage;

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

  final bool isClosed;

  /// check if it is editing
  final bool isEditing;

  /// response message
  final String message;

  /// action item create or update status
  final EntityStatus status;

  final List<Project> projectList;

  final List<Company> companyList;

  final List<Entity> userList;

  final List<PlatformFile> imageList;

  AddActionItemState({
    this.actionItem,
    this.actionItemList = const [],
    this.task = '',
    this.actionItemValidationMessage = '',
    this.site,
    this.siteValidationMessage = '',
    this.dueBy,
    this.initialDueBy,
    this.dueByValidationMessage = '',
    this.assignee,
    this.assigneeValidationMessage = '',
    this.category,
    this.company,
    this.project,
    this.location = '',
    this.notes = '',
    this.isEditing = false,
    this.message = '',
    this.status = EntityStatus.initial,
    this.projectList = const [],
    this.companyList = const [],
    this.userList = const [],
    this.isClosed = false,
    this.imageList = const [],
  }) {
    dueBy ??= DateTime.now();
  }

  @override
  List<Object?> get props => [
        actionItem,
        actionItemList,
        task,
        actionItemValidationMessage,
        initialDueBy,
        dueBy,
        dueByValidationMessage,
        assignee,
        assigneeValidationMessage,
        site,
        siteValidationMessage,
        category,
        company,
        project,
        location,
        notes,
        isClosed,
        isEditing,
        message,
        status,
        projectList,
        companyList,
        userList,
        imageList,
      ];

  ActionItemCreate get actionItemCreate => ActionItemCreate(
        id: actionItem?.id,
        name: task,
        dueBy: dueBy!.toIso8601String(),
        assigneeId: assignee!.id!,
        siteId: site!.id!,
        categoryId: category?.id,
        companyId: company?.id,
        projectId: project?.id,
        location: location,
        notes: notes,
        isClosed: isClosed,
      );

  AddActionItemState copyWith({
    Nullable<ActionItem?>? actionItem,
    List<ActionItem>? actionItemList,
    String? task,
    String? actionItemValidationMessage,
    Nullable<DateTime?>? dueBy,
    Nullable<DateTime?>? initialDueBy,
    String? dueByValidationMessage,
    Nullable<User?>? assignee,
    String? assigneeValidationMessage,
    Nullable<AwarenessCategory?>? category,
    Nullable<Company?>? company,
    Nullable<Project?>? project,
    Nullable<Site?>? site,
    String? siteValidationMessage,
    String? location,
    String? notes,
    bool? isClosed,
    bool? isEditing,
    String? message,
    EntityStatus? status,
    List<Project>? projectList,
    List<Company>? companyList,
    List<Entity>? userList,
    List<PlatformFile>? imageList,
  }) {
    return AddActionItemState(
      actionItem: actionItem != null ? actionItem.value : this.actionItem,
      actionItemList: actionItemList ?? this.actionItemList,
      task: task ?? this.task,
      actionItemValidationMessage:
          actionItemValidationMessage ?? this.actionItemValidationMessage,
      dueBy: dueBy != null ? dueBy.value : this.dueBy,
      initialDueBy:
          initialDueBy != null ? initialDueBy.value : this.initialDueBy,
      dueByValidationMessage:
          dueByValidationMessage ?? this.dueByValidationMessage,
      assignee: assignee != null ? assignee.value : this.assignee,
      assigneeValidationMessage:
          assigneeValidationMessage ?? this.assigneeValidationMessage,
      category: category != null ? category.value : this.category,
      company: company != null ? company.value : this.company,
      project: project != null ? project.value : this.project,
      site: site != null ? site.value : this.site,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      isClosed: isClosed ?? this.isClosed,
      isEditing: isEditing ?? this.isEditing,
      message: message ?? this.message,
      status: status ?? this.status,
      companyList: companyList ?? this.companyList,
      projectList: projectList ?? this.projectList,
      userList: userList ?? this.userList,
      imageList: imageList ?? this.imageList,
    );
  }
}
