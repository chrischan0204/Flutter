import 'dart:convert';

import '/common_libraries.dart';

class FilteredUser extends FilteredEntity {
  final String lastName;
  final String firstName;
  final String mobileNumber;
  final String timeZone;
  final String email;
  final String title;
  final String defaultSite;
  final String role;
  const FilteredUser({
    super.id,
    this.lastName = '',
    this.firstName = '',
    this.mobileNumber = '',
    this.timeZone = '',
    this.email = '',
    this.title = '',
    this.defaultSite = '',
    this.role = '',
    super.createdBy,
    super.createdOn,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.deleted,
  }) : super();

  @override
  List<Object?> get props => [
        ...super.props,
        firstName,
        lastName,
        mobileNumber,
        timeZone,
        email,
        title,
        defaultSite,
        role,
      ];

  factory FilteredUser.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredUser(
      id: entity.id,
      lastName: map['last_Name'] ?? '',
      firstName: map['first_Name'] ?? '',
      mobileNumber: map['mobile_Number'] ?? '',
      timeZone: map['time_Zone'] ?? '',
      email: map['email'] ?? '',
      title: map['title'] ?? '',
      defaultSite: map['default_Site'] ?? '',
      role: map['role'] ?? '',
      createdBy: entity.createdBy,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
    );
  }

  factory FilteredUser.fromJson(String source) =>
      FilteredUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
