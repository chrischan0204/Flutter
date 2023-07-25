// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

import '/common_libraries.dart';

class Audit extends Entity {
  final String? auditNumber;

  final DateTime? auditDate;
  final String? auditStatusName;

  final double completed;

  final String siteId;
  final String? siteName;

  final String? projectId;
  final String? projectName;

  final String templateId;
  final String? templateName;

  final int? sections;
  final int? questions;
  final int? answeredQuestions;

  final String? owner;

  final double score;
  final double maxScore;
  final double obtainedScore;

  final String companies;
  final String inspectors;
  final String area;

  final DateTime? lastExecutedOn;

  final int? observations;
  final int? documents;
  final int? actionItems;

  const Audit({
    super.id,
    super.name,
    this.area = '',
    this.inspectors = '',
    this.companies = '',
    this.auditNumber,
    this.auditDate,
    this.auditStatusName,
    required this.completed,
    required this.siteId,
    this.siteName,
    required this.projectId,
    this.projectName,
    required this.templateId,
    this.templateName,
    this.owner,
    required this.sections,
    required this.questions,
    required this.answeredQuestions,
    required this.maxScore,
    required this.score,
    required this.obtainedScore,
    required this.observations,
    required this.actionItems,
    required this.documents,
    this.lastExecutedOn,
    super.createdOn,
    super.createdByUserName,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.columns,
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
        createdByUserName,
        lastModifiedOn,
        lastModifiedByUserName,
        columns,
        deleted,
      ];

  String get formatedAuditDate =>
      auditDate != null ? DateFormat('d MMMM y').format(auditDate!) : '--';

  String get formatedLastExecutedOn => lastExecutedOn != null
      ? DateFormat('d MMMM y').format(lastExecutedOn!)
      : '--';

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Name': name,
      'Audit Number': auditNumber,
      'Audit Status': auditStatusName,
      'Percent Completed': completed,
      'Site Name': siteName,
      'Template Name': templateName,
      'Owner': owner,
      'Questions': questions ?? 0,
      'Action Items': actionItems ?? 0,
      'Answered Questions': answeredQuestions ?? 0,
      'Area': area,
      'Audit Date': formatedAuditDate,
      'Companies': companies,
      'Created By': createdByUserName,
      'Deleted': deleted,
      'Documents': documents ?? 0,
      'Inspectors': inspectors,
      'Last Executed On': formatedLastExecutedOn,
      'Last Modified On': lastModifiedOn,
      'Modified By': lastModifiedByUserName,
      'Observations': observations,
      'Project Name': projectName,
      'Sections': sections,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Audit': name,
      'Audit Number': auditNumber,
      'Owner': owner,
      'Started on': formatedAuditDate,
      'Completion':
          '${questions == 0 ? 0 : ((100 * answeredQuestions!) ~/ questions!)}% ($answeredQuestions of $questions answered)',
      'Score':
          '${maxScore == 0 ? 0 : (score * 100 ~/ maxScore)}% ($score of $maxScore max points)',
      'Sections': sections,
      'Questions': questions,
      'Site': siteName,
      'Project': projectName ?? '--',
      'Created on': createdOn,
      'Last Updated': lastModifiedOn,
      'Updated by': lastModifiedByUserName,
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {};
  }

  factory Audit.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Audit(
      id: entity.id,
      name: entity.name,
      area: map['area'] ?? '',
      companies: map['companies'] ?? '',
      inspectors: map['inspectors'] ?? '',
      auditNumber: map['auditNumber'],
      auditDate: DateTime.parse(map['auditDate']),
      auditStatusName: map['auditStatusName'],
      completed: map['completed'],
      siteId: map['siteId'],
      siteName: map['siteName'],
      projectId: map['projectId'],
      projectName: map['projectName'] ?? '--',
      templateId: map['templateId'],
      templateName: map['templateName'],
      owner: map['owner'] ?? '',
      score: map['score'] ?? 0,
      obtainedScore: map['obtainedScore'] ?? 0,
      answeredQuestions: map['answeredQuestions'] ?? 0,
      maxScore: map['maxScore'] ?? 0,
      sections: map['sections'] ?? 0,
      questions: map['questions'] ?? 0,
      actionItems: map['actionItems'] ?? 0,
      documents: map['documents'] ?? 0,
      observations: map['observations'] ?? 0,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      createdByUserName: entity.createdByUserName,
      lastModifiedByUserName: map['lastModifiedBy'] ?? '--',
    );
  }

  factory Audit.fromJson(String source) =>
      Audit.fromMap(json.decode(source) as Map<String, dynamic>);

  Audit copyWith({
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
    String? createdByUserName,
    String? lastModifiedOn,
    String? lastModifiedByUserName,
    List<String>? columns,
    bool? deleted,
  }) {
    return Audit(
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
      createdByUserName: createdByUserName ?? this.createdByUserName,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      columns: columns ?? this.columns,
      deleted: deleted ?? this.deleted,
    );
  }
}
