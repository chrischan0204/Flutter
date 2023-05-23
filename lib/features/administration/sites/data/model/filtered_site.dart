import 'dart:convert';

import '/common_libraries.dart';

class FilteredSite extends FilteredEntity {
  final String name;
  final String siteCode;
  final String siteType;
  final String referenceCode;
  final String region;
  final String timeZone;
  final bool active;
  const FilteredSite({
    super.id,
    this.name = '',
    this.region = '',
    this.siteCode = '',
    this.referenceCode = '',
    this.timeZone = '',
    this.active = true,
    this.siteType = '',
    super.createdBy,
    super.createdOn,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        region,
        siteCode,
        referenceCode,
        timeZone,
      ];

  factory FilteredSite.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredSite(
      id: entity.id,
      name: map['name'] ?? '',
      region: map['region'] ?? '',
      siteCode: map['site_Code'] ?? '',
      referenceCode: map['reference_Code'] ?? '',
      timeZone: map['timezone'] ?? '',
      siteType: map['site_Type'] ?? '',
      active: map['active'] ?? true,
      createdBy: entity.createdBy,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
    );
  }

  factory FilteredSite.fromJson(String source) =>
      FilteredSite.fromMap(json.decode(source) as Map<String, dynamic>);

  Site toSite() {
    return Site(
      id: id,
      name: name,
      siteCode: siteCode,
      referenceCode: referenceCode,
      timeZone: timeZone,
      region: region,
      siteType: siteType,
      active: active,
      createdByUserName: createdBy,
      createdOn: createdOn,
      lastModifiedByUserName: lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn,
      deleted: deleted,
    );
  }
}
