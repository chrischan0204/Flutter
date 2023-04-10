import 'dart:convert';

import '/data/model/model.dart';

class Company extends Entity {
  final String einNumber;
  final List<Project> projects;
  final List<Site> sites;

  const Company({
    super.id,
    super.name,
    this.einNumber = '',
    this.projects = const [],
    this.sites = const [],
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
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
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      einNumber: einNumber ?? this.einNumber,
      active: active ?? this.active,
      deactivationDate: deactivationDate ?? deactivationDate,
      deactivationUserName: deactivationUserName ?? deactivationUserName,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'einNumber': einNumber,
      'active': active,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'EIN #': einNumber,
      'Sites': sites.map((site) => site.name ?? '').join(', '),
      'Projects (last 10)':
          projects.map((project) => project.name ?? '').join(', '),
      'Active': active,
      'Created On': '3/11/2020',
      'Created By': 'Gary Verb',
      'Last updated': '9/19/2021',
      'Updated By': 'Hesh Carlson',
    };
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Name': name,
      'EIN #': einNumber,
      'Created By': 'Gary Verb',
      'Created On': '3/11/2020',
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Company(
      id: entity.id,
      name: entity.name,
      einNumber: map['einNumber'] as String,
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);
}
