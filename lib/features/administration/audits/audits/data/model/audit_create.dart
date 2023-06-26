// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/common_libraries.dart';

class AuditCreate extends Equatable {
  final String? id;
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
    this.id,
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
        id,
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
    Map<String, dynamic> map = <String, dynamic>{
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
    if (id != null) {
      map.addEntries([MapEntry('id', id!)]);
    }
    return map;
  }

  String toJson() => json.encode(toMap());

  AuditCreate copyWith({
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
  }) {
    return AuditCreate(
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
    );
  }
}
