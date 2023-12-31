part of 'filter_setting_bloc.dart';

class FilterSettingState extends Equatable {
  final EntityStatus filterSettingListLoadStatus;
  final List<FilterSetting> filterSettingList;

  final UserFilter? userFilterUpdate;
  final EntityStatus userFilterSettingLoadStatus;

  final List<UserFilterSetting> userFilterSettingList;
  final EntityStatus userFilterSettingListLoadStatus;

  final EntityStatus userFilterSettingUpdateStatus;
  final EntityStatus userFilterSettingDeleteStatus;
  final UserFilterSetting? selectedUserFilterSetting;

  final String addButtonName;
  final String saveAsButtonName;
  final bool includeDeleted;

  final UserFilterSetting? appliedUserFilterSetting;

  final String viewName;

  const FilterSettingState({
    this.filterSettingListLoadStatus = EntityStatus.initial,
    this.filterSettingList = const [],
    this.userFilterUpdate,
    this.selectedUserFilterSetting,
    this.userFilterSettingLoadStatus = EntityStatus.initial,
    this.userFilterSettingList = const [],
    this.userFilterSettingListLoadStatus = EntityStatus.initial,
    this.userFilterSettingUpdateStatus = EntityStatus.initial,
    this.userFilterSettingDeleteStatus = EntityStatus.initial,
    this.addButtonName = 'Save',
    this.saveAsButtonName = 'Save as',
    this.includeDeleted = false,
    this.viewName = '',
    this.appliedUserFilterSetting,
  });

  @override
  List<Object?> get props => [
        filterSettingListLoadStatus,
        filterSettingList,
        userFilterUpdate,
        selectedUserFilterSetting,
        userFilterSettingLoadStatus,
        userFilterSettingList,
        userFilterSettingListLoadStatus,
        userFilterSettingUpdateStatus,
        userFilterSettingDeleteStatus,
        addButtonName,
        saveAsButtonName,
        includeDeleted,
        isNew,
        defaultFilterSetting,
        viewName,
        appliedUserFilterSetting,
        isFilterUpdateNotFill,
      ];

  bool get isNew => saveAsButtonName != 'Save as';

  FilterSetting getFilterSettingById(String id) =>
      List.from(filterSettingList).firstWhere((element) => element.id == id);

  UserFilterSetting get defaultFilterSetting =>
      userFilterSettingList.firstWhere(
        (element) => element.isDefault,
        orElse: () {
          return userFilterSettingList.isEmpty
              ? const UserFilterSetting()
              : userFilterSettingList[0];
        },
      );

  bool get filterSettingLoading =>
      userFilterSettingListLoadStatus.isLoading ||
      filterSettingListLoadStatus.isLoading;

  bool get isFilterUpdateNotFill => (userFilterUpdate?.userFilterItems ?? [])
      .where((userFilterItem) =>
          userFilterItem.filterValue.isEmpty ||
          userFilterItem.filterValue
              .where((value) =>
                  Validation.isEmpty(value) ||
                  Validation.isEmpty(value.replaceAll(',', '')))
              .isNotEmpty)
      .isNotEmpty;

  FilterSettingState copyWith({
    EntityStatus? filterSettingListLoadStatus,
    List<FilterSetting>? filterSettingList,
    Nullable<UserFilter?>? userFilterUpdate,
    UserFilterSetting? selectedUserFilterSetting,
    EntityStatus? userFilterSettingLoadStatus,
    List<UserFilterSetting>? userFilterSettingList,
    EntityStatus? userFilterSettingListLoadStatus,
    EntityStatus? userFilterSettingUpdateStatus,
    EntityStatus? userFilterSettingDeleteStatus,
    String? addButtonName,
    String? saveAsButtonName,
    bool? includeDeleted,
    String? viewName,
    Nullable<UserFilterSetting?>? appliedUserFilterSetting,
  }) {
    return FilterSettingState(
      filterSettingListLoadStatus:
          filterSettingListLoadStatus ?? this.filterSettingListLoadStatus,
      filterSettingList: filterSettingList ?? this.filterSettingList,
      userFilterUpdate: userFilterUpdate != null
          ? userFilterUpdate.value
          : this.userFilterUpdate,
      selectedUserFilterSetting:
          selectedUserFilterSetting ?? this.selectedUserFilterSetting,
      userFilterSettingLoadStatus:
          userFilterSettingLoadStatus ?? this.userFilterSettingLoadStatus,
      userFilterSettingList:
          userFilterSettingList ?? this.userFilterSettingList,
      userFilterSettingListLoadStatus: userFilterSettingListLoadStatus ??
          this.userFilterSettingListLoadStatus,
      userFilterSettingUpdateStatus:
          userFilterSettingUpdateStatus ?? this.userFilterSettingUpdateStatus,
      userFilterSettingDeleteStatus:
          userFilterSettingDeleteStatus ?? this.userFilterSettingDeleteStatus,
      addButtonName: addButtonName ?? this.addButtonName,
      saveAsButtonName: saveAsButtonName ?? this.saveAsButtonName,
      includeDeleted: includeDeleted ?? this.includeDeleted,
      viewName: viewName ?? this.viewName,
      appliedUserFilterSetting: appliedUserFilterSetting != null
          ? appliedUserFilterSetting.value
          : this.appliedUserFilterSetting,
    );
  }
}
