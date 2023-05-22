import 'dart:convert';

import '/data/model/entity.dart';

class User extends Entity {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final bool inviteSent;
  final String roleName;
  final String roleId;
  final String title;
  final String defaultSiteName;
  final String defaultSiteId;
  final String siteAccess;
  final String timeZoneName;
  final String timeZoneId;

  const User({
    super.id,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.mobileNumber = '',
    this.inviteSent = false,
    this.roleName = '',
    this.roleId = '',
    this.title = '',
    this.defaultSiteName = '',
    this.defaultSiteId = '',
    this.siteAccess = '',
    this.timeZoneName = '',
    this.timeZoneId = '',
    super.active,
    super.createdByUserName,
    super.createdOn,
    super.lastModifiedByUserName,
    super.lastModifiedOn,
    super.columns = const [],
    super.deleted,
  }) : super(name: '$firstName $lastName');

  @override
  List<Object?> get props => [
        ...super.props,
        firstName,
        lastName,
        email,
        mobileNumber,
        inviteSent,
        roleName,
        roleId,
        title,
        defaultSiteName,
        defaultSiteId,
        siteAccess,
        timeZoneName,
        timeZoneId,
      ];

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    bool? inviteSent,
    String? roleName,
    String? roleId,
    String? title,
    String? defaultSiteName,
    String? defaultSiteId,
    String? siteAccess,
    String? timeZoneName,
    String? timeZoneId,
    String? createdOn,
    String? createdByUserName,
    String? lastModifiedByUserName,
    String? lastModifiedOn,
    List<String>? columns,
    bool? deleted,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      inviteSent: inviteSent ?? this.inviteSent,
      roleName: roleName ?? this.roleName,
      roleId: roleId ?? this.roleId,
      title: title ?? this.title,
      defaultSiteName: defaultSiteName ?? this.defaultSiteName,
      defaultSiteId: defaultSiteId ?? this.defaultSiteId,
      siteAccess: siteAccess ?? this.siteAccess,
      timeZoneName: timeZoneName ?? this.timeZoneName,
      timeZoneId: timeZoneId ?? this.timeZoneId,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      columns: columns ?? this.columns,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'Role': roleName,
      'Title': title,
      'Default Site': defaultSiteName,
      'Mobile Number': mobileNumber,
      'Time Zone': timeZoneName,
      'Email': email,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'Title': title,
      'Email': email,
      'Role': roleName,
      'Default Site': defaultSiteName,
      'Mobile Number': mobileNumber,
      'Invite Sent': inviteSent,
      'Site Access': {'content': siteAccess},
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Name': '$firstName $lastName',
      'Title': title,
      'Role': roleName,
      'Email': email,
      'Phone': mobileNumber,
      'Default Site': defaultSiteName,
      'Site Access': siteAccess,
      'Timezone': timeZoneName,
      'Active': active,
      'Created By': createdByUserName,
      'Created On': createdOn,
      'Last Updated By': lastModifiedByUserName,
      'Last Updated On': lastModifiedOn,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      'userRoleId': roleId,
      'siteId': defaultSiteId,
      'title': title,
      'timeZoneId': timeZoneId,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return User(
      id: entity.id,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      inviteSent: map['inviteSent'] ?? false,
      roleName: map['roleName'] ?? '',
      roleId: map['userRoleId'] ?? '',
      title: map['title'] ?? '',
      defaultSiteName: map['siteName'] ?? '',
      defaultSiteId: map['siteId'] ?? '',
      siteAccess: map['sites'] ?? '',
      timeZoneName: map['timeZoneName'] ?? '',
      timeZoneId: map['timeZoneId'] ?? '',
      active: entity.active,
      createdByUserName: entity.createdByUserName,
      createdOn: entity.createdOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      lastModifiedOn: entity.lastModifiedOn,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
