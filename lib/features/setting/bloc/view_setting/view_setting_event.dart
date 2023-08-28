part of 'view_setting_bloc.dart';

abstract class ViewSettingEvent extends Equatable {
  const ViewSettingEvent();

  @override
  List<Object> get props => [];
}

/// event to apply view setting
class ViewSettingApplied extends ViewSettingEvent {
  final String viewName;
  const ViewSettingApplied({
    required this.viewName,
  });

  @override
  List<Object> get props => [viewName];
}

/// event to load view setting
class ViewSettingLoaded extends ViewSettingEvent {
  final String viewName;
  const ViewSettingLoaded({
    required this.viewName,
  });

  @override
  List<Object> get props => [viewName];
}

/// event to change display column order
class ViewSettingDisplayColumnOrderChanged extends ViewSettingEvent {
  final int draggingIndex;
  final int newPositionIndex;
  const ViewSettingDisplayColumnOrderChanged({
    required this.draggingIndex,
    required this.newPositionIndex,
  });

  @override
  List<Object> get props => [
        draggingIndex,
        newPositionIndex,
      ];
}

/// event to add display column
class ViewSettingDisplayColumnAdded extends ViewSettingEvent {}

/// event to select column to display
class ViewSettingDisplayColumnSelected extends ViewSettingEvent {
  final ViewSettingItemData column;
  final ViewSettingColumn selectedValue;
  const ViewSettingDisplayColumnSelected({
    required this.column,
    required this.selectedValue,
  });

  @override
  List<Object> get props => [
        column,
        selectedValue,
      ];
}

/// event to delete display column
class ViewSettingDisplayColumnDeleted extends ViewSettingEvent {
  final ViewSettingItemData column;
  const ViewSettingDisplayColumnDeleted({
    required this.column,
  });

  @override
  List<Object> get props => [column];
}

/// event to change column order for sorting
class ViewSettingSortingColumnOrderChanged extends ViewSettingEvent {
  final int draggingIndex;
  final int newPositionIndex;
  const ViewSettingSortingColumnOrderChanged({
    required this.draggingIndex,
    required this.newPositionIndex,
  });

  @override
  List<Object> get props => [
        draggingIndex,
        newPositionIndex,
      ];
}

/// event to add new column for sorting
class ViewSettingSortingColumnAdded extends ViewSettingEvent {}

/// event to select column for sorting
class ViewSettingSortingColumnSelected extends ViewSettingEvent {
  final ViewSettingItemData column;
  final ViewSettingColumn selectedValue;
  const ViewSettingSortingColumnSelected({
    required this.column,
    required this.selectedValue,
  });

  @override
  List<Object> get props => [
        column,
        selectedValue,
      ];
}

/// event to change sort direction of column for sorting
class ViewSettingSortingColumnSortDirectionChanged extends ViewSettingEvent {
  final ViewSettingItemData column;
  final String sortDirection;
  const ViewSettingSortingColumnSortDirectionChanged({
    required this.column,
    required this.sortDirection,
  });

  @override
  List<Object> get props => [
        column,
        sortDirection,
      ];
}

/// event to delete column for sorting
class ViewSettingSortingColumnDeleted extends ViewSettingEvent {
  final ViewSettingItemData column;
  const ViewSettingSortingColumnDeleted({
    required this.column,
  });

  @override
  List<Object> get props => [column];
}
