// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_list_view_setting_bloc.dart';

class ViewSettingItemData {
  ViewSettingItemData({
    this.selectedValue,
    required this.key,
    this.asc,
  });

  final String? selectedValue;
  final bool? asc;

  final Key key;
}

class UserListViewSettingState extends Equatable {
  final EntityStatus viewSettingLoadStatus;
  final List<ViewSettingItemData> viewSettingDisplayList;
  final List<ViewSettingItemData> viewSettingSortingList;
  final List<ViewSettingColumn> columns;
  const UserListViewSettingState({
    this.viewSettingLoadStatus = EntityStatus.initial,
    this.viewSettingDisplayList = const [],
    this.viewSettingSortingList = const [],
    this.columns = const [],
  });

  List<String> get unusedColumns {
    var usedColumnsSet = Set<String>.from(usedColumns);
    var totalColumnsSet = Set<String>.from(columns);
    return List.from(totalColumnsSet.difference(usedColumnsSet));
  }

  List<String> get usedColumns => viewSettingDisplayList
      .where((viewSettingItemData) => viewSettingItemData.selectedValue != null)
      .map((viewSettingItemData) => viewSettingItemData.selectedValue!)
      .toList();

  @override
  List<Object> get props => [
        viewSettingLoadStatus,
        viewSettingDisplayList,
        viewSettingSortingList,
        columns,
      ];

  UserListViewSettingState copyWith({
    EntityStatus? viewSettingLoadStatus,
    List<ViewSettingItemData>? viewSettingDisplayList,
    List<ViewSettingItemData>? viewSettingSortingList,
    List<ViewSettingColumn>? columns,
  }) {
    return UserListViewSettingState(
      viewSettingLoadStatus:
          viewSettingLoadStatus ?? this.viewSettingLoadStatus,
      viewSettingDisplayList:
          viewSettingDisplayList ?? this.viewSettingDisplayList,
      viewSettingSortingList:
          viewSettingSortingList ?? this.viewSettingSortingList,
      columns: columns ?? this.columns,
    );
  }
}
