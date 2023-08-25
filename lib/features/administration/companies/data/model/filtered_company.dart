
import '/common_libraries.dart';

class FilteredCompany extends FilteredEntity {
  final String name;
  final String ein;
  final bool active;
  const FilteredCompany({
    super.id,
    this.name = '',
    this.ein = '',
    this.active = true,
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
        active,
      ];

  factory FilteredCompany.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredCompany(
      id: entity.id,
      name: map['name'] ?? '',
      ein: map['ein'] ?? '',
      active: map['active'] ?? true,
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
      active: active,
      createdByUserName: createdBy,
      createdOn: createdOn,
      lastModifiedByUserName: lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn,
      deleted: deleted,
    );
  }
}
