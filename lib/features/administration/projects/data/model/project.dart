import 'dart:convert';

import '/data/model/model.dart';

class Project extends Entity {
  final String regionName;
  final String siteName;
  final String siteId;
  final String referenceNumber;
  final String referneceName;
  final int companyCount;
  final String timeZoneName;
  final String companies;

  const Project({
    super.id,
    super.name,
    this.regionName = '',
    this.siteName = '',
    this.timeZoneName = '',
    this.siteId = '',
    this.referenceNumber = '',
    this.referneceName = '',
    this.companyCount = 0,
    this.companies = '',
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
    super.createdOn,
    super.createdByUserName,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.columns = const [],
    super.deleted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        regionName,
        siteName,
        siteId,
        timeZoneName,
        referenceNumber,
        referneceName,
        active,
        deactivationDate,
        deactivationUserName,
        companyCount,
        createdOn,
        createdByUserName,
        lastModifiedOn,
        lastModifiedByUserName,
        companies,
      ];

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'siteId': siteId,
      'referenceNumber': referenceNumber,
      'referenceName': referneceName,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Name': name,
      'Region': regionName,
      'Site': siteName,
      'Companies': companyCount,
      'Deactivated On': deactivationDate,
      'Reference Name': referneceName,
      'Reference Number': referenceNumber,
      'Active': active,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Name': name,
      'Region': regionName,
      'Site': siteName,
      'Active': active,
      'Reference Code': referenceNumber,
      'Reference Name': referneceName,
      'Created on': createdOn,
      'Created By': createdByUserName,
      'Last updated': lastModifiedOn,
      'Updated By': lastModifiedByUserName,
      'Companies': {'content': companies},
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Name': name,
      'Site': siteName,
      'Region': regionName,
      'Time Zone': timeZoneName,
      'Reference Code': referenceNumber,
      'Reference Name': referneceName,
      'Companies': companyCount,
      'Created By': createdByUserName,
      'Created On': createdOn,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Project(
      id: entity.id,
      name: entity.name,
      regionName:
          map['regionName'] == null ? '' : (map['regionName'] as String),
      siteId: map['siteId'] as String,
      siteName: map['siteName'] as String,
      timeZoneName: map['timeZoneName'] ?? '',
      referenceNumber: map['referenceNumber'] as String,
      referneceName: map['referenceName'] as String,
      companyCount: map['companyCount'] as int,
      companies: map['contractors'] ?? '',
      createdOn: entity.createdOn,
      createdByUserName: entity.createdByUserName,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  Project copyWith({
    String? id,
    String? name,
    String? regionName,
    String? companies,
    String? regionId,
    String? siteName,
    String? siteId,
    String? referenceNumber,
    String? referneceName,
    int? companyCount,
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
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      regionName: regionName ?? this.regionName,
      companies: companies ?? this.companies,
      siteName: siteName ?? this.siteName,
      siteId: siteId ?? this.siteId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      referneceName: referneceName ?? this.referneceName,
      companyCount: companyCount ?? this.companyCount,
      active: active ?? this.active,
      deactivationDate: deactivationDate ?? this.deactivationDate,
      deactivationUserName: deactivationUserName ?? this.deactivationUserName,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      columns: columns ?? this.columns,
      deleted: deleted ?? this.deleted,
    );
  }
}
