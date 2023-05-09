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
  final List<ViewSettingItemData> viewSettingDisplayList;
  final List<ViewSettingItemData> viewSettingSortingList;
  final List<String> columns;
  const UserListViewSettingState({
    this.viewSettingDisplayList = const [],
    this.viewSettingSortingList = const [],
    this.columns = const [
      'First Name',
      'Last Name',
      'Role',
      'Email',
      'Default Site',
      'Mobile Number',
    ],
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
        viewSettingDisplayList,
        viewSettingSortingList,
        columns,
      ];
}
