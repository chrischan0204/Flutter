// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '/data/model/model.dart';

class Project extends Entity {
  final String regionName;
  final String siteName;
  final String siteId;
  final String referenceNumber;
  final String referneceName;
  final int companyCount;
  final String? createdOn;
  final String? createdByUserName;
  final String? lastModifiedOn;
  final String? updatedByUserName;
  final List<String> contractors;

  const Project({
    super.id,
    super.name,
    this.regionName = '',
    this.siteName = '',
    this.siteId = '',
    this.referenceNumber = '',
    this.referneceName = '',
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
    this.companyCount = 0,
    this.createdOn,
    this.createdByUserName,
    this.lastModifiedOn,
    this.updatedByUserName,
    this.contractors = const [
      'Garmont Pavers',
      'Lionheart Painting Company',
      'Greenline Signage',
    ],
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'siteId': siteId,
      'referenceNumber': referenceNumber,
      'referneceName': referneceName,
    };
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Name': name,
      'Region': regionName,
      'Site': siteName,
      'Contractors': contractors.length,
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
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
      'Contractors': contractors.join(', '),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Project(
      id: entity.id,
      name: entity.name,
      regionName:
          map['regionName'] == null ? '' : (map['regionName'] as String),
      siteName: map['siteName'] as String,
      referenceNumber: map['referenceNumber'] as String,
      referneceName: map['referenceName'] as String,
      companyCount: map['companyCount'] as int,
      createdOn: map['createdOn'] == null ? '' : (map['createdOn'] as String),
      createdByUserName: map['createdByUserName'] == null
          ? ''
          : (map['createdByUserName'] as String),
      lastModifiedOn: map['lastModifiedOn'] == null
          ? ''
          : (map['lastModifiedOn'] as String),
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
