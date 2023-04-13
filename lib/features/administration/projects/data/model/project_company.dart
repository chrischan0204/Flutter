import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/utils/utils.dart';
import '/data/model/model.dart';

class ProjectCompany extends Equatable {
  final String id;
  final String projectId;
  final String? projectName;
  final String companyId;
  final String? companyName;
  final String roleId;
  final String? roleName;
  final String? createdByUserName;
  final String? createdOn;
  const ProjectCompany({
    required this.id,
    required this.projectId,
    this.projectName,
    required this.companyId,
    this.companyName,
    required this.roleId,
    this.roleName,
    this.createdByUserName,
    this.createdOn,
  });

  @override
  List<Object?> get props => [
        id,
        projectId,
        projectName,
        companyId,
        companyName,
        roleId,
        roleName,
        createdByUserName,
        createdOn,
      ];

  Map<String, dynamic> toTableDetailMap() {
    return <String, dynamic>{
      'Company Name': companyName,
      'Role': roleName,
      'Added By': 'Adam Drobot',
      'Added on': '3rd Oct 2022',
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
    };
  }

  factory ProjectCompany.fromMap(Map<String, dynamic> map) {
    return ProjectCompany(
      id: map['id'],
      projectId: map['projectId'] as String,
      projectName: map['projectName'],
      companyId: map['companyId'] as String,
      companyName: map['companyName'],
      roleId: map['roleId'] as String,
      roleName: map['roleName'] as String,
      createdByUserName: map['createdByUserName'],
      createdOn:
          FormatDate(dateString: map['createdOn'] as String, format: 'd MMMM y')
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
