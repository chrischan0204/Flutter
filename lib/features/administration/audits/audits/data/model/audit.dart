import '/common_libraries.dart';

class Audit extends Entity {
  final String? auditNumber;
  final String auditDate;
  final String? auditStatusName;
  final double completed;
  final String? siteName;
  final String? projectName;
  final String? templateName;
  final String? owner;
  final double score;

  const Audit({
    super.id,
    super.name,
    this.auditNumber,
    required this.auditDate,
    this.auditStatusName,
    required this.completed,
    this.siteName,
    this.projectName,
    this.templateName,
    this.owner,
    required this.score,
    super.createdByUserName,
    super.createdOn,
    super.columns,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
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

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Audit': name,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Audit': name,
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Template Description': name,
    };
  }

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
    String? createdByUserName,
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
      createdByUserName: createdByUserName ?? this.createdByUserName,
      deleted: deleted ?? this.deleted,
      columns: columns ?? this.columns,
    );
  }

  factory Audit.fromMap(Map<String, dynamic> map) {
    return Audit(
      id: map['id'],
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

  factory Audit.fromJson(String source) =>
      Audit.fromMap(json.decode(source) as Map<String, dynamic>);
}
