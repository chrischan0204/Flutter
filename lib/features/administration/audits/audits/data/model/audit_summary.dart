import 'package:intl/intl.dart';

import '/common_libraries.dart';

class AuditSummary extends Equatable {
  final String id;
  final String createdBy;
  final DateTime createdOn;
  final String? lastModifiedBy;
  final DateTime? lastModifiedOn;
  final String? name;
  final String? auditNumber;
  final String ownerId;
  final String? owner;
  final String? area;
  final DateTime auditDate;
  final String siteId;
  final String? siteName;
  final String? projectId;
  final String? projectName;
  final String auditStatusId;
  final String? auditStatusName;
  final String? createdByUserName;
  final String? companies;
  final String? inspectors;
  final String templateId;
  final String? templateName;
  final String? lastModifiedByUserName;
  final bool deleted;
  final DateTime? lastExecutedOn;
  final int? sections;
  final int questions;
  final int answeredQuestions;
  final double completedPercent;
  final double score;
  final int actionItems;
  final int observations;
  final int documents;

  const AuditSummary({
    required this.id,
    required this.createdBy,
    required this.createdOn,
    this.lastModifiedBy,
    this.lastModifiedOn,
    this.name,
    this.auditNumber,
    required this.ownerId,
    this.owner,
    this.area,
    required this.auditDate,
    required this.siteId,
    this.siteName,
    this.projectId,
    this.projectName,
    required this.auditStatusId,
    this.auditStatusName,
    this.createdByUserName,
    this.companies,
    this.inspectors,
    required this.templateId,
    this.templateName,
    this.lastModifiedByUserName,
    required this.deleted,
    this.lastExecutedOn,
    this.sections,
    required this.questions,
    required this.answeredQuestions,
    required this.completedPercent,
    required this.actionItems,
    required this.observations,
    required this.documents,
    required this.score,
  });

  @override
  List<Object?> get props => [
        id,
        createdBy,
        createdOn,
        lastModifiedBy,
        lastModifiedOn,
        name,
        auditNumber,
        ownerId,
        owner,
        area,
        auditDate,
        siteId,
        siteName,
        projectId,
        projectName,
        auditStatusId,
        auditStatusName,
        createdByUserName,
        companies,
        inspectors,
        templateId,
        templateName,
        lastModifiedByUserName,
        deleted,
        lastExecutedOn,
        sections,
        questions,
        answeredQuestions,
        completedPercent,
        actionItems,
        observations,
        documents,
        score,
      ];

  String get formatedLastModifiedOn => lastModifiedOn != null
      ? DateFormat('MM/d/yyyy').format(lastModifiedOn!)
      : '--';

  String get formatedLastExecutedOn => lastExecutedOn != null
      ? DateFormat('MM/d/yyyy').format(lastExecutedOn!)
      : '--';

  String get formatedCreatedOn => DateFormat('MM/d/yyyy').format(createdOn);

  String get formatedAuditDate => DateFormat('MM/d/yyyy').format(auditDate);

  Audit get audit => Audit(
        name: name,
        owner: owner,
        auditDate: auditDate,
        completed: completedPercent,
        siteId: siteId,
        projectId: projectId,
        templateId: templateId,
        sections: sections ?? 0,
        questions: questions,
        answeredQuestions: answeredQuestions,
        maxScore: 0,
        score: score,
        obtainedScore: 0,
        actionItems: 0,
        documents: 0,
        observations: 0,
      );

  AuditSummary copyWith({
    String? id,
    String? createdBy,
    DateTime? createdOn,
    String? lastModifiedBy,
    DateTime? lastModifiedOn,
    String? name,
    String? auditNumber,
    String? ownerId,
    String? owner,
    String? area,
    DateTime? auditDate,
    String? siteId,
    String? siteName,
    String? projectId,
    String? projectName,
    String? auditStatusId,
    String? auditStatusName,
    String? createdByUserName,
    String? companies,
    String? inspectors,
    String? templateId,
    String? templateName,
    String? lastModifiedByUserName,
    bool? deleted,
    DateTime? lastExecutedOn,
    int? sections,
    int? questions,
    int? answeredQuestions,
    double? completedPercent,
    int? actionItems,
    int? observations,
    int? documents,
    double? score,
  }) {
    return AuditSummary(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      name: name ?? this.name,
      auditNumber: auditNumber ?? this.auditNumber,
      ownerId: ownerId ?? this.ownerId,
      owner: owner ?? this.owner,
      area: area ?? this.area,
      auditDate: auditDate ?? this.auditDate,
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      auditStatusId: auditStatusId ?? this.auditStatusId,
      auditStatusName: auditStatusName ?? this.auditStatusName,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      companies: companies ?? this.companies,
      inspectors: inspectors ?? this.inspectors,
      templateId: templateId ?? this.templateId,
      templateName: templateName ?? this.templateName,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      deleted: deleted ?? this.deleted,
      lastExecutedOn: lastExecutedOn ?? this.lastExecutedOn,
      sections: sections ?? this.sections,
      questions: questions ?? this.questions,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      completedPercent: completedPercent ?? this.completedPercent,
      actionItems: actionItems ?? this.actionItems,
      observations: observations ?? this.observations,
      documents: documents ?? this.documents,
      score: score ?? this.score,
    );
  }

  factory AuditSummary.fromMap(Map<String, dynamic> map) {
    return AuditSummary(
      id: map['id'] as String,
      createdBy: map['createdBy'] as String,
      createdOn: DateTime.parse(map['createdOn']),
      lastModifiedBy: map['lastModifiedBy'] != null
          ? map['lastModifiedBy'] as String
          : null,
      lastModifiedOn: map['lastModifiedOn'] != null
          ? DateTime.parse(map['lastModifiedOn'])
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      auditNumber:
          map['auditNumber'] != null ? map['auditNumber'] as String : null,
      ownerId: map['ownerId'] as String,
      owner: map['owner'] != null ? map['owner'] as String : null,
      area: map['area'] != null ? map['area'] as String : null,
      auditDate: DateTime.parse(map['auditDate']),
      siteId: map['siteId'] as String,
      siteName: map['siteName'] != null ? map['siteName'] as String : null,
      projectId: map['projectId'] != null ? map['projectId'] as String : null,
      projectName:
          map['projectName'] != null ? map['projectName'] as String : null,
      auditStatusId: map['auditStatusId'] as String,
      auditStatusName: map['auditStatusName'] != null
          ? map['auditStatusName'] as String
          : null,
      createdByUserName: map['createdByUserName'] != null
          ? map['createdByUserName'] as String
          : null,
      companies: map['companies'] != null ? map['companies'] as String : null,
      inspectors:
          map['inspectors'] != null ? map['inspectors'] as String : null,
      templateId: map['templateId'] as String,
      templateName:
          map['templateName'] != null ? map['templateName'] as String : null,
      lastModifiedByUserName: map['lastModifiedByUserName'] != null
          ? map['lastModifiedByUserName'] as String
          : null,
      deleted: map['deleted'] as bool,
      lastExecutedOn: map['lastExecutedOn'] != null
          ? DateTime.parse(map['lastExecutedOn'])
          : null,
      sections: map['sections'] != null ? map['sections'] as int : null,
      questions: map['questions'] as int,
      answeredQuestions: map['answeredQuestions'] as int,
      completedPercent: map['completedPercent'] as double,
      actionItems: map['actionItems'] as int,
      observations: map['observations'] as int,
      documents: map['documents'] as int,
      score: map['score'] ?? 0,
    );
  }

  factory AuditSummary.fromJson(String source) =>
      AuditSummary.fromMap(json.decode(source) as Map<String, dynamic>);
}
