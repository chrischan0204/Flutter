// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_user_bloc.dart';

abstract class AddEditUserEvent extends Equatable {
  const AddEditUserEvent();

  @override
  List<Object?> get props => [];
}

class AddEditUserDetailsInited extends AddEditUserEvent {
  final User user;
  const AddEditUserDetailsInited({
    required this.user,
  });
}

class AddEditUserFirstNameChanged extends AddEditUserEvent {
  final String firstName;
  const AddEditUserFirstNameChanged({required this.firstName});

  @override
  List<Object?> get props => [firstName];
}

class AddEditUserLastNameChanged extends AddEditUserEvent {
  final String lastName;
  const AddEditUserLastNameChanged({required this.lastName});

  @override
  List<Object?> get props => [lastName];
}

class AddEditUserTitleChanged extends AddEditUserEvent {
  final String title;
  const AddEditUserTitleChanged({required this.title});

  @override
  List<Object?> get props => [title];
}

class AddEditUserEmailChanged extends AddEditUserEvent {
  final String email;
  const AddEditUserEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class AddEditUserMobilePhoneChanged extends AddEditUserEvent {
  final String mobilePhone;
  const AddEditUserMobilePhoneChanged({required this.mobilePhone});

  @override
  List<Object?> get props => [mobilePhone];
}

class AddEditUserDefaultSiteChanged extends AddEditUserEvent {
  final String defaultSiteId;
  final String defaultSiteName;

  const AddEditUserDefaultSiteChanged({
    required this.defaultSiteId,
    required this.defaultSiteName,
  });

  @override
  List<Object?> get props => [
        defaultSiteId,
        defaultSiteName,
      ];
}

class AddEditUserRoleChanged extends AddEditUserEvent {
  final String roleId;
  final String roleName;
  const AddEditUserRoleChanged({
    required this.roleId,
    required this.roleName,
  });

  @override
  List<Object?> get props => [
        roleId,
        roleName,
      ];
}

class AddEditUserTimeZoneChanged extends AddEditUserEvent {
  final String timeZoneId;
  final String timeZoneName;
  const AddEditUserTimeZoneChanged({
    required this.timeZoneId,
    required this.timeZoneName,
  });

  @override
  List<Object?> get props => [
        timeZoneId,
        timeZoneName,
      ];
}

class AddEditUserUserAdded extends AddEditUserEvent {}

class AddEditUserUserEdited extends AddEditUserEvent {
  final String userId;
  const AddEditUserUserEdited({
    required this.userId,
  });
}

class AddEditUserStatusInited extends AddEditUserEvent {}

class AddEditUserRoleListLoaded extends AddEditUserEvent {}
