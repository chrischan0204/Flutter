// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_user_bloc.dart';

abstract class AddEditUserEvent extends Equatable {
  const AddEditUserEvent();

  @override
  List<Object?> get props => [];
}

/// event to change first name to create user
class AddEditUserFirstNameChanged extends AddEditUserEvent {
  final String firstName;
  const AddEditUserFirstNameChanged({required this.firstName});

  @override
  List<Object?> get props => [firstName];
}

/// event to change last name to create user
class AddEditUserLastNameChanged extends AddEditUserEvent {
  final String lastName;
  const AddEditUserLastNameChanged({required this.lastName});

  @override
  List<Object?> get props => [lastName];
}

/// event to change user title to create user
class AddEditUserTitleChanged extends AddEditUserEvent {
  final String title;
  const AddEditUserTitleChanged({required this.title});

  @override
  List<Object?> get props => [title];
}

/// event to change email to cteate user
class AddEditUserEmailChanged extends AddEditUserEvent {
  final String email;
  const AddEditUserEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

/// event to change mobile phone to create user
class AddEditUserMobilePhoneChanged extends AddEditUserEvent {
  final String mobilePhone;
  const AddEditUserMobilePhoneChanged({required this.mobilePhone});

  @override
  List<Object?> get props => [mobilePhone];
}

/// event to change default site to create user
class AddEditUserDefaultSiteChanged extends AddEditUserEvent {
  final Site defaultSite;

  const AddEditUserDefaultSiteChanged({required this.defaultSite});

  @override
  List<Object?> get props => [defaultSite];
}

/// event to change role to create user
class AddEditUserRoleChanged extends AddEditUserEvent {
  final Role role;
  const AddEditUserRoleChanged({required this.role});

  @override
  List<Object?> get props => [role];
}

/// event to change time zone to create user
class AddEditUserTimeZoneChanged extends AddEditUserEvent {
  final TimeZone timeZone;
  const AddEditUserTimeZoneChanged({required this.timeZone});

  @override
  List<Object?> get props => [timeZone];
}

/// event to add new user
class AddEditUserUserAdded extends AddEditUserEvent {}

/// event to edit current user
class AddEditUserUserEdited extends AddEditUserEvent {
  final String userId;
  const AddEditUserUserEdited({required this.userId});

  @override
  List<Object?> get props => [userId];
}

/// event to load user detail
class AddEditUserLoaded extends AddEditUserEvent {
  final String userId;
  const AddEditUserLoaded({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

/// event to load role list to create user
class AddEditUserRoleListLoaded extends AddEditUserEvent {}

/// event to load site list to create user
class AddEditUserSiteListLoaded extends AddEditUserEvent {}

/// event to load time zone list to create user
class AddEditUserTimeZoneListLoaded extends AddEditUserEvent {}
