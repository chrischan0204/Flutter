// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_user_bloc.dart';

abstract class AddEditUserEvent extends Equatable {
  const AddEditUserEvent();

  @override
  List<Object?> get props => [];
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
  final Site defaultSite;

  const AddEditUserDefaultSiteChanged({required this.defaultSite});

  @override
  List<Object?> get props => [defaultSite];
}

class AddEditUserRoleChanged extends AddEditUserEvent {
  final Role role;
  const AddEditUserRoleChanged({required this.role});

  @override
  List<Object?> get props => [role];
}

class AddEditUserTimeZoneChanged extends AddEditUserEvent {
  final TimeZone timeZone;
  const AddEditUserTimeZoneChanged({required this.timeZone});

  @override
  List<Object?> get props => [timeZone];
}

class AddEditUserUserAdded extends AddEditUserEvent {}

class AddEditUserUserEdited extends AddEditUserEvent {
  final String userId;
  const AddEditUserUserEdited({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AddEditUserLoaded extends AddEditUserEvent {
  final String userId;
  const AddEditUserLoaded({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class AddEditUserRoleListLoaded extends AddEditUserEvent {}

class AddEditUserSiteListLoaded extends AddEditUserEvent {}

class AddEditUserTimeZoneListLoaded extends AddEditUserEvent {}
