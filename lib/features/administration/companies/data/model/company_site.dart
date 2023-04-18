import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/utils/utils.dart';
import '/data/model/model.dart';

class CompanySite extends Equatable {
  final String? id;
  final String siteId;
  final String siteName;
  final String companyId;
  final String companyName;
  final String roleId;
  final String roleName;
  final String? createdByUserName;
  final String? createdOn;
  bool assigned;
  CompanySite({
    this.id,
    required this.siteId,
    required this.siteName,
    required this.companyId,
    required this.companyName,
    required this.roleId,
    required this.roleName,
    this.createdByUserName,
    this.createdOn,
  }) : assigned = id != null;

  @override
  List<Object?> get props => [
        id,
        siteId,
        siteName,
        companyId,
        companyName,
        roleId,
        roleName,
        createdByUserName,
        createdOn,
        assigned,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'siteId': siteId,
      'siteName': siteName,
      'companyId': companyId,
      'companyName': companyName,
      'roleId': roleId,
      'roleName': roleName,
    };
  }

  Map<String, dynamic> toTableDetailMap() {
    return {
      'siteName': siteName,
      'addedBy': createdOn,
      'addedOn': createdByUserName,
    };
  }

  factory CompanySite.fromMap(Map<String, dynamic> map) {
    return CompanySite(
      id: map['id'],
      siteId: map['siteId'] ?? '',
      siteName: map['siteName'] ?? '',
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      roleId: map['roleId'] ?? '',
      roleName: map['roleName'] ?? '',
      createdByUserName: map['createdByUserName'] ?? '',
      createdOn:
          FormatDate(dateString: map['createdOn'] ?? '', format: 'd MMMM y')
              .formatDate,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanySite.fromJson(String source) =>
      CompanySite.fromMap(json.decode(source) as Map<String, dynamic>);

  CompanySite copyWith({
    String? id,
    String? siteId,
    String? siteName,
    String? companyId,
    String? companyName,
    String? roleId,
    String? roleName,
    String? createdByUserName,
    String? createdOn,
  }) {
    return CompanySite(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  CompanySiteUpdation toCompanySiteUpdation() {
    return CompanySiteUpdation(
      siteId: siteId,
      companyId: companyId,
      roleId: roleId,
    );
  }
}
