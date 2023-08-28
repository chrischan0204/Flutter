// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_setting_bloc.dart';

abstract class FilterSettingEvent extends Equatable {
  const FilterSettingEvent();

  @override
  List<Object?> get props => [];
}

/// event to init filter setting
class FilterSettingInit extends FilterSettingEvent {
  final String viewName;
  const FilterSettingInit({
    required this.viewName,
  });
  @override
  List<Object?> get props => [viewName];
}

/// event to load filter setting list
class FilterSettingFilterSettingListLoaded extends FilterSettingEvent {
  final String name;
  const FilterSettingFilterSettingListLoaded({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

/// event to load user filter setting list
class FilterSettingUserFilterSettingListLoaded extends FilterSettingEvent {
  final String name;
  final bool deleted;
  const FilterSettingUserFilterSettingListLoaded({
    required this.name,
    this.deleted = false,
  });

  @override
  List<Object> get props => [name];
}

/// event to load user filter setting detail by id
class FilterSettingUserFilterSettingLoadedById extends FilterSettingEvent {
  final String filterId;
  const FilterSettingUserFilterSettingLoadedById({
    required this.filterId,
  });

  @override
  List<Object> get props => [filterId];
}

/// event to delete user filter setting by id
class FilterSettingUserFilterSettingDeletedById extends FilterSettingEvent {
  final String filterId;
  const FilterSettingUserFilterSettingDeletedById({
    required this.filterId,
  });

  @override
  List<Object> get props => [filterId];
}

/// event to change user filter name to create or update filter setting
class FilterSettingUserFilterNameChanged extends FilterSettingEvent {
  final String filterName;
  const FilterSettingUserFilterNameChanged({
    required this.filterName,
  });

  @override
  List<Object> get props => [filterName];
}

/// event to change is default to create or update user filter setting
class FilterSettingUserFilterIsDefaultChanged extends FilterSettingEvent {
  final bool isDefault;
  const FilterSettingUserFilterIsDefaultChanged({
    required this.isDefault,
  });

  @override
  List<Object> get props => [isDefault];
}

/// event to save user filter setting
class FilterSettingUserFilterSettingSaved extends FilterSettingEvent {
  const FilterSettingUserFilterSettingSaved();
}

/// event to save as user filter setting
class FilterSettingUserFilterSettingSavedAs extends FilterSettingEvent {
  final String saveAsName;
  const FilterSettingUserFilterSettingSavedAs({
    required this.saveAsName,
  });

  @override
  List<Object> get props => [saveAsName];
}

/// event to select user filter setting to update or delete
class FilterSettingUserFilterSettingSelected extends FilterSettingEvent {
  final UserFilterSetting? userFilterSetting;

  const FilterSettingUserFilterSettingSelected({
    this.userFilterSetting,
  });

  @override
  List<Object?> get props => [userFilterSetting];
}

/// event to add new user filter item
class FilterSettingUserFilterItemAdded extends FilterSettingEvent {
  final UserFilterItem? userFilterItem;
  const FilterSettingUserFilterItemAdded({
    this.userFilterItem,
  });

  @override
  List<Object?> get props => [userFilterItem];
}

/// event to add new user filter
class FilterSettingUserFilterAdded extends FilterSettingEvent {
  final String viewName;
  const FilterSettingUserFilterAdded({
    required this.viewName,
  });

  @override
  List<Object?> get props => [viewName];
}

/// event to delete user filter item
class FilterSettingUserFilterItemDeleted extends FilterSettingEvent {
  final UserFilterItem userFilterItem;
  const FilterSettingUserFilterItemDeleted({
    required this.userFilterItem,
  });

  @override
  List<Object> get props => [userFilterItem];
}

/// event to change boolean condition to create user filter item
class FilterSettingUserFilterItemBooleanConditionChanged
    extends FilterSettingEvent {
  final UserFilterItem userFilterItem;
  final String booleanCondition;
  const FilterSettingUserFilterItemBooleanConditionChanged({
    required this.userFilterItem,
    required this.booleanCondition,
  });

  @override
  List<Object> get props => [
        userFilterItem,
        booleanCondition,
      ];
}

/// event to change operator to create user filter item
class FilterSettingUserFilterItemOperatorChanged extends FilterSettingEvent {
  final UserFilterItem userFilterItem;
  final String operator;
  const FilterSettingUserFilterItemOperatorChanged({
    required this.userFilterItem,
    required this.operator,
  });

  @override
  List<Object> get props => [
        userFilterItem,
        operator,
      ];
}

/// event to change value to create user filter item
class FilterSettingUserFilterItemValueChanged extends FilterSettingEvent {
  final UserFilterItem userFilterItem;
  final List<String> value;
  const FilterSettingUserFilterItemValueChanged({
    required this.userFilterItem,
    required this.value,
  });

  @override
  List<Object> get props => [
        userFilterItem,
        value,
      ];
}

/// event to change filter item column
class FilterSettingUserFilterItemColumnChanged extends FilterSettingEvent {
  final UserFilterItem userFilterItem;
  final FilterSetting column;
  const FilterSettingUserFilterItemColumnChanged({
    required this.userFilterItem,
    required this.column,
  });

  @override
  List<Object> get props => [
        userFilterItem,
        column,
      ];
}

/// event to change include deleted 
class FilterSettingIncludeDeletedChanged extends FilterSettingEvent {
  final bool includeDeleted;
  const FilterSettingIncludeDeletedChanged({
    required this.includeDeleted,
  });

  @override
  List<Object> get props => [includeDeleted];
}

/// event to change user filter setting
class FilterSettingAppliedUserFilterSettingChanged extends FilterSettingEvent {
  final UserFilterSetting? appliedUserFilterSetting;
  const FilterSettingAppliedUserFilterSettingChanged({
    this.appliedUserFilterSetting,
  });

  @override
  List<Object?> get props => [appliedUserFilterSetting];
}

/// event to add new user filter setting
class FilterSettingUserFilterSettingNewAdded extends FilterSettingEvent {
  final String viewName;
  const FilterSettingUserFilterSettingNewAdded({
    required this.viewName,
  });
  @override
  List<Object?> get props => [viewName];
}
