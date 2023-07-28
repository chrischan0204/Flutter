import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/utils/utils.dart';
import '/data/model/model.dart';

class ProjectCompany extends Equatable {
  final String id;
  final String projectId;
  final String projectName;
  final String companyId;
  final String companyName;
  final String siteId;
  final String siteName;
  final String roleId;
  final String roleName;
  final String createdByUserName;
  final String? createdOn;
  bool assigned;
  ProjectCompany({
    required this.id,
    required this.projectId,
    this.projectName = '',
    required this.companyId,
    this.companyName = '',
    required this.siteId,
    this.siteName = '',
    required this.roleId,
    this.roleName = '',
    this.createdByUserName = '',
    this.createdOn,
  }) : assigned = id.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        projectId,
        projectName,
        companyId,
        companyName,
        siteId,
        siteName,
        roleId,
        roleName,
        createdByUserName,
        createdOn,
        assigned,
      ];

  Map<String, dynamic> toTableDetailMap() {
    return <String, dynamic>{
      'Company Name': companyName,
      'Role': roleName,
      'Added By': createdByUserName,
      'Added on': createdOn,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'projectId': projectId,
      'projectName': projectName,
      'companyId': companyId,
      'companyName': companyName,
      'roleId': roleId,
      'roleName': roleName,
      'siteId': siteId,
      'siteName': siteName,
    };
  }

  factory ProjectCompany.fromMap(Map<String, dynamic> map) {
    return ProjectCompany(
      id: map['id'],
      projectId: map['projectId'] ?? '',
      projectName: map['projectName'] ?? '',
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      roleId: map['roleId'] ?? '',
      roleName: map['roleName'] ?? '',
      siteId: map['siteId'] ?? '',
      siteName: map['siteName'] ?? '',
      createdByUserName: map['createdByUserName'] ?? '',
      createdOn: map['createdOn'] == null
          ? ''
          : FormatDate(dateString: map['createdOn'] ?? '', format: 'MM/d/yyyy')
              .formatDate,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectCompany.fromJson(String source) =>
      ProjectCompany.fromMap(json.decode(source) as Map<String, dynamic>);

  ProjectCompany copyWith({
    String? id,
    String? projectId,
    String? projectName,
    String? companyId,
    String? companyName,
    String? siteId,
    String? siteName,
    String? roleId,
    String? roleName,
    String? createdByUserName,
    String? createdOn,
  }) {
    return ProjectCompany(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  ProjectCompanyAssignment toProjectCompanyAssignment() {
    return ProjectCompanyAssignment(
      projectId: projectId,
      companyId: companyId,
      roleId: roleId,
    );
  }
}
