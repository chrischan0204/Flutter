import '/common_libraries.dart';

class AuditCreate extends Equatable {
  final String name;
  final String userId;
  final String auditDate;
  final String templateId;
  final String siteId;
  final String? projectId;
  final String? area;
  final String? companies;
  final String? inspectors;

  const AuditCreate({
    required this.name,
    required this.userId,
    required this.auditDate,
    required this.templateId,
    required this.siteId,
    this.projectId,
    this.area,
    this.companies,
    this.inspectors,
  });

  @override
  List<Object?> get props => [
        name,
        userId,
        auditDate,
        templateId,
        siteId,
        projectId,
        area,
        companies,
        inspectors,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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

  String toJson() => json.encode(toMap());
}
