part of 'view_setting_bloc.dart';

class ViewSettingState extends Equatable {
  final EntityStatus viewSettingLoadStatus;
  final EntityStatus viewSettingSaveStatus;
  final List<ViewSettingItemData> viewSettingDisplayColumnList;
  final List<ViewSettingItemData> viewSettingSortingColumnList;
  final List<ViewSettingColumn> columns;
  const ViewSettingState({
    this.viewSettingLoadStatus = EntityStatus.initial,
    this.viewSettingSaveStatus = EntityStatus.initial,
    this.viewSettingDisplayColumnList = const [],
    this.viewSettingSortingColumnList = const [],
    this.columns = const [],
  });

  @override
  List<Object> get props => [
        viewSettingLoadStatus,
        viewSettingSaveStatus,
        viewSettingDisplayColumnList,
        viewSettingSortingColumnList,
        columns,
      ];

  List<ViewSettingItemData> get undeletedViewSettingDisplayColumnList =>
      viewSettingDisplayColumnList
          .where((element) => !element.deleted)
          .toList();

  List<ViewSettingItemData> get undeletedViewSettingSortingColumnList =>
      viewSettingSortingColumnList
          .where((element) => !element.deleted)
          .toList();

  int indexOfViewSettingDisplayColumnList(Key key) {
    return viewSettingDisplayColumnList.indexWhere((d) => d.key == key);
  }

  int indexOfViewSettingSortingColumnList(Key key) {
    return viewSettingSortingColumnList.indexWhere((d) => d.key == key);
  }

  ViewSettingState copyWith({
    EntityStatus? viewSettingLoadStatus,
    EntityStatus? viewSettingSaveStatus,
    List<ViewSettingItemData>? viewSettingDisplayColumnList,
    List<ViewSettingItemData>? viewSettingSortingColumnList,
    List<ViewSettingColumn>? columns,
  }) {
    return ViewSettingState(
      viewSettingLoadStatus:
          viewSettingLoadStatus ?? this.viewSettingLoadStatus,
      viewSettingSaveStatus:
          viewSettingSaveStatus ?? this.viewSettingSaveStatus,
      viewSettingDisplayColumnList:
          viewSettingDisplayColumnList ?? this.viewSettingDisplayColumnList,
      viewSettingSortingColumnList:
          viewSettingSortingColumnList ?? this.viewSettingSortingColumnList,
      columns: columns ?? this.columns,
    );
  }
}
