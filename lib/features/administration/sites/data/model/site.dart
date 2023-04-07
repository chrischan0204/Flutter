// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '/data/model/model.dart';

class Site extends Entity {
  final String siteCode;
  final String siteType;
  final String referenceCode;
  final String region;
  final String regionId;
  final String timeZone;
  final String timeZoneId;
  final int users;
  final int observations;
  final int auditTemplates;
  const Site({
    super.id,
    super.name,
    this.siteCode = '',
    this.siteType = '',
    this.referenceCode = '',
    this.region = '',
    this.regionId = '',
    this.timeZone = '',
    this.timeZoneId = '',
    this.users = 20,
    this.observations = 0,
    this.auditTemplates = 0,
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
  });

  @override
  List<Object?> get props => [
        id,
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

  bool get deletable => users == 0 && observations == 0 && auditTemplates == 0;

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
      'Users': users,
      'Observations': observations,
      'Audit Templates': auditTemplates,
    };
  }

  Site copyWith({
    String? id,
    String? name,
    String? siteCode,
    String? siteType,
    String? referenceCode,
    String? region,
    String? regionId,
    String? timeZone,
    String? timeZoneId,
    int? users,
    int? observations,
    int? auditTemplates,
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
      regionId: regionId ?? this.regionId,
      timeZone: timeZone ?? this.timeZone,
      timeZoneId: timeZoneId ?? this.timeZoneId,
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
      'regionId': regionId,
      'timeZoneId': timeZoneId,
      'siteType': siteType,
    };

    if (id != null) {
      return map..addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  @override
  factory Site.fromMap(Map<String, dynamic> map) {
    return Site(
      id: map['id'] == null ? null : map['id'] as String,
      name: map['name'],
      siteCode: map['siteCode'],
      siteType: map['siteType'] == null ? '' : map['siteType'] as String,
      referenceCode: map['referenceCode'],
      region: map['regionName'],
      regionId: map['regionId'] ?? '',
      timeZoneId: map['timeZoneId'] ?? '',
      timeZone: map['timeZoneName'],
      users: map['userCount'] == null ? 0 : map['userCount'] as int,
      observations:
          map['observationCount'] == null ? 0 : map['observationCount'] as int,
      auditTemplates: map['auditTemplateCount'] == null
          ? 0
          : map['auditTemplateCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) =>
      Site.fromMap(json.decode(source) as Map<String, dynamic>);
}
