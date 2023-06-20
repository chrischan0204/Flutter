import '/common_libraries.dart';

class Audit extends Entity {
  final String userId;
  final String auditDate;
  final String templateId;
  final String siteId;
  final String? projectId;
  final String? area;
  final String? companies;
  final String? inspectors;

  const Audit({
    super.id,
    super.name,
    required this.userId,
    required this.auditDate,
    required this.templateId,
    required this.siteId,
    this.projectId,
    this.area,
    this.companies,
    this.inspectors,
    super.active,
    super.createdByUserName,
    super.createdOn,
    super.columns,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        userId,
        auditDate,
        templateId,
        siteId,
        projectId,
        area,
        companies,
        inspectors,
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
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'auditDate': auditDate,
      'templateId': templateId,
      'siteId': siteId,
      'projectId': projectId,
      'area': area,
      'companies': companies,
      'inspectors': inspectors,
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
    String? userId,
    String? auditDate,
    String? templateId,
    String? siteId,
    String? projectId,
    String? area,
    String? companies,
    String? inspectors,
    bool? active,
    String? createdOn,
    String? createdByUserName,
    bool? deleted,
    List<String>? columns,
  }) {
    return Audit(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      auditDate: auditDate ?? this.auditDate,
      templateId: templateId ?? this.templateId,
      siteId: siteId ?? this.siteId,
      projectId: projectId ?? this.projectId,
      area: area ?? this.area,
      companies: companies ?? this.companies,
      inspectors: inspectors ?? this.inspectors,
      active: active ?? this.active,
      createdOn: createdOn ?? this.createdOn,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      deleted: deleted ?? this.deleted,
      columns: columns ?? this.columns,
    );
  }

  factory Audit.fromMap(Map<String, dynamic> map) {
    return Audit(
      userId: map['userId'] as String,
      auditDate: map['auditDate'] as String,
      templateId: map['templateId'] as String,
      siteId: map['siteId'] as String,
      projectId: map['projectId'] != null ? map['projectId'] as String : null,
      area: map['area'] != null ? map['area'] as String : null,
      companies: map['companies'] != null ? map['companies'] as String : null,
      inspectors:
          map['inspectors'] != null ? map['inspectors'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Audit.fromJson(String source) =>
      Audit.fromMap(json.decode(source) as Map<String, dynamic>);
}
