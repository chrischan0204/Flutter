part of 'view_setting_bloc.dart';

abstract class ViewSettingEvent extends Equatable {
  const ViewSettingEvent();

  @override
  List<Object> get props => [];
}

class ViewSettingApplied extends ViewSettingEvent {
  final String viewName;
  const ViewSettingApplied({
    required this.viewName,
  });

  @override
  List<Object> get props => [viewName];
}

class ViewSettingLoaded extends ViewSettingEvent {
  final String viewName;
  const ViewSettingLoaded({
    required this.viewName,
  });

  @override
  List<Object> get props => [viewName];
}

class ViewSettingDisplayColumnOrderChanged
    extends ViewSettingEvent {
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

class ViewSettingDisplayColumnAdded extends ViewSettingEvent {}

class ViewSettingDisplayColumnSelected
    extends ViewSettingEvent {
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

class ViewSettingDisplayColumnDeleted extends ViewSettingEvent {
  final ViewSettingItemData column;
  const ViewSettingDisplayColumnDeleted({
    required this.column,
  });

  @override
  List<Object> get props => [column];
}

class ViewSettingSortingColumnOrderChanged
    extends ViewSettingEvent {
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

class ViewSettingSortingColumnAdded extends ViewSettingEvent {}

class ViewSettingSortingColumnSelected
    extends ViewSettingEvent {
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

class ViewSettingSortingColumnSortDirectionChanged
    extends ViewSettingEvent {
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

class ViewSettingSortingColumnDeleted extends ViewSettingEvent {
  final ViewSettingItemData column;
  const ViewSettingSortingColumnDeleted({
    required this.column,
  });

  @override
  List<Object> get props => [column];
}
