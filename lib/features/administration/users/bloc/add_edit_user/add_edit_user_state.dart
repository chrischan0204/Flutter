// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_user_bloc.dart';

class AddEditUserState extends Equatable {
  /// created user id
  final String? createdUserId;

  /// loaded user
  final User? loadedUser;

  /// first name
  final String firstName;

  /// validation message for first name
  final String firstNameValidationMessage;

  /// initial first name to check form dirty
  final String initialFirstName;

  /// last name
  final String lastName;

  /// validation message for last name
  final String lastNameValidationMessage;

  /// initial last name to check form dirty
  final String initialLastName;

  /// title
  final String title;

  /// initial title to check form dirty
  final String initialTitle;

  /// validation message for title
  final String titleValidationMessage;

  /// email
  final String email;

  /// validation message for email
  final String emailValidationMessage;

  /// initial email to check form dirty
  final String initialEmail;

  /// mobile phone
  final String mobilePhone;

  /// initial mobile phone to check form dirty
  final String initialMobilePhone;

  /// validation message for mobile phone
  final String mobilePhoneValidationMessage;

  /// role
  final Role? role;

  /// initial role to check form dirty
  final Role? initialRole;

  /// validation message for role
  final String roleValidationMessage;

  /// default site
  final Site? defaultSite;

  /// initial default site to check form dirty
  final Site? initialDefaultSite;

  /// validation message for default site
  final String defaultSiteValidationMessage;

  /// time zone
  final TimeZone? timeZone;

  /// initial time zone to check form dirty
  final TimeZone? initialTimeZone;

  /// validation message for time zone
  final String timeZoneValidationMessage;

  /// site list
  final List<Site> siteList;

  /// role list
  final List<Role> roleList;

  /// time zone list
  final List<TimeZone> timeZoneList;

  final EntityStatus status;

  final String message;

  const AddEditUserState({
    this.createdUserId,
    this.loadedUser,
    this.firstName = '',
    this.firstNameValidationMessage = '',
    this.initialFirstName = '',
    this.lastName = '',
    this.lastNameValidationMessage = '',
    this.initialLastName = '',
    this.title = '',
    this.initialTitle = '',
    this.titleValidationMessage = '',
    this.email = '',
    this.emailValidationMessage = '',
    this.initialEmail = '',
    this.mobilePhone = '',
    this.initialMobilePhone = '',
    this.mobilePhoneValidationMessage = '',
    this.role,
    this.initialRole,
    this.roleValidationMessage = '',
    this.defaultSite,
    this.initialDefaultSite,
    this.defaultSiteValidationMessage = '',
    this.timeZone,
    this.initialTimeZone,
    this.timeZoneValidationMessage = '',
    this.roleList = const [],
    this.timeZoneList = const [],
    this.siteList = const [],
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        createdUserId,
        loadedUser,
        firstName,
        firstNameValidationMessage,
        initialFirstName,
        lastName,
        lastNameValidationMessage,
        initialLastName,
        title,
        title,
        titleValidationMessage,
        email,
        emailValidationMessage,
        initialEmail,
        mobilePhone,
        initialMobilePhone,
        mobilePhoneValidationMessage,
        role,
        initialRole,
        roleValidationMessage,
        defaultSite,
        initialDefaultSite,
        defaultSiteValidationMessage,
        timeZone,
        initialTimeZone,
        timeZoneValidationMessage,
        roleList,
        timeZoneList,
        siteList,
        status,
        message,
      ];

  bool get formDirty =>
      (!Validation.isEmpty(firstName) && initialFirstName != firstName) ||
      (!Validation.isEmpty(lastName) && initialLastName != lastName) ||
      (!Validation.isEmpty(title) && initialTitle != title) ||
      (!Validation.isEmpty(email) && initialEmail != email) ||
      (!Validation.isEmpty(mobilePhone) && initialMobilePhone != mobilePhone) ||
      (role != null && initialRole?.id != role?.id) ||
      (timeZone != null && initialTimeZone?.id != timeZone?.id) ||
      (defaultSite != null && initialDefaultSite?.id != defaultSite?.id) ||
      (timeZone != null && initialTimeZone?.id != timeZone?.id);

  User get user => User(
        firstName: firstName,
        lastName: lastName,
        title: title,
        email: email,
        mobileNumber: mobilePhone,
        roleId: role!.id,
        defaultSiteId: defaultSite!.id!,
        timeZoneId: timeZone!.id!,
      );

  AddEditUserState copyWith({
    String? createdUserId,
    User? loadedUser,
    String? firstName,
    String? firstNameValidationMessage,
    String? initialFirstName,
    String? lastName,
    String? lastNameValidationMessage,
    String? initialLastName,
    String? title,
    String? initialTitle,
    String? titleValidationMessage,
    String? email,
    String? emailValidationMessage,
    String? initialEmail,
    String? mobilePhone,
    String? initialMobilePhone,
    String? mobilePhoneValidationMessage,
    Role? role,
    Role? initialRole,
    String? roleValidationMessage,
    Site? defaultSite,
    Site? initialDefaultSite,
    String? defaultSiteValidationMessage,
    TimeZone? timeZone,
    TimeZone? initialTimeZone,
    String? timeZoneValidationMessage,
    List<Role>? roleList,
    List<TimeZone>? timeZoneList,
    List<Site>? siteList,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditUserState(
      createdUserId: createdUserId ?? this.createdUserId,
      loadedUser: loadedUser ?? this.loadedUser,
      firstName: firstName ?? this.firstName,
      firstNameValidationMessage:
          firstNameValidationMessage ?? this.firstNameValidationMessage,
      initialFirstName: initialFirstName ?? this.initialFirstName,
      lastName: lastName ?? this.lastName,
      lastNameValidationMessage:
          lastNameValidationMessage ?? this.lastNameValidationMessage,
      initialLastName: initialLastName ?? this.initialLastName,
      title: title ?? this.title,
      initialTitle: initialTitle ?? this.initialTitle,
      titleValidationMessage:
          titleValidationMessage ?? this.titleValidationMessage,
      email: email ?? this.email,
      emailValidationMessage:
          emailValidationMessage ?? this.emailValidationMessage,
      initialEmail: initialEmail ?? this.initialEmail,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      initialMobilePhone: initialMobilePhone ?? this.initialMobilePhone,
      mobilePhoneValidationMessage:
          mobilePhoneValidationMessage ?? this.mobilePhoneValidationMessage,
      role: role ?? this.role,
      initialRole: initialRole ?? this.initialRole,
      roleValidationMessage:
          roleValidationMessage ?? this.roleValidationMessage,
      defaultSite: defaultSite ?? this.defaultSite,
      initialDefaultSite: initialDefaultSite ?? this.initialDefaultSite,
      defaultSiteValidationMessage:
          defaultSiteValidationMessage ?? this.defaultSiteValidationMessage,
      timeZone: timeZone ?? this.timeZone,
      initialTimeZone: initialTimeZone ?? this.initialTimeZone,
      timeZoneValidationMessage:
          timeZoneValidationMessage ?? this.timeZoneValidationMessage,
      roleList: roleList ?? this.roleList,
      timeZoneList: timeZoneList ?? this.timeZoneList,
      siteList: siteList ?? this.siteList,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
