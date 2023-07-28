part of 'execute_audit_action_item_bloc.dart';

class ExecuteAuditActionItemState extends Equatable {
  final List<AuditActionItem> auditActionItemList;
  final EntityStatus auditActionItemListLoadStatus;

  final ActionItemDetail? auditActionItem;
  final EntityStatus auditActionItemLoadStatus;

  final EntityStatus status;

  final CrudView view;

  final List<Project> projectList;
  final List<Company> companyList;

  /// fields to create actionItem

  /// name to create action item
  final String name;

  final String initialName;

  /// validation message for name
  final String nameValidationMessage;

  /// dueBy to create action item
  DateTime? dueBy;

  DateTime? initialDueBy;

  /// validation message for due by
  final String dueByValidationMessage;

  /// assignee to create action item
  final User? assignee;

  final User? initialAssignee;

  /// validation message for assignee
  final String assigneeValidationMessage;

  /// site to create action item
  final Site? site;

  final Site? initialSite;

  /// validation message for site
  final String siteValidationMessage;

  /// category to create action item
  final AwarenessCategory? category;

  final AwarenessCategory? initialCategory;

  /// company to create action item
  final Company? company;

  final Company? initialCompany;

  /// project to create action item
  final Project? project;

  final Project? initialProject;

  /// location to create action item
  final String area;

  final String initialArea;

  /// notes to create action item
  final String notes;

  final String initialNotes;

  /// is closed to update action item
  final bool isClosed;

  final List<PlatformFile> fileList;

  final EntityStatus crudStatus;

  final String message;

  ExecuteAuditActionItemState({
    this.auditActionItemList = const [],
    this.auditActionItemListLoadStatus = EntityStatus.initial,
    this.auditActionItem,
    this.auditActionItemLoadStatus = EntityStatus.initial,
    this.status = EntityStatus.initial,
    this.view = CrudView.list,
    this.name = '',
    this.initialName = '',
    this.nameValidationMessage = '',
    this.dueBy,
    this.initialDueBy,
    this.dueByValidationMessage = '',
    this.assignee,
    this.initialAssignee,
    this.assigneeValidationMessage = '',
    this.site,
    this.initialSite,
    this.siteValidationMessage = '',
    this.category,
    this.initialCategory,
    this.company,
    this.initialCompany,
    this.project,
    this.initialProject,
    this.area = '',
    this.initialArea = '',
    this.notes = '',
    this.initialNotes = '',
    this.companyList = const [],
    this.projectList = const [],
    this.fileList = const [],
    this.isClosed = false,
    this.crudStatus = EntityStatus.initial,
    this.message = '',
  }) {
    final now = DateTime.now();
    dueBy ??= now;
    initialDueBy ??= now;
  }

  @override
  List<Object?> get props => [
        auditActionItemList,
        auditActionItemListLoadStatus,
        auditActionItem,
        auditActionItemLoadStatus,
        status,
        view,
        name,
        initialName,
        nameValidationMessage,
        initialDueBy,
        dueBy,
        dueByValidationMessage,
        initialAssignee,
        assignee,
        assigneeValidationMessage,
        initialSite,
        site,
        siteValidationMessage,
        initialCategory,
        category,
        initialCompany,
        company,
        initialProject,
        project,
        initialArea,
        area,
        initialNotes,
        notes,
        isClosed,
        projectList,
        companyList,
        fileList,
        crudStatus,
        message,
      ];

  bool get isDirty =>
      DateTime(dueBy!.year, dueBy!.month, dueBy!.day) !=
          DateTime(
              initialDueBy!.year, initialDueBy!.month, initialDueBy!.day) ||
      (site != null && site?.id != initialSite?.id) ||
      (project != null && project?.id != initialProject?.id) ||
      (company != null && company?.id != initialCompany?.id) ||
      (category != null && category?.id != initialCategory?.id) ||
      (assignee != null && assignee?.id != initialAssignee?.id) ||
      (Validation.isNotEmpty(notes) && notes != initialNotes) ||
      (Validation.isNotEmpty(name) && name != initialName) ||
      (Validation.isNotEmpty(area) && area != initialArea);

  ExecuteAuditActionItemState copyWith({
    List<AuditActionItem>? auditActionItemList,
    EntityStatus? auditActionItemListLoadStatus,
    Nullable<ActionItemDetail?>? auditActionItem,
    EntityStatus? auditActionItemLoadStatus,
    EntityStatus? status,
    CrudView? view,
    List<Project>? projectList,
    List<Company>? companyList,
    String? name,
    String? initialName,
    String? nameValidationMessage,
    DateTime? initialDueBy,
    DateTime? dueBy,
    String? dueByValidationMessage,
    Nullable<User?>? assignee,
    Nullable<User?>? initialAssignee,
    String? assigneeValidationMessage,
    Nullable<Site?>? site,
    Nullable<Site?>? initialSite,
    String? siteValidationMessage,
    Nullable<AwarenessCategory?>? category,
    Nullable<AwarenessCategory?>? initialCategory,
    Nullable<Company?>? company,
    Nullable<Company?>? initialCompany,
    Nullable<Project?>? project,
    Nullable<Project?>? initialProject,
    String? initialArea,
    String? area,
    String? initialNotes,
    String? notes,
    List<PlatformFile>? fileList,
    bool? isClosed,
    EntityStatus? crudStatus,
    String? message,
  }) {
    return ExecuteAuditActionItemState(
        auditActionItemList: auditActionItemList ?? this.auditActionItemList,
        auditActionItemListLoadStatus:
            auditActionItemListLoadStatus ?? this.auditActionItemListLoadStatus,
        auditActionItem: auditActionItem != null
            ? auditActionItem.value
            : this.auditActionItem,
        auditActionItemLoadStatus:
            auditActionItemLoadStatus ?? this.auditActionItemLoadStatus,
        status: status ?? this.status,
        view: view ?? this.view,
        projectList: projectList ?? this.projectList,
        companyList: companyList ?? this.companyList,
        name: name ?? this.name,
        initialName: initialName ?? this.initialName,
        nameValidationMessage:
            nameValidationMessage ?? this.nameValidationMessage,
        dueBy: dueBy ?? this.dueBy,
        initialDueBy: initialDueBy ?? this.initialDueBy,
        dueByValidationMessage:
            dueByValidationMessage ?? this.dueByValidationMessage,
        assignee: assignee != null ? assignee.value : this.assignee,
        initialAssignee: initialAssignee != null
            ? initialAssignee.value
            : this.initialAssignee,
        assigneeValidationMessage:
            assigneeValidationMessage ?? this.assigneeValidationMessage,
        site: site != null ? site.value : this.site,
        initialSite: initialSite != null ? initialSite.value : this.initialSite,
        siteValidationMessage:
            siteValidationMessage ?? this.siteValidationMessage,
        initialCategory: initialCategory != null
            ? initialCategory.value
            : this.initialCategory,
        category: category != null ? category.value : this.category,
        initialCompany:
            initialCompany != null ? initialCompany.value : this.initialCompany,
        company: company != null ? company.value : this.company,
        initialProject:
            initialProject != null ? initialProject.value : this.initialProject,
        project: project != null ? project.value : this.project,
        initialArea: initialArea ?? this.initialArea,
        area: area ?? this.area,
        initialNotes: initialNotes ?? this.initialNotes,
        notes: notes ?? this.notes,
        isClosed: isClosed ?? this.isClosed,
        fileList: fileList ?? this.fileList,
        crudStatus: crudStatus ?? this.crudStatus,
        message: message ?? this.message);
  }
}
