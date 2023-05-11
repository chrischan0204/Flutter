part of 'user_list_filter_setting_bloc.dart';

abstract class UserListFilterSettingEvent extends Equatable {
  const UserListFilterSettingEvent();

  @override
  List<Object> get props => [];
}

class UserListFilterSettingFilterSettingListLoaded
    extends UserListFilterSettingEvent {
  final String name;
  const UserListFilterSettingFilterSettingListLoaded({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class UserListFilterSettingUserFilterSettingListLoaded
    extends UserListFilterSettingEvent {
  final String name;
  const UserListFilterSettingUserFilterSettingListLoaded({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class UserListFilterSettingUserFilterSettingLoadedById
    extends UserListFilterSettingEvent {
  final String filterId;
  const UserListFilterSettingUserFilterSettingLoadedById({
    required this.filterId,
  });

  @override
  List<Object> get props => [filterId];
}

class UserListFilterSettingUserFilterSettingDeletedById
    extends UserListFilterSettingEvent {
  final String filterId;
  const UserListFilterSettingUserFilterSettingDeletedById({
    required this.filterId,
  });

  @override
  List<Object> get props => [filterId];
}

class UserListFilterSettingUserFilterSettingUpdated
    extends UserListFilterSettingEvent {
  final UserFilter userFilterUpdate;
  const UserListFilterSettingUserFilterSettingUpdated({
    required this.userFilterUpdate,
  });

  @override
  List<Object> get props => [userFilterUpdate];
}
