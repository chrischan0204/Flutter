import '/common_libraries.dart';

class FilteredAudit extends FilteredEntity {
  final String? name;
  final String? auditNumber;
  final String auditDate;
  final String? auditStatusName;
  final double completed;
  final String? siteName;
  final String? projectName;
  final String? templateName;
  final String? owner;
  final double score;

  const FilteredAudit({
    super.id,
    this.name,
    this.auditNumber,
    required this.auditDate,
    this.auditStatusName,
    required this.completed,
    this.siteName,
    this.projectName,
    this.templateName,
    this.owner,
    required this.score,
    super.createdOn,
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
        siteName,
        projectName,
        templateName,
        owner,
        score,
      ];

  String get formatedAuditDate => auditDate.isNotEmpty
      ? FormatDate(format: 'd MMMM y', dateString: auditDate).formatDate
      : '--';

  Audit get audit => Audit(
        id: id,
        name: name,
        auditNumber: auditNumber,
        auditDate: auditDate,
        auditStatusName: auditStatusName,
        completed: completed,
        siteName: siteName,
        projectName: projectName,
        templateName: templateName,
        owner: owner,
        score: score,
      );

  Audit copyWith({
    String? id,
    String? name,
    String? auditNumber,
    String? auditDate,
    String? auditStatusName,
    double? completed,
    String? siteName,
    String? projectName,
    String? templateName,
    String? owner,
    double? score,
    String? createdOn,
    bool? deleted,
    List<String>? columns,
  }) {
    return Audit(
      id: id ?? this.id,
      name: name ?? this.name,
      auditNumber: auditNumber ?? this.auditNumber,
      auditDate: auditDate ?? this.auditDate,
      auditStatusName: auditStatusName ?? this.auditStatusName,
      completed: completed ?? this.completed,
      siteName: siteName ?? this.siteName,
      projectName: projectName ?? this.projectName,
      templateName: templateName ?? this.templateName,
      owner: owner ?? this.owner,
      score: score ?? this.score,
      createdOn: createdOn ?? this.createdOn,
      deleted: deleted ?? this.deleted,
    );
  }

  factory FilteredAudit.fromMap(Map<String, dynamic> map) {
    return FilteredAudit(
      auditNumber: map['auditNumber'],
      auditDate: map['auditDate'],
      auditStatusName: map['auditStatusName'],
      completed: map['completed'] as double,
      siteName: map['siteName'],
      projectName: map['projectName'],
      templateName: map['templateName'],
      owner: map['owner'],
      score: map['score'],
    );
  }

  factory FilteredAudit.fromJson(String source) =>
      FilteredAudit.fromMap(json.decode(source) as Map<String, dynamic>);
}
