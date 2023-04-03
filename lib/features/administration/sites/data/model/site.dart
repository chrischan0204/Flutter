// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '/data/model/model.dart';

class Site extends Entity {
  final String siteCode;
  final String siteType;
  final String referenceCode;
  final String region;
  final String timeZone;
  final int users;
  final int observations;
  final List<AuditTemplate> auditTemplates;
  const Site({
    super.id,
    super.name,
    required this.siteCode,
    required this.siteType,
    required this.referenceCode,
    required this.region,
    required this.timeZone,
    this.users = 0,
    this.observations = 0,
    this.auditTemplates = const [],
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
  });

  @override
  List<Object?> get props => [
        name,
        siteCode,
        siteType,
        referenceCode,
        region,
        timeZone,
        users,
        observations,
        auditTemplates,
      ];

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Name': name,
      'Site Code': siteCode,
      'Reference Code': referenceCode,
      'Region': region,
      'Timezone': timeZone,
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Name': name,
      'Region': region,
      'Time Zone': timeZone,
      'Code': siteCode,
      'Reference Code': referenceCode,
      'Users': 5,
      'Observations': observations,
      'Audit Templates': auditTemplates.length,
    };
  }

  Site copyWith({
    String? id,
    String? name,
    String? siteCode,
    String? siteType,
    String? referenceCode,
    String? region,
    String? timeZone,
    int? users,
    int? observations,
    List<AuditTemplate>? auditTemplates,
    bool? active,
    String? deactivationDate,
    String? deactivationUserName,
  }) {
    return Site(
      id: id ?? this.id,
      name: name ?? this.name,
      siteCode: siteCode ?? this.siteCode,
      siteType: siteType ?? this.siteType,
      referenceCode: referenceCode ?? this.referenceCode,
      region: region ?? this.region,
      timeZone: timeZone ?? this.timeZone,
      users: users ?? this.users,
      observations: observations ?? this.observations,
      auditTemplates: auditTemplates ?? this.auditTemplates,
      active: active ?? this.active,
      deactivationDate: deactivationDate ?? deactivationDate,
      deactivationUserName: deactivationUserName ?? deactivationUserName,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'siteCode': siteCode,
      'referenceCode': referenceCode,
      'region': region,
      'timeZone': timeZone,
      'users': users,
      'observations': observations,
      'auditTemplates': auditTemplates,
    };

    if (id != null) {
      return map..addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  @override
  factory Site.fromMap(Map<String, dynamic> map) {
    return Site(
      id: map['id'] as String,
      name: map['name'] as String,
      siteCode: map['siteCode'] as String,
      siteType: map['siteType'] as String,
      referenceCode: map['referenceCode'] as String,
      region: map['regionName'] as String,
      timeZone: map['timeZoneName'] as String,
      // users: map['users'] as int,
      // observations: map['observations'] as int,
      // auditTemplates: List.from(map['auditTemplates'])
      //     .map((auditTemplateMap) => AuditTemplate.fromMap(auditTemplateMap))
      //     .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) =>
      Site.fromMap(json.decode(source) as Map<String, dynamic>);
}
