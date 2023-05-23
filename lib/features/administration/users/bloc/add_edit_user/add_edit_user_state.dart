part of 'add_edit_user_bloc.dart';

class AddEditUserState extends Equatable {
  final String? createdUserId;

  final String firstName;
  final String firstNameValidationMessage;

  final String lastName;
  final String lastNameValidationMessage;

  final String title;

  final String email;
  final String emailValidationMessage;

  final String mobilePhone;

  final String roleId;
  final String? roleName;
  final String roleValidationMessage;

  final String defaultSiteId;
  final String? defaultSiteName;
  final String defaultSiteValidationMessage;

  final String timeZoneId;
  final String? timeZoneName;

  final List<Role> userRoleList;
  final EntityStatus userRoleListLoadStatus;

  final EntityStatus userAddStatus;
  final EntityStatus userEditStatus;

  final String message;
  final int statusCode;
  const AddEditUserState({
    this.createdUserId,
    this.firstName = '',
    this.firstNameValidationMessage = '',
    this.lastName = '',
    this.lastNameValidationMessage = '',
    this.title = '',
    this.email = '',
    this.emailValidationMessage = '',
    this.mobilePhone = '',
    this.roleId = '',
    this.roleName,
    this.roleValidationMessage = '',
    this.defaultSiteId = '',
    this.defaultSiteName,
    this.defaultSiteValidationMessage = '',
    this.timeZoneId = '',
    this.timeZoneName = '',
    this.userRoleList = const [],
    this.userRoleListLoadStatus = EntityStatus.initial,
    this.userAddStatus = EntityStatus.initial,
    this.userEditStatus = EntityStatus.initial,
    this.message = '',
    this.statusCode = 0,
  });

  @override
  List<Object?> get props => [
        createdUserId,
        firstName,
        firstNameValidationMessage,
        lastName,
        lastNameValidationMessage,
        title,
        email,
        emailValidationMessage,
        mobilePhone,
        roleId,
        roleName,
        roleValidationMessage,
        defaultSiteId,
        defaultSiteName,
        defaultSiteValidationMessage,
        timeZoneId,
        timeZoneName,
        userAddStatus,
        userEditStatus,
        userRoleList,
        userRoleListLoadStatus,
        message,
        statusCode,
      ];

  bool get isUserDataFill => !(Validation.isEmpty(firstName) &&
      Validation.isEmpty(lastName) &&
      Validation.isEmpty(title) &&
      Validation.isEmpty(email) &&
      Validation.isEmpty(roleId) &&
      Validation.isEmpty(defaultSiteId) &&
      Validation.isEmpty(mobilePhone) &&
      Validation.isEmpty(timeZoneId));

  AddEditUserState copyWith({
    String? createdUserId,
    String? firstName,
    String? firstNameValidationMessage,
    String? lastName,
    String? lastNameValidationMessage,
    String? title,
    String? email,
    String? emailValidationMessage,
    String? mobilePhone,
    String? roleId,
    String? roleName,
    String? roleValidationMessage,
    String? defaultSiteId,
    String? defaultSiteName,
    String? defaultSiteValidationMessage,
    String? timeZoneId,
    String? timeZoneName,
    List<Role>? userRoleList,
    EntityStatus? userRoleListLoadStatus,
    EntityStatus? userAddStatus,
    EntityStatus? userEditStatus,
    String? message,
    int? statusCode,
  }) {
    return AddEditUserState(
      createdUserId: createdUserId ?? this.createdUserId,
      firstName: firstName ?? this.firstName,
      firstNameValidationMessage:
          firstNameValidationMessage ?? this.firstNameValidationMessage,
      lastName: lastName ?? this.lastName,
      lastNameValidationMessage:
          lastNameValidationMessage ?? this.lastNameValidationMessage,
      title: title ?? this.title,
      email: email ?? this.email,
      emailValidationMessage:
          emailValidationMessage ?? this.emailValidationMessage,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      roleValidationMessage:
          roleValidationMessage ?? this.roleValidationMessage,
      defaultSiteId: defaultSiteId ?? this.defaultSiteId,
      defaultSiteName: defaultSiteName ?? this.defaultSiteName,
      defaultSiteValidationMessage:
          defaultSiteValidationMessage ?? this.defaultSiteValidationMessage,
      timeZoneId: timeZoneId ?? this.timeZoneId,
      timeZoneName: timeZoneName ?? this.timeZoneName,
      userRoleList: userRoleList ?? this.userRoleList,
      userRoleListLoadStatus:
          userRoleListLoadStatus ?? this.userRoleListLoadStatus,
      userAddStatus: userAddStatus ?? this.userAddStatus,
      userEditStatus: userEditStatus ?? this.userEditStatus,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
