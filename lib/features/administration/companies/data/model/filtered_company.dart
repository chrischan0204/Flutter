import 'dart:convert';

import '/common_libraries.dart';

class FilteredCompany extends FilteredEntity {
  final String name;
  final String ein;
  const FilteredCompany({
    super.id,
    this.name = '',
    this.ein = '',
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
        ein,
      ];

  factory FilteredCompany.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredCompany(
      id: entity.id,
      name: map['name'] ?? '',
      ein: map['ein'] ?? '',
      createdBy: entity.createdBy,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
    );
  }

  factory FilteredCompany.fromJson(String source) =>
      FilteredCompany.fromMap(json.decode(source) as Map<String, dynamic>);

  Company toCompany() {
    return Company(
      id: id,
      name: name,
      einNumber: ein,
      createdByUserName: createdBy,
      createdOn: createdOn,
      lastModifiedByUserName: lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn,
    );
  }
}
