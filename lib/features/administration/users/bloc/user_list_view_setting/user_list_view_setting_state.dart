part of 'user_list_view_setting_bloc.dart';

class UserListViewSettingState extends Equatable {
  final EntityStatus viewSettingLoadStatus;
  final List<ViewSettingItemData> viewSettingDisplayColumnList;
  final List<ViewSettingItemData> viewSettingSortingColumnList;
  final List<ViewSettingColumn> columns;
  const UserListViewSettingState({
    this.viewSettingLoadStatus = EntityStatus.initial,
    this.viewSettingDisplayColumnList = const [],
    this.viewSettingSortingColumnList = const [],
    this.columns = const [],
  });

  @override
  List<Object> get props => [
        viewSettingLoadStatus,
        viewSettingDisplayColumnList,
        viewSettingSortingColumnList,
        columns,
      ];

  UserListViewSettingState copyWith({
    EntityStatus? viewSettingLoadStatus,
    List<ViewSettingItemData>? viewSettingDisplayColumnList,
    List<ViewSettingItemData>? viewSettingSortingColumnList,
    List<ViewSettingColumn>? columns,
  }) {
    return UserListViewSettingState(
      viewSettingLoadStatus:
          viewSettingLoadStatus ?? this.viewSettingLoadStatus,
      viewSettingDisplayColumnList:
          viewSettingDisplayColumnList ?? this.viewSettingDisplayColumnList,
      viewSettingSortingColumnList:
          viewSettingSortingColumnList ?? this.viewSettingSortingColumnList,
      columns: columns ?? this.columns,
    );
  }
}
