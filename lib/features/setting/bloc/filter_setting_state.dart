part of 'filter_setting_bloc.dart';

class FilterSettingState extends Equatable {
  final EntityStatus filterSettingListLoadStatus;
  final List<FilterSetting> filterSettingList;

  final UserFilter userFilterUpdate;
  final EntityStatus userFilterSettingLoadStatus;

  final List<UserFilterSetting> userFilterSettingList;
  final EntityStatus userFilterSettingListLoadStatus;

  final EntityStatus userFilterSettingUpdateStatus;
  final EntityStatus userFilterSettingDeleteStatus;
  final UserFilterSetting? selectedUserFilterSetting;

  final String addButtonName;

  const FilterSettingState({
    this.filterSettingListLoadStatus = EntityStatus.initial,
    this.filterSettingList = const [],
    this.userFilterUpdate = const UserFilter(viewName: 'user'),
    this.selectedUserFilterSetting,
    this.userFilterSettingLoadStatus = EntityStatus.initial,
    this.userFilterSettingList = const [],
    this.userFilterSettingListLoadStatus = EntityStatus.initial,
    this.userFilterSettingUpdateStatus = EntityStatus.initial,
    this.userFilterSettingDeleteStatus = EntityStatus.initial,
    this.addButtonName = 'Update',
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
      ];

  FilterSetting getFilterSettingById(String id) =>
      filterSettingList.firstWhere((element) => element.id == id);

  FilterSettingState copyWith({
    EntityStatus? filterSettingListLoadStatus,
    List<FilterSetting>? filterSettingList,
    UserFilter? userFilterUpdate,
    UserFilterSetting? selectedUserFilterSetting,
    EntityStatus? userFilterSettingLoadStatus,
    List<UserFilterSetting>? userFilterSettingList,
    EntityStatus? userFilterSettingListLoadStatus,
    EntityStatus? userFilterSettingUpdateStatus,
    EntityStatus? userFilterSettingDeleteStatus,
    String? addButtonName,
  }) {
    return FilterSettingState(
      filterSettingListLoadStatus:
          filterSettingListLoadStatus ?? this.filterSettingListLoadStatus,
      filterSettingList: filterSettingList ?? this.filterSettingList,
      userFilterUpdate: userFilterUpdate ?? this.userFilterUpdate,
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
    );
  }
}
