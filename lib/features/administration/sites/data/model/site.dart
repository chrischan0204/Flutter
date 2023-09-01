import 'dart:convert';

import '/data/model/model.dart';

class Site extends Entity {
  final String siteCode;
  final String siteTypeId;
  final String siteTypeName;
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
    this.siteTypeId = '',
    this.siteTypeName = '',
    this.referenceCode = '',
    this.region = '',
    this.regionId = '',
    this.timeZone = '',
    this.timeZoneId = '',
    this.users = 0,
    this.observations = 0,
    this.auditTemplates = 0,
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
    super.createdByUserName,
    super.createdOn,
    super.lastModifiedByUserName,
    super.lastModifiedOn,
    super.columns,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        siteCode,
        siteTypeId,
        siteTypeName,
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
      'Site Type': siteTypeName,
      'Region': region,
      'Timezone': timeZone,
      'Active': active,
      'Created By': createdByUserName,
      'Created On': createdOn,
      'Last Modified By': lastModifiedByUserName,
      'Last Modified On': lastModifiedOn,
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Name': name,
      'Region': region,
      'Time Zone': timeZone,
      'Site Code': siteCode,
      'Reference Code': referenceCode,
      'Users': users,
      'Observations': observations,
      'Audit Templates': auditTemplates,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Site Code': siteCode,
      'Reference Code': referenceCode,
      'Region': region,
      'Time Zone': timeZone,
      'Active': active,
      'Created On': createdOn,
      'Created By': createdByUserName,
      'Updated On': lastModifiedOn,
      'Updated By': lastModifiedByUserName,
    };
  }

  Site copyWith({
    String? id,
    String? name,
    String? siteCode,
    String? siteTypeId,
    String? siteTypeName,
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
    String? createdOn,
    String? createdByUserName,
    String? lastModifiedByUserName,
    String? lastModifiedOn,
    List<String>? columns,
    bool? deleted,
  }) {
    return Site(
      id: id ?? this.id,
      name: name ?? this.name,
      siteCode: siteCode ?? this.siteCode,
      siteTypeId: siteTypeId ?? this.siteTypeId,
      siteTypeName: siteTypeName ?? this.siteTypeName,
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
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      columns: columns ?? this.columns,
      deleted: deleted ?? this.deleted,
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
      'siteTypeId': siteTypeId,
    };

    if (id != null) {
      return map..addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  @override
  factory Site.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Site(
      id: entity.id,
      name: entity.name,
      siteCode: map['siteCode'],
      siteTypeId: map['siteTypeId'] == null ? '' : map['siteTypeId'] as String,
      siteTypeName:
          map['siteTypeName'] == null ? '' : map['siteTypeName'] as String,
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
      createdByUserName: entity.createdByUserName,
      createdOn: entity.createdOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      lastModifiedOn: entity.lastModifiedOn,
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) =>
      Site.fromMap(json.decode(source) as Map<String, dynamic>);
}
