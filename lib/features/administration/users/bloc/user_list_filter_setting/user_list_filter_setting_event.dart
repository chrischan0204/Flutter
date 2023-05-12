// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_list_filter_setting_bloc.dart';

abstract class UserListFilterSettingEvent extends Equatable {
  const UserListFilterSettingEvent();

  @override
  List<Object?> get props => [];
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

class UserListFilterSettingUserFilterNameChanged
    extends UserListFilterSettingEvent {
  final String filterName;
  const UserListFilterSettingUserFilterNameChanged({
    required this.filterName,
  });

  @override
  List<Object> get props => [filterName];
}

class UserListFilterSettingUserFilterIsDefaultChanged
    extends UserListFilterSettingEvent {
  final bool isDefault;
  const UserListFilterSettingUserFilterIsDefaultChanged({
    required this.isDefault,
  });

  @override
  List<Object> get props => [isDefault];
}

class UserListFilterSettingUserFilterSettingUpdated
    extends UserListFilterSettingEvent {}

class UserListFilterSettingUserFilterSettingSelected
    extends UserListFilterSettingEvent {
  final UserFilterSetting? userFilterSetting;

  const UserListFilterSettingUserFilterSettingSelected({
    this.userFilterSetting,
  });

  @override
  List<Object?> get props => [userFilterSetting];
}

class UserListFilterSettingUserFilterItemAdded
    extends UserListFilterSettingEvent {
  final UserFilterItem? userFilterItem;
  const UserListFilterSettingUserFilterItemAdded({
    this.userFilterItem,
  });

  @override
  List<Object?> get props => [userFilterItem];
}

class UserListFilterSettingUserFilterAdded extends UserListFilterSettingEvent {}

class UserListFilterSettingUserFilterItemDeleted
    extends UserListFilterSettingEvent {
  final UserFilterItem userFilterItem;
  const UserListFilterSettingUserFilterItemDeleted({
    required this.userFilterItem,
  });

  @override
  List<Object> get props => [userFilterItem];
}

class UserListFilterSettingUserFilterItemBooleanConditionChanged
    extends UserListFilterSettingEvent {
  final UserFilterItem userFilterItem;
  final String booleanCondition;
  const UserListFilterSettingUserFilterItemBooleanConditionChanged({
    required this.userFilterItem,
    required this.booleanCondition,
  });

  @override
  List<Object> get props => [
        userFilterItem,
        booleanCondition,
      ];
}

class UserListFilterSettingUserFilterItemOperatorChanged
    extends UserListFilterSettingEvent {
  final UserFilterItem userFilterItem;
  final String operator;
  const UserListFilterSettingUserFilterItemOperatorChanged({
    required this.userFilterItem,
    required this.operator,
  });

  @override
  List<Object> get props => [
        userFilterItem,
        operator,
      ];
}

class UserListFilterSettingUserFilterItemValueChanged
    extends UserListFilterSettingEvent {
  final UserFilterItem userFilterItem;
  final String value;
  const UserListFilterSettingUserFilterItemValueChanged({
    required this.userFilterItem,
    required this.value,
  });

  @override
  List<Object> get props => [
        userFilterItem,
        value,
      ];
}

class UserListFilterSettingUserFilterItemColumnChanged
    extends UserListFilterSettingEvent {
  final UserFilterItem userFilterItem;
  final FilterSetting column;
  const UserListFilterSettingUserFilterItemColumnChanged({
    required this.userFilterItem,
    required this.column,
  });

  @override
  List<Object> get props => [
        userFilterItem,
        column,
      ];
}
