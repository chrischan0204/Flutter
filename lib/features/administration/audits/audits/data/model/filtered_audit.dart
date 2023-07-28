import 'package:intl/intl.dart';

import '/common_libraries.dart';

class FilteredAudit extends FilteredEntity {
  final String? name;
  final String? auditNumber;

  final DateTime? auditDate;
  final String? auditStatusName;

  final double? completed;

  final String? siteId;
  final String? siteName;

  final String? projectId;
  final String? projectName;

  final String? templateId;
  final String? templateName;

  final int? sections;
  final int? questions;
  final int? answeredQuestions;

  final String? owner;

  final double? score;
  final double? maxScore;
  final double? obtainedScore;

  final String companies;
  final String inspectors;
  final String area;

  final DateTime? lastExecutedOn;

  final int? observations;
  final int? documents;
  final int? actionItems;

  const FilteredAudit({
    super.id,
    this.name,
    this.area = '',
    this.inspectors = '',
    this.companies = '',
    this.auditNumber,
    this.auditDate,
    this.auditStatusName,
    required this.completed,
    this.siteId = emptyGuid,
    this.siteName,
    this.projectId = emptyGuid,
    this.projectName,
    this.templateId = emptyGuid,
    this.templateName,
    this.owner,
    this.sections = 0,
    this.questions = 0,
    this.answeredQuestions = 0,
    required this.maxScore,
    required this.score,
    required this.obtainedScore,
    required this.observations,
    required this.actionItems,
    required this.documents,
    this.lastExecutedOn,
    super.createdOn,
    super.createdBy,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        area,
        companies,
        inspectors,
        auditNumber,
        auditDate,
        auditStatusName,
        completed,
        siteId,
        siteName,
        projectId,
        projectName,
        templateId,
        templateName,
        owner,
        sections,
        questions,
        answeredQuestions,
        maxScore,
        obtainedScore,
        score,
        lastExecutedOn,
        createdOn,
        createdBy,
        lastModifiedOn,
        lastModifiedByUserName,
        deleted,
      ];

  String get formatedAuditDate =>
      auditDate != null ? DateFormat('MM/d/yyyy').format(auditDate!) : '--';

  String get formatedLastExecutedOn => lastExecutedOn != null
      ? DateFormat('MM/d/yyyy').format(lastExecutedOn!)
      : '--';

  Audit get audit => Audit(
        id: id,
        name: name,
        auditDate: auditDate,
        completed: completed ?? 0,
        auditNumber: auditNumber,
        auditStatusName: auditStatusName,
        siteId: siteId ?? emptyGuid,
        siteName: siteName,
        projectId: projectId,
        projectName: projectName,
        templateId: templateId ?? emptyGuid,
        templateName: templateName,
        owner: owner,
        sections: sections ?? 0,
        questions: questions ?? 0,
        answeredQuestions: answeredQuestions ?? 0,
        maxScore: maxScore ?? 0,
        score: score ?? 0,
        area: area,
        obtainedScore: obtainedScore ?? 0,
        observations: observations ?? 0,
        actionItems: actionItems ?? 0,
        documents: documents ?? 0,
        companies: companies,
        inspectors: inspectors,
        createdByUserName: createdBy,
        createdOn: createdOn,
        lastExecutedOn: lastExecutedOn,
        lastModifiedOn: lastModifiedOn,
        lastModifiedByUserName: lastModifiedByUserName,
        deleted: deleted,
      );

  factory FilteredAudit.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredAudit(
      id: entity.id,
      name: map['name'],
      area: map['area'] ?? '',
      companies: map['companies'] ?? '',
      inspectors: map['inspectors'] ?? '',
      auditNumber: map['audit_Number'] ?? '',
      auditDate:
          map['audit_Date'] != null ? DateTime.parse(map['audit_Date']) : null,
      auditStatusName: map['audit_Status'] ?? '',
      completed: map['percent_Completed'] ?? 0,
      // siteId: map['siteId'],
      siteName: map['site_Name'] ?? '',
      // projectId: map['projectId'],
      projectName: map['project_Name'] ?? '',
      // templateId: map['templateId'],
      templateName: map['template_Name'] ?? '',
      owner: map['owner'] ?? '',
      score: map['score'] ?? 0,
      lastExecutedOn: map['last_Executed_On'] != null
          ? DateTime.parse(map['last_Executed_On'])
          : null,
      obtainedScore: map['obtainedScore'] ?? 0,
      answeredQuestions: map['answered_Questions'] ?? 0,
      maxScore: map['maxScore'] ?? 0,
      sections: map['sections'] ?? 0,
      questions: map['questions'] ?? 0,
      actionItems: map['action_Items'] ?? 0,
      documents: map['documents'] ?? 0,
      observations: map['observations'] ?? 0,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      createdBy: entity.createdBy,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
    );
  }

  factory FilteredAudit.fromJson(String source) =>
      FilteredAudit.fromMap(json.decode(source) as Map<String, dynamic>);

  FilteredAudit copyWith({
    String? id,
    String? name,
    String? auditNumber,
    DateTime? auditDate,
    String? auditStatusName,
    double? completed,
    String? siteId,
    String? siteName,
    String? projectId,
    String? projectName,
    String? templateId,
    String? templateName,
    int? sections,
    int? questions,
    int? answeredQuestions,
    String? owner,
    double? score,
    double? maxScore,
    double? obtainedScore,
    String? companies,
    String? inspectors,
    String? area,
    DateTime? lastExecutedOn,
    int? observations,
    int? documents,
    int? actionItems,
    String? createdOn,
    String? createdBy,
    String? lastModifiedOn,
    String? lastModifiedByUserName,
    List<String>? columns,
    bool? deleted,
  }) {
    return FilteredAudit(
      id: id ?? this.id,
      name: name ?? this.name,
      auditNumber: auditNumber ?? this.auditNumber,
      auditDate: auditDate ?? this.auditDate,
      auditStatusName: auditStatusName ?? this.auditStatusName,
      completed: completed ?? this.completed,
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      templateId: templateId ?? this.templateId,
      templateName: templateName ?? this.templateName,
      sections: sections ?? this.sections,
      questions: questions ?? this.questions,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      owner: owner ?? this.owner,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      obtainedScore: obtainedScore ?? this.obtainedScore,
      companies: companies ?? this.companies,
      inspectors: inspectors ?? this.inspectors,
      area: area ?? this.area,
      lastExecutedOn: lastExecutedOn ?? this.lastExecutedOn,
      observations: observations ?? this.observations,
      documents: documents ?? this.documents,
      actionItems: actionItems ?? this.actionItems,
      createdOn: createdOn ?? this.createdOn,
      createdBy: createdBy ?? this.createdBy,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      deleted: deleted ?? this.deleted,
    );
  }
}
