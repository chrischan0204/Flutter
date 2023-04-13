import 'dart:convert';

import 'package:equatable/equatable.dart';

class CompanySiteUpdation extends Equatable {
  final String siteId;
  final String companyId;
  final String roleId;
  const CompanySiteUpdation({
    required this.siteId,
    required this.companyId,
    required this.roleId,
  });

  @override
  List<Object?> get props => [
        siteId,
        companyId,
        roleId,
      ];

  CompanySiteUpdation copyWith({
    String? siteId,
    String? companyId,
    String? roleId,
  }) {
    return CompanySiteUpdation(
      siteId: siteId ?? this.siteId,
      companyId: companyId ?? this.companyId,
      roleId: roleId ?? this.roleId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'siteId': siteId,
      'companyId': companyId,
      'roleId': roleId,
    };
  }

  factory CompanySiteUpdation.fromMap(Map<String, dynamic> map) {
    return CompanySiteUpdation(
      siteId: map['siteId'] as String,
      companyId: map['companyId'] as String,
      roleId: map['roleId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanySiteUpdation.fromJson(String source) =>
      CompanySiteUpdation.fromMap(json.decode(source) as Map<String, dynamic>);
}
