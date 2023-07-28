// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  /// validation message for name
  final String nameValidationMessage;

  /// dueBy to create action item
  DateTime? dueBy;

  /// validation message for due by
  final String dueByValidationMessage;

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
  final String area;

  /// notes to create action item
  final String notes;

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
    this.nameValidationMessage = '',
    this.dueBy,
    this.dueByValidationMessage = '',
    this.assignee,
    this.assigneeValidationMessage = '',
    this.site,
    this.siteValidationMessage = '',
    this.category,
    this.company,
    this.project,
    this.area = '',
    this.notes = '',
    this.companyList = const [],
    this.projectList = const [],
    this.fileList = const [],
    this.isClosed = false,
    this.crudStatus = EntityStatus.initial,
    this.message = '',
  }) {
    dueBy ??= DateTime.now();
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
        nameValidationMessage,
        dueBy,
        dueByValidationMessage,
        assignee,
        assigneeValidationMessage,
        site,
        siteValidationMessage,
        category,
        company,
        project,
        area,
        notes,
        isClosed,
        projectList,
        companyList,
        fileList,
        crudStatus,
        message,
      ];

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
    String? nameValidationMessage,
    DateTime? dueBy,
    String? dueByValidationMessage,
    Nullable<User?>? assignee,
    String? assigneeValidationMessage,
    Nullable<Site?>? site,
    String? siteValidationMessage,
    Nullable<AwarenessCategory?>? category,
    Nullable<Company?>? company,
    Nullable<Project?>? project,
    String? area,
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
        nameValidationMessage:
            nameValidationMessage ?? this.nameValidationMessage,
        dueBy: dueBy ?? this.dueBy,
        dueByValidationMessage:
            dueByValidationMessage ?? this.dueByValidationMessage,
        assignee: assignee != null ? assignee.value : this.assignee,
        assigneeValidationMessage:
            assigneeValidationMessage ?? this.assigneeValidationMessage,
        site: site != null ? site.value : this.site,
        siteValidationMessage:
            siteValidationMessage ?? this.siteValidationMessage,
        category: category != null ? category.value : this.category,
        company: company != null ? company.value : this.company,
        project: project != null ? project.value : this.project,
        area: area ?? this.area,
        notes: notes ?? this.notes,
        isClosed: isClosed ?? this.isClosed,
        fileList: fileList ?? this.fileList,
        crudStatus: crudStatus ?? this.crudStatus,
        message: message ?? this.message);
  }
}
