part of 'user_list_filter_setting_bloc.dart';

class UserListFilterSettingState extends Equatable {
  final EntityStatus filterSettingListLoadStatus;
  final List<FilterSetting> filterSettingList;

  final UserFilter? userFilterUpdate;
  final EntityStatus userFilterSettingLoadStatus;

  final List<UserFilterSetting> userFilterSettingList;
  final EntityStatus userFilterSettingListLoadStatus;

  final EntityStatus userFilterSettingUpdateStatus;
  final EntityStatus userFilterSettingDeleteStatus;
  const UserListFilterSettingState({
    this.filterSettingListLoadStatus = EntityStatus.initial,
    this.filterSettingList = const [],
    this.userFilterUpdate,
    this.userFilterSettingLoadStatus = EntityStatus.initial,
    this.userFilterSettingList = const [],
    this.userFilterSettingListLoadStatus = EntityStatus.initial,
    this.userFilterSettingUpdateStatus = EntityStatus.initial,
    this.userFilterSettingDeleteStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        filterSettingListLoadStatus,
        filterSettingList,
        userFilterUpdate,
        userFilterSettingLoadStatus,
        userFilterSettingList,
        userFilterSettingListLoadStatus,
        userFilterSettingUpdateStatus,
        userFilterSettingDeleteStatus,
      ];

  UserListFilterSettingState copyWith({
    EntityStatus? filterSettingListLoadStatus,
    List<FilterSetting>? filterSettingList,
    UserFilter? userFilterUpdate,
    EntityStatus? userFilterSettingLoadStatus,
    List<UserFilterSetting>? userFilterSettingList,
    EntityStatus? userFilterSettingListLoadStatus,
    EntityStatus? userFilterSettingUpdateStatus,
    EntityStatus? userFilterSettingDeleteStatus,
  }) {
    return UserListFilterSettingState(
      filterSettingListLoadStatus:
          filterSettingListLoadStatus ?? this.filterSettingListLoadStatus,
      filterSettingList: filterSettingList ?? this.filterSettingList,
      userFilterUpdate: userFilterUpdate ?? this.userFilterUpdate,
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
    );
  }
}
