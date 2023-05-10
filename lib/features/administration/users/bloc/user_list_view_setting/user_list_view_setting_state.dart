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

  List<ViewSettingItemData> get undeletedViewSettingDisplayColumnList =>
      viewSettingDisplayColumnList.where((element) => !element.deleted).toList();

  List<ViewSettingItemData> get undeletedViewSettingSortingColumnList =>
      viewSettingSortingColumnList.where((element) => !element.deleted).toList();

  int indexOfViewSettingDisplayColumnList(Key key) {
    return viewSettingDisplayColumnList.indexWhere((d) => d.key == key);
  }

  int indexOfViewSettingSortingColumnList(Key key) {
    return viewSettingSortingColumnList.indexWhere((d) => d.key == key);
  }

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
