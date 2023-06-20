// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '/common_libraries.dart';

class FilteredAudit extends FilteredEntity {
  final String userId;
  final String auditDate;
  final String templateId;
  final String siteId;
  final String? projectId;
  final String? area;
  final String? companies;
  final String? inspectors;
  const FilteredAudit({
    super.id,
    required this.userId,
    required this.auditDate,
    required this.templateId,
    required this.siteId,
    this.projectId,
    this.area,
    this.companies,
    this.inspectors,
    super.createdBy,
    super.createdById,
    super.createdOn,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.deleted,
  }) : super();

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

  Audit toAudit() {
    return Audit(
      userId: userId,
      auditDate: auditDate,
      templateId: templateId,
      siteId: siteId,
    );
  }

  factory FilteredAudit.fromMap(Map<String, dynamic> map) {
    return FilteredAudit(
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

  factory FilteredAudit.fromJson(String source) =>
      FilteredAudit.fromMap(json.decode(source) as Map<String, dynamic>);
}
