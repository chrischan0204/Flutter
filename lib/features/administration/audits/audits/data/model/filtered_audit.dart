import 'package:intl/intl.dart';

import '/common_libraries.dart';

class FilteredAudit extends FilteredEntity {
  final String name;

  final String? auditNumber;

  final DateTime auditDate;
  final String? auditStatusName;

  final double completed;

  final String siteId;
  final String? siteName;

  final String? projectName;

  final String templateId;
  final String? templateName;

  final String? owner;

  final double score;

  const FilteredAudit({
    super.id,
    required this.name,
    this.auditNumber,
    required this.auditDate,
    this.auditStatusName,
    required this.completed,
    required this.siteId,
    this.siteName,
    this.projectName,
    required this.templateId,
    this.templateName,
    this.owner,
    required this.score,
    super.createdOn,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        auditNumber,
        auditDate,
        auditStatusName,
        completed,
        siteId,
        siteName,
        projectName,
        templateId,
        templateName,
        owner,
        score,
        createdOn,
        lastModifiedOn,
        lastModifiedByUserName,
        deleted,
      ];

  String get formatedAuditDate => DateFormat('d MMMM y').format(auditDate);

  FilteredAudit copyWith({
    String? id,
    String? name,
    String? auditNumber,
    DateTime? auditDate,
    String? auditStatusName,
    double? completed,
    String? siteId,
    String? siteName,
    String? projectName,
    String? templateId,
    String? templateName,
    String? owner,
    double? score,
    String? lastModifiedOn,
    String? createdOn,
    bool? deleted,
    List<String>? columns,
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
      projectName: projectName ?? this.projectName,
      templateId: templateId ?? this.templateId,
      templateName: templateName ?? this.templateName,
      owner: owner ?? this.owner,
      score: score ?? this.score,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      deleted: deleted ?? this.deleted,
    );
  }

  factory FilteredAudit.fromMap(Map<String, dynamic> map) {
    return FilteredAudit(
      id: map['id'],
      auditNumber: map['auditNumber'],
      auditDate: DateTime.parse(map['auditDate']),
      auditStatusName: map['auditStatusName'],
      completed: map['completed'] as double,
      siteId: map['siteId'],
      siteName: map['siteName'],
      projectName: map['projectName'],
      templateId: map['templateId'],
      templateName: map['templateName'],
      owner: map['owner'] ?? '',
      score: map['score'],
      createdOn: map['createdOn'],
      lastModifiedOn: map['lastModifiedOn'],
      lastModifiedByUserName: map['lastModifiedByUserName'],
      name: map['name'],
    );
  }

  factory FilteredAudit.fromJson(String source) =>
      FilteredAudit.fromMap(json.decode(source) as Map<String, dynamic>);
}
