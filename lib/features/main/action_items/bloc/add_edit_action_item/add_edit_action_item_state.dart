part of 'add_edit_action_item_bloc.dart';

class AddEditActionItemState extends Equatable {
  /// loaded action item for update
  final ActionItem? actionItem;

  /// awareness category list
  final List<AwarenessCategory> awarenessCategoryList;

  /// company list
  final List<Company> companyList;

  /// project list
  final List<Project> projectList;

  /// site list
  final List<Site> siteList;

  /// user list
  final List<User> userList;

  /// name to create action item
  final String name;

  /// validation message for name
  final String nameValidationMessage;

  /// dueBy to create action item
  final DateTime? dueBy;

  /// assignee to create action item
  final User? assignee;

  /// validation message for assignee
  final String assigneeValidationMessage;

  /// site to create action item
  final Site? site;

  /// validation message for site
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

  /// status
  final EntityStatus status;

  /// response message
  final String message;
  const AddEditActionItemState({
    this.actionItem,
    this.awarenessCategoryList = const [],
    this.companyList = const [],
    this.projectList = const [],
    this.siteList = const [],
    this.userList = const [],
    this.name = '',
    this.nameValidationMessage = '',
    this.dueBy,
    this.site,
    this.siteValidationMessage = '',
    this.assignee,
    this.assigneeValidationMessage = '',
    this.category,
    this.company,
    this.project,
    this.location = '',
    this.notes = '',
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        actionItem,
        awarenessCategoryList,
        companyList,
        projectList,
        siteList,
        userList,
        name,
        nameValidationMessage,
        dueBy,
        site,
        siteValidationMessage,
        assignee,
        assigneeValidationMessage,
        category,
        company,
        project,
        location,
        notes,
        status,
        message,
      ];

  bool get formDirty =>
      name.isNotEmpty == true ||
      dueBy != null ||
      assignee != null ||
      category != null ||
      site != null ||
      company != null ||
      project != null ||
      location.isNotEmpty == true ||
      notes.isNotEmpty == true;

  ActionItemCreate get actionItemCreate => ActionItemCreate(
        id: actionItem?.id,
        name: name,
        dueBy: dueBy!.toIso8601String(),
        assigneeId: assignee!.id!,
        categoryId: category!.id!,
        companyId: company!.id!,
        projectId: project!.id!,
        location: location,
        notes: notes,
      );

  AddEditActionItemState copyWith({
    Nullable<ActionItem?>? actionItem,
    List<AwarenessCategory>? awarenessCategoryList,
    List<Company>? companyList,
    List<Project>? projectList,
    List<Site>? siteList,
    List<User>? userList,
    String? name,
    String? nameValidationMessage,
    Nullable<DateTime?>? dueBy,
    Nullable<User?>? assignee,
    String? assigneeValidationMessage,
    Nullable<AwarenessCategory?>? category,
    Nullable<Company?>? company,
    Nullable<Project?>? project,
    Nullable<Site?>? site,
    String? siteValidationMessage,
    String? location,
    String? notes,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditActionItemState(
      actionItem: actionItem != null ? actionItem.value : this.actionItem,
      awarenessCategoryList:
          awarenessCategoryList ?? this.awarenessCategoryList,
      companyList: companyList ?? this.companyList,
      projectList: projectList ?? this.projectList,
      siteList: siteList ?? this.siteList,
      userList: userList ?? this.userList,
      name: name ?? this.name,
      nameValidationMessage:
          nameValidationMessage ?? this.nameValidationMessage,
      assigneeValidationMessage:
          assigneeValidationMessage ?? this.assigneeValidationMessage,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      dueBy: dueBy != null ? dueBy.value : this.dueBy,
      assignee: assignee != null ? assignee.value : this.assignee,
      category: category != null ? category.value : this.category,
      company: company != null ? company.value : this.company,
      site: site != null ? site.value : this.site,
      project: project != null ? project.value : this.project,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
