import 'dart:convert';

import 'package:safety_eta/utils/utils.dart';

import '/data/model/model.dart';

class Project extends Entity {
  final String regionName;
  final String siteName;
  final String siteId;
  final String referenceNumber;
  final String referneceName;
  final int companyCount;
  final String? updatedByUserName;
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
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
    this.companyCount = 0,
    super.createdOn,
    super.createdByUserName,
    super.lastModifiedOn,
    this.updatedByUserName,
    this.companies = '',
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
        updatedByUserName,
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
      'Updated By': updatedByUserName,
      'Companies': {'content': companies},
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Name': name,
      'Site': siteName,
      'Region': regionName,
      'Time Zone': active,
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
      referenceNumber: map['referenceNumber'] as String,
      referneceName: map['referenceName'] as String,
      companyCount: map['companyCount'] as int,
      companies: map['contractors'] ?? '',
      createdOn: map['createdOn'] == null
          ? ''
          : FormatDate(
                  dateString: map['createdOn'] as String, format: 'd MMMM y')
              .formatDate,
      createdByUserName: map['createdByUserName'] == null
          ? ''
          : (map['createdByUserName'] as String),
      lastModifiedOn: map['lastModifiedOn'] == null
          ? ''
          : FormatDate(
                  dateString: map['lastModifiedOn'] as String,
                  format: 'd MMMM y')
              .formatDate,
      updatedByUserName: map['updatedByUserName'] == null
          ? ''
          : (map['updatedByUserName'] as String),
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
    );
  }
}
