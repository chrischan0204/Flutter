// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      'Site Access': siteAccess,
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
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      'roleId': roleName,
      'title': title,
      'defaultSiteName': defaultSiteName,
      'siteAccess': siteAccess,
      'timeZoneId': timeZoneId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return User(
      id: entity.id,
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      mobileNumber: map['mobileNumber'],
      inviteSent: map['inviteSent'],
      roleName: map['roleName'],
      roleId: map['roleId'],
      title: map['title'],
      defaultSiteName: map['defaultSiteName'],
      defaultSiteId: map['defaultSiteId'],
      siteAccess: map['siteAccess'],
      timeZoneName: map['timeZoneName'],
      timeZoneId: map['timeZoneId'],
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