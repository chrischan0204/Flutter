part of 'view_setting_bloc.dart';

class ViewSettingState extends Equatable {
  final EntityStatus viewSettingLoadStatus;
  final EntityStatus viewSettingSaveStatus;
  final List<ViewSettingItemData> viewSettingDisplayColumnList;
  final List<ViewSettingItemData> viewSettingSortingColumnList;
  final List<ViewSettingColumn> columns;
  final List<ViewSettingColumn> usefulDisplayColumns;
  final List<ViewSettingColumn> usefulSortingColumns;
  const ViewSettingState({
    this.viewSettingLoadStatus = EntityStatus.initial,
    this.viewSettingSaveStatus = EntityStatus.initial,
    this.viewSettingDisplayColumnList = const [],
    this.viewSettingSortingColumnList = const [],
    this.columns = const [],
    this.usefulDisplayColumns = const [],
    this.usefulSortingColumns = const [],
  });

  @override
  List<Object> get props => [
        viewSettingLoadStatus,
        viewSettingSaveStatus,
        viewSettingDisplayColumnList,
        viewSettingSortingColumnList,
        columns,
        usefulDisplayColumns,
        usefulSortingColumns,
      ];

  List<ViewSettingItemData> get undeletedViewSettingDisplayColumnList =>
      viewSettingDisplayColumnList
          .where((element) => !element.deleted)
          .toList();

  List<ViewSettingItemData> get undeletedViewSettingSortingColumnList =>
      viewSettingSortingColumnList
          .where((element) => !element.deleted)
          .toList();

  bool get displayColumnAllFill => undeletedViewSettingDisplayColumnList
      .every((element) => element.selectedValue != null);

  bool get sortingColumnAllFill => undeletedViewSettingSortingColumnList
      .every((element) => element.selectedValue != null);

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
    List<ViewSettingColumn>? usefulDisplayColumns,
    List<ViewSettingColumn>? usefulSortingColumns,
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
      usefulDisplayColumns: usefulDisplayColumns ?? this.usefulDisplayColumns,
      usefulSortingColumns: usefulSortingColumns ?? this.usefulSortingColumns,
    );
  }
}
