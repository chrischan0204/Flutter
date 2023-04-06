import 'dart:convert';

class ProjectCompanyAssignment {
  final String projectId;
  final String companyId;
  final String roleId;
  ProjectCompanyAssignment({
    required this.projectId,
    required this.companyId,
    required this.roleId,
  });

  ProjectCompanyAssignment copyWith({
    String? projectId,
    String? companyId,
    String? roleId,
  }) {
    return ProjectCompanyAssignment(
      projectId: projectId ?? this.projectId,
      companyId: companyId ?? this.companyId,
      roleId: roleId ?? this.roleId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'projectId': projectId,
      'companyId': companyId,
      'roleId': roleId,
    };
  }

  factory ProjectCompanyAssignment.fromMap(Map<String, dynamic> map) {
    return ProjectCompanyAssignment(
      projectId: map['projectId'] as String,
      companyId: map['companyId'] as String,
      roleId: map['roleId'] as String,
    );
  }
  
  String toJson() => json.encode(toMap());

  factory ProjectCompanyAssignment.fromJson(String source) =>
      ProjectCompanyAssignment.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
