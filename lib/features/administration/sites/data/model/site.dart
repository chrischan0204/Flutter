// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '/data/model/model.dart';

class Site extends Entity {
  final String siteCode;
  final String referenceCode;
  final Region region;
  final TimeZone timeZone;
  final int users;
  final int observations;
  final int auditTemplates;
  const Site({
    super.id,
    super.name,
    required this.siteCode,
    required this.referenceCode,
    required this.region,
    required this.timeZone,
    required this.users,
    required this.observations,
    required this.auditTemplates,
  });

  @override
  List<Object?> get props => [
        name,
        siteCode,
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
      'Region': region.name,
      'Timezone': timeZone.name,
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Name': name,
      'Site Code': siteCode,
      'Reference Code': referenceCode,
      'Region': region.name,
      'Timezone': timeZone.name,
    };
  }

  Site copyWith({
    String? id,
    String? name,
    String? siteCode,
    String? referenceCode,
    Region? region,
    TimeZone? timeZone,
    int? users,
    int? observations,
    int? auditTemplates,
  }) {
    return Site(
      id: id ?? this.id,
      name: name ?? this.name,
      siteCode: siteCode ?? this.siteCode,
      referenceCode: referenceCode ?? this.referenceCode,
      region: region ?? this.region,
      timeZone: timeZone ?? this.timeZone,
      users: users ?? this.users,
      observations: observations ?? this.observations,
      auditTemplates: auditTemplates ?? this.auditTemplates,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'siteCode': siteCode,
      'referenceCode': referenceCode,
      'region': region.toMap(),
      'timeZone': timeZone.toMap(),
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
      referenceCode: map['referenceCode'] as String,
      region: Region.fromMap(map['region'] as Map<String, dynamic>),
      timeZone: TimeZone.fromMap(map['timeZone'] as Map<String, dynamic>),
      users: map['users'] as int,
      observations: map['observations'] as int,
      auditTemplates: map['auditTemplates'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) =>
      Site.fromMap(json.decode(source) as Map<String, dynamic>);
}
