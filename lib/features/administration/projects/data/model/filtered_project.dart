import 'dart:convert';

import '/common_libraries.dart';

class FilteredProject extends FilteredEntity {
  final String name;
  final String region;
  final String site;
  final int companies;
  const FilteredProject({
    super.id,
    this.name = '',
    this.region = '',
    this.site = '',
    this.companies = 0,
    super.createdBy,
    super.createdOn,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.deleted,
  }) : super();

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        region,
        site,
        companies,
      ];

  factory FilteredProject.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredProject(
      id: entity.id,
      createdBy: entity.createdBy,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
    );
  }

  factory FilteredProject.fromJson(String source) =>
      FilteredProject.fromMap(json.decode(source) as Map<String, dynamic>);
}
