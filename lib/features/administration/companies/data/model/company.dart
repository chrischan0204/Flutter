import 'dart:convert';

import '/data/model/model.dart';

class Company extends Entity {
  final String einNumber;
  final String projects;
  final String sites;

  const Company({
    super.id,
    super.name,
    this.einNumber = '',
    this.projects = '',
    this.sites = '',
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
    super.createdByUserName,
    super.createdOn,
    super.lastModifiedByUserName,
    super.lastModifiedOn,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        einNumber,
      ];

  Company copyWith({
    String? id,
    String? name,
    String? einNumber,
    bool? active,
    String? deactivationDate,
    String? deactivationUserName,
    String? createdOn,
    String? createdByUserName,
    String? lastModifiedByUserName,
    String? lastModifiedOn,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      einNumber: einNumber ?? this.einNumber,
      active: active ?? this.active,
      deactivationDate: deactivationDate ?? this.deactivationDate,
      deactivationUserName: deactivationUserName ?? this.deactivationUserName,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'active': active,
      'einNumber': einNumber,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Name': name,
      'EIN Number': einNumber,
      'Created By': createdByUserName,
      'Created On': createdOn,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'EIN #': einNumber,
      'Sites': {'content': sites},
      'Projects (last 10)': {'content': projects},
      'Active': active,
      'Created On': createdOn,
      'Created By': createdByUserName,
      'Last updated': lastModifiedByUserName,
      'Updated By': lastModifiedOn,
    };
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Name': name,
      'EIN #': einNumber,
      'Created By': createdByUserName,
      'Created On': createdOn,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Company(
      id: entity.id,
      name: entity.name,
      einNumber: map['einNumber'] ?? '',
      sites: map['sites'] ?? '',
      projects: map['projects'] ?? '',
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
      createdByUserName: entity.createdByUserName,
      createdOn: entity.createdOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      lastModifiedOn: entity.lastModifiedOn,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);
}
