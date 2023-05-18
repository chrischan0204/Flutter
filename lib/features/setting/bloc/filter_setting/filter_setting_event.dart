part of 'filter_setting_bloc.dart';

abstract class FilterSettingEvent extends Equatable {
  const FilterSettingEvent();

  @override
  List<Object?> get props => [];
}

class FilterSettingInit extends FilterSettingEvent {
  final String viewName;
  const FilterSettingInit({
    required this.viewName,
  });
  @override
  List<Object?> get props => [viewName];
}

class FilterSettingFilterSettingListLoaded extends FilterSettingEvent {
  final String name;
  const FilterSettingFilterSettingListLoaded({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

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

class FilterSettingUserFilterSettingLoadedById extends FilterSettingEvent {
  final String filterId;
  const FilterSettingUserFilterSettingLoadedById({
    required this.filterId,
  });

  @override
  List<Object> get props => [filterId];
}

class FilterSettingUserFilterSettingDeletedById extends FilterSettingEvent {
  final String filterId;
  const FilterSettingUserFilterSettingDeletedById({
    required this.filterId,
  });

  @override
  List<Object> get props => [filterId];
}

class FilterSettingUserFilterNameChanged extends FilterSettingEvent {
  final String filterName;
  const FilterSettingUserFilterNameChanged({
    required this.filterName,
  });

  @override
  List<Object> get props => [filterName];
}

class FilterSettingUserFilterIsDefaultChanged extends FilterSettingEvent {
  final bool isDefault;
  const FilterSettingUserFilterIsDefaultChanged({
    required this.isDefault,
  });

  @override
  List<Object> get props => [isDefault];
}

class FilterSettingUserFilterSettingUpdated extends FilterSettingEvent {}

class FilterSettingUserFilterSettingSavedAs extends FilterSettingEvent {
  final String saveAsName;
  const FilterSettingUserFilterSettingSavedAs({
    required this.saveAsName,
  });

  @override
  List<Object> get props => [saveAsName];
}

class FilterSettingUserFilterSettingSelected extends FilterSettingEvent {
  final UserFilterSetting? userFilterSetting;

  const FilterSettingUserFilterSettingSelected({
    this.userFilterSetting,
  });

  @override
  List<Object?> get props => [userFilterSetting];
}

class FilterSettingUserFilterItemAdded extends FilterSettingEvent {
  final UserFilterItem? userFilterItem;
  const FilterSettingUserFilterItemAdded({
    this.userFilterItem,
  });

  @override
  List<Object?> get props => [userFilterItem];
}

class FilterSettingUserFilterAdded extends FilterSettingEvent {
  final String viewName;
  const FilterSettingUserFilterAdded({
    required this.viewName,
  });

  @override
  List<Object?> get props => [viewName];
}

class FilterSettingUserFilterItemDeleted extends FilterSettingEvent {
  final UserFilterItem userFilterItem;
  const FilterSettingUserFilterItemDeleted({
    required this.userFilterItem,
  });

  @override
  List<Object> get props => [userFilterItem];
}

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

class FilterSettingIncludeDeletedChanged extends FilterSettingEvent {
  final bool includeDeleted;
  const FilterSettingIncludeDeletedChanged({
    required this.includeDeleted,
  });

  @override
  List<Object> get props => [includeDeleted];
}
