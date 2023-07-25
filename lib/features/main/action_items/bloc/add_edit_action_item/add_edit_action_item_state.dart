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
  final List<Entity> userList;

  /// name to create action item
  final String name;

  /// validation message for name
  final String nameValidationMessage;

  /// initial name to check form dirty;
  final String initialName;

  /// dueBy to create action item
  DateTime? dueBy;

  /// initial due by to check form dirty;
  final DateTime? initialDueBy;

  /// validation message for due by
  final String dueByValidationMessage;

  /// assignee to create action item
  final User? assignee;

  /// initial assignee to check form dirty;
  final User? initialAssignee;

  /// validation message for assignee
  final String assigneeValidationMessage;

  /// site to create action item
  final Site? site;

  /// initial site by to check form dirty;
  final Site? initialSite;

  /// validation message for site
  final String siteValidationMessage;

  /// category to create action item
  final AwarenessCategory? category;

  /// initial category to check form dirty;
  final AwarenessCategory? initialCategory;

  /// company to create action item
  final Company? company;

  /// initial company to check form dirty;
  final Company? initialCompany;

  /// project to create action item
  final Project? project;

  /// initial project to check form dirty;
  final Project? initialProject;

  /// location to create action item
  final String location;

  /// initial location to check form dirty;
  final String initialLocation;

  /// notes to create action item
  final String notes;

  /// initial notes to check form dirty;
  final String initialNotes;

  final bool isClosed;

  /// status
  final EntityStatus status;

  /// response message
  final String message;
  AddEditActionItemState({
    this.actionItem,
    this.awarenessCategoryList = const [],
    this.companyList = const [],
    this.projectList = const [],
    this.siteList = const [],
    this.userList = const [],
    this.name = '',
    this.initialName = '',
    this.nameValidationMessage = '',
    this.dueBy,
    this.dueByValidationMessage = '',
    this.initialDueBy,
    this.site,
    this.initialSite,
    this.siteValidationMessage = '',
    this.assignee,
    this.initialAssignee,
    this.assigneeValidationMessage = '',
    this.category,
    this.initialCategory,
    this.company,
    this.initialCompany,
    this.project,
    this.initialProject,
    this.location = '',
    this.initialLocation = '',
    this.notes = '',
    this.initialNotes = '',
    this.status = EntityStatus.initial,
    this.message = '',
    this.isClosed = false,
  }) {
    dueBy ??= DateTime.now();
  }

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
        dueByValidationMessage,
        site,
        siteValidationMessage,
        assignee,
        assigneeValidationMessage,
        category,
        company,
        project,
        location,
        notes,
        isClosed,
        status,
        message,
        initialAssignee,
        initialCategory,
        initialCompany,
        initialDueBy,
        initialLocation,
        initialName,
        initialNotes,
        initialProject,
        initialSite,
      ];

  bool get formDirty =>
      (Validation.isNotEmpty(name) && name != initialName) ||
      (dueBy != null && dueBy != initialDueBy) ||
      (assignee != null && assignee?.id != initialAssignee?.id) ||
      (category != null && category?.id != initialCategory?.id) ||
      (site != null && site?.id != initialSite?.id) ||
      (company != null && company?.id != initialCompany?.id) ||
      (project != null && project?.id != initialProject?.id) ||
      (Validation.isNotEmpty(location) && location != initialLocation) ||
      (Validation.isNotEmpty(notes) && notes != initialNotes);

  ActionItemCreate get actionItemCreate => ActionItemCreate(
        id: actionItem?.id,
        name: name,
        dueBy: dueBy!.toIso8601String(),
        siteId: site!.id!,
        assigneeId: assignee!.id!,
        categoryId: category?.id,
        companyId: company?.id,
        projectId: project?.id,
        location: location,
        notes: notes,
        isClosed: isClosed,
      );

  AddEditActionItemState copyWith({
    Nullable<ActionItem?>? actionItem,
    List<AwarenessCategory>? awarenessCategoryList,
    List<Company>? companyList,
    List<Project>? projectList,
    List<Site>? siteList,
    List<Entity>? userList,
    String? name,
    String? initialName,
    String? nameValidationMessage,
    Nullable<DateTime?>? dueBy,
    String? dueByValidationMessage,
    Nullable<DateTime?>? initialDueBy,
    Nullable<User?>? assignee,
    Nullable<User?>? initialAssignee,
    String? assigneeValidationMessage,
    Nullable<AwarenessCategory?>? category,
    Nullable<AwarenessCategory?>? initialCategory,
    Nullable<Company?>? company,
    Nullable<Company?>? initialCompany,
    Nullable<Project?>? project,
    Nullable<Project?>? initialProject,
    Nullable<Site?>? site,
    Nullable<Site?>? initialSite,
    String? siteValidationMessage,
    String? location,
    String? initialLocation,
    String? notes,
    bool? isClosed,
    String? initialNotes,
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
      initialName: initialName ?? this.initialName,
      nameValidationMessage:
          nameValidationMessage ?? this.nameValidationMessage,
      assigneeValidationMessage:
          assigneeValidationMessage ?? this.assigneeValidationMessage,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      dueBy: dueBy != null ? dueBy.value : this.dueBy,
      dueByValidationMessage:
          dueByValidationMessage ?? this.dueByValidationMessage,
      assignee: assignee != null ? assignee.value : this.assignee,
      initialAssignee: initialAssignee != null
          ? initialAssignee.value
          : this.initialAssignee,
      category: category != null ? category.value : this.category,
      initialCategory: initialCategory != null
          ? initialCategory.value
          : this.initialCategory,
      company: company != null ? company.value : this.company,
      initialCompany:
          initialCompany != null ? initialCompany.value : this.initialCompany,
      site: site != null ? site.value : this.site,
      initialSite: initialSite != null ? initialSite.value : this.initialSite,
      project: project != null ? project.value : this.project,
      initialProject:
          initialProject != null ? initialProject.value : this.initialProject,
      location: location ?? this.location,
      initialDueBy:
          initialDueBy != null ? initialDueBy.value : this.initialDueBy,
      initialLocation: initialLocation ?? this.initialLocation,
      initialNotes: initialNotes ?? this.initialNotes,
      notes: notes ?? this.notes,
      isClosed: isClosed ?? this.isClosed,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
