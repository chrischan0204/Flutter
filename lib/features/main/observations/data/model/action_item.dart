import 'package:intl/intl.dart';

import 'package:safety_eta/common_libraries.dart';

enum ActionItemStatus {
  closed,
  open;

  bool get isClosed => this == closed;
  bool get isOpen => this == open;

  @override
  String toString() {
    return isClosed ? 'Close' : 'Open';
  }
}

class ActionItem extends Entity {
  final DateTime? dueBy;
  final String observationId;
  final String observationName;
  final String assigneeId;
  final String assigneeName;
  final String awarenessCategoryId;
  final String awarenessCategoryName;
  final String companyId;
  final String companyName;
  final String projectId;
  final String projectName;
  final String area;
  final String notes;
  final String source;
  final String status;
  final String actionRequired;
  final String dueOn;
  final String closedOn;
  final String closedByName;
  final String comments;
  final String auditName;
  final String auditId;
  final String siteId;
  final String siteName;
  final String auditSectionItemId;
  final String auditSectionName;
  final bool isClosed;

  const ActionItem({
    super.id,
    super.name,
    this.dueBy,
    this.assigneeId = '',
    this.assigneeName = '',
    this.awarenessCategoryId = '',
    this.awarenessCategoryName = '',
    this.companyId = '',
    this.companyName = '',
    this.projectId = '',
    this.projectName = '',
    this.observationId = '',
    this.observationName = '',
    this.area = '',
    this.notes = '',
    this.source = '',
    this.status = '',
    this.actionRequired = '',
    this.dueOn = '',
    this.closedOn = '',
    this.comments = '',
    this.closedByName = '',
    this.auditName = '',
    this.auditId = '',
    this.auditSectionItemId = '',
    this.auditSectionName = '',
    this.siteId = '',
    this.siteName = '',
    this.isClosed = false,
    super.createdByUserName,
    super.columns,
    super.deleted,
  });

  String get formatedDue =>
      dueBy != null ? DateFormat('yyyy-MM-dd').format(dueBy!) : '--';

  @override
  List<Object?> get props => [
        ...super.props,
        dueBy,
        assigneeId,
        assigneeName,
        awarenessCategoryId,
        awarenessCategoryName,
        companyId,
        companyName,
        projectId,
        projectName,
        observationId,
        observationName,
        area,
        notes,
        source,
        status,
        actionRequired,
        dueOn,
        closedOn,
        isClosed,
        comments,
        closedByName,
        auditId,
        auditName,
        siteId, 
        siteName,
        auditSectionItemId,
        auditSectionName,
      ];

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': name,
      'dueBy': dueBy?.toIso8601String(),
      'observationId': observationId,
      'observationName': observationName,
      'assigneeId': assigneeId,
      'assigneeName': assigneeName,
      'awarenessCategoryId': awarenessCategoryId,
      'awarenessCategoryName': awarenessCategoryName,
      'companyId': companyId,
      'companyName': companyName,
      'projectId': projectId,
      'projectName': projectName,
      'area': area,
      'notes': notes,
    };
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Status': status,
      'Source': source,
      'Action required': actionRequired,
      'Created By': createdByUserName,
      'Due on': dueOn,
      'Closed on': closedOn,
      'Assignee': assigneeName,
      'Category': awarenessCategoryName,
      'Comments': comments,
      'Company': companyName,
      'Area': area,
      'Location': area,
      'Project': projectName,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Item': name,
      'Due': formatedDue,
      'Assignee': assigneeName,
      'Parent': source == 'None'
          ? 'None'
          : source == 'Audit'
              ? auditName
              : observationName,
      'Category': awarenessCategoryName,
      'Company': companyName,
      'Project': projectName,
      'Area': area,
      'Notes': {'content': notes},
    };
  }

  factory ActionItem.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return ActionItem(
      id: entity.id,
      name: map['description'] ?? '',
      dueBy: DateTime.parse(map['dueBy']),
      observationId: map['observationId'] ?? '',
      observationName: map['observationName'] ?? '',
      assigneeId: map['assigneeId'] ?? '',
      assigneeName: map['assigneeName'] ?? '',
      awarenessCategoryId: map['awarenessCategoryId'] ?? '',
      awarenessCategoryName: map['awarenessCategoryName'] ?? '',
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      projectId: map['projectId'] ?? '',
      projectName: map['projectName'] ?? '',
      area: map['area'] ?? '',
      notes: map['notes'] ?? '',
      status: map['status'] ?? '',
      source: map['source'] ?? '',
      auditId: map['auditId'] ?? '',
      auditName: map['auditName'] ?? '',
      siteId: map['siteId'] ?? '',
      siteName: map['siteName'] ?? '',
      auditSectionItemId: map['auditSectionItemId'] ?? '',
      auditSectionName: map['auditSectionName'] ?? '',
      isClosed: map['isClosed'] ?? false,
      closedByName: map['closedByName'] ?? '',
      closedOn: map['closedOn'] != null
          ? DateFormat('yyyy-MM-dd').format(DateTime.parse(map['closedOn']))
          : '--',
      createdByUserName: entity.createdByUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionItem.fromJson(String source) =>
      ActionItem.fromMap(json.decode(source) as Map<String, dynamic>);

  ActionItem copyWith({
    String? id,
    String? status,
    String? source,
    String? assigneeId,
    String? assigneeName,
    String? actionRequired,
    String? dueOn,
    String? closedOn,
    String? awarenessCategoryName,
    String? awarenessCategoryId,
    String? observationName,
    String? observationId,
    String? comments,
    String? companyName,
    String? companyId,
    String? area,
    bool? isClosed,
    String? projectId,
    String? projectName,
    String? siteId,
    String? siteName,
    String? createdByUserName,
    String? lastModifiedOn,
    String? lastModifiedByUserName,
    String? closedByName,
    bool? deleted,
    List<String>? columns,

  }) {
    return ActionItem(
      id: id ?? this.id,
      status: status ?? this.status,
      source: source ?? this.source,
      assigneeId: assigneeId ?? this.assigneeId,
      assigneeName: assigneeName ?? this.assigneeName,
      actionRequired: actionRequired ?? this.actionRequired,
      dueOn: dueOn ?? this.dueOn,
      closedOn: closedOn ?? this.closedOn,
      companyName: companyName ?? this.companyName,
      companyId: companyId ?? this.companyId,
      siteName: siteName ?? this.siteName,
      siteId: siteId ?? this.siteId,
      awarenessCategoryId: awarenessCategoryId ?? this.awarenessCategoryId,
      awarenessCategoryName:
          awarenessCategoryName ?? this.awarenessCategoryName,
      observationId: observationId ?? this.observationId,
      observationName: observationName ?? this.observationName,
      comments: comments ?? this.comments,
      area: area ?? this.area,
      projectName: area ?? this.projectName,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      closedByName: closedByName ?? this.closedByName,
      isClosed: isClosed ?? this.isClosed,
      deleted: deleted ?? this.deleted,
      columns: columns ?? this.columns,
    );
  }
}
