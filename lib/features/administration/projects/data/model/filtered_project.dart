
import 'package:intl/intl.dart';

import '/common_libraries.dart';

class FilteredProject extends FilteredEntity {
  final String name;
  final String region;
  final String site;
  final int companies;
  final String referenceName;
  final String referenceNumber;
  final bool active;
  final String deactivatedOn;
  const FilteredProject({
    super.id,
    this.name = '',
    this.region = '',
    this.site = '',
    this.companies = 0,
    this.referenceName = '',
    this.referenceNumber = '',
    this.active = true,
    this.deactivatedOn = '--',
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
        site,
        companies,
        referenceName,
        referenceNumber,
        active,
        deactivatedOn,
      ];

  factory FilteredProject.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredProject(
      id: entity.id,
      name: map['name'] ?? '',
      region: map['region'] ?? '',
      site: map['site'] ?? '',
      companies: map['companies'] ?? 0,
      referenceName: map['reference_Name'] ?? '',
      referenceNumber: map['reference_Number'] ?? '',
      active: map['active'] ?? true,
      deactivatedOn: map['deactivated_On'] != null
          ? DateFormat('MM/dd/yyyy')
              .format(DateTime.parse(map['deactivated_On']))
          : '--',
      createdBy: entity.createdBy,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
    );
  }

  factory FilteredProject.fromJson(String source) =>
      FilteredProject.fromMap(json.decode(source) as Map<String, dynamic>);

  Project toProject() {
    return Project(
      id: id,
      name: name,
      regionName: region,
      siteName: site,
      companyCount: companies,
      referneceName: referenceName,
      referenceNumber: referenceNumber,
      active: active,
      deactivationDate: deactivatedOn,
      createdByUserName: createdBy,
      createdOn: createdOn,
      lastModifiedByUserName: lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn,
      deleted: deleted,
    );
  }
}
