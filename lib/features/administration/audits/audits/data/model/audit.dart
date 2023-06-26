// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

import '/common_libraries.dart';

class Audit extends Entity {
  final String? auditNumber;

  final DateTime auditDate;
  final String? auditStatusName;

  final double completed;

  final String siteId;
  final String? siteName;

  final String? projectId;
  final String? projectName;

  final String templateId;
  final String? templateName;

  final int sections;
  final int questions;
  final int answeredQuestions;

  final String? owner;

  final double score;
  final double maxScore;

  final String companies;
  final String inspectors;
  final String area;
  const Audit({
    super.id,
    super.name,
    this.area = '',
    this.inspectors = '',
    this.companies = '',
    this.auditNumber,
    required this.auditDate,
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
        score,
        createdOn,
        createdByUserName,
        lastModifiedOn,
        lastModifiedByUserName,
        columns,
        deleted,
      ];

  String get formatedAuditDate => DateFormat('d MMMM y').format(auditDate);

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Audit': name,
      'Status': auditStatusName,
      'Complete': completed,
      'Site': siteName,
      'Template': templateName,
      'Onwer': owner,
      'Score': score,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Audit': name,
      'Onwer': owner,
      'Started on': formatedAuditDate,
      'Completion': completed,
      'Score': score,
      'Sections': sections,
      'Questions': questions,
      'Site': siteName,
      'Project': projectName ?? '--',
      'Created on': createdOn,
      'Created by': createdByUserName,
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
      completed: map['completed'] as double,
      siteId: map['siteId'],
      siteName: map['siteName'],
      projectId: map['projectId'],
      projectName: map['projectName'],
      templateId: map['templateId'],
      templateName: map['templateName'],
      owner: map['owner'] ?? '',
      score: map['score'],
      answeredQuestions: map['answeredQuestions'],
      maxScore: map['maxScore'],
      sections: map['sections'],
      questions: map['questions'],
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      createdByUserName: entity.createdByUserName,
      lastModifiedByUserName: entity.lastModifiedByUserName,
    );
  }

  factory Audit.fromJson(String source) =>
      Audit.fromMap(json.decode(source) as Map<String, dynamic>);

  Audit copyWith({
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
  }) {
    return Audit(
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
    );
  }
}
