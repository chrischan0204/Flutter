part of 'user_list_view_setting_bloc.dart';

abstract class UserListViewSettingEvent extends Equatable {
  const UserListViewSettingEvent();

  @override
  List<Object> get props => [];
}

class UserListViewSettingApplied extends UserListViewSettingEvent {
  final String viewName;
  const UserListViewSettingApplied({
    required this.viewName,
  });

  @override
  List<Object> get props => [viewName];
}

class UserListViewSettingLoaded extends UserListViewSettingEvent {
  final String viewName;
  const UserListViewSettingLoaded({
    required this.viewName,
  });

  @override
  List<Object> get props => [viewName];
}

class UserListViewSettingDisplayColumnOrderChanged extends UserListViewSettingEvent {
  final int draggingIndex;
  final int newPositionIndex;
  const UserListViewSettingDisplayColumnOrderChanged({
    required this.draggingIndex,
    required this.newPositionIndex,
  });

  @override
  List<Object> get props => [
        draggingIndex,
        newPositionIndex,
      ];
}

class UserListViewSettingDisplayColumnAdded extends UserListViewSettingEvent {}

class UserListViewSettingDisplayColumnSelected extends UserListViewSettingEvent {
  final int columnIndex;
  final ViewSettingColumn selectedValue;
  const UserListViewSettingDisplayColumnSelected({
    required this.columnIndex,
    required this.selectedValue,
  });

  @override
  List<Object> get props => [
        columnIndex,
        selectedValue,
      ];
}

class UserListViewSettingDisplayColumnDeleted extends UserListViewSettingEvent {
  final int columnIndex;
  const UserListViewSettingDisplayColumnDeleted({
    required this.columnIndex,
  });

  @override
  List<Object> get props => [columnIndex];
}

class UserListViewSettingSortingColumnOrderChanged extends UserListViewSettingEvent {
  final int draggingIndex;
  final int newPositionIndex;
  const UserListViewSettingSortingColumnOrderChanged({
    required this.draggingIndex,
    required this.newPositionIndex,
  });

  @override
  List<Object> get props => [
        draggingIndex,
        newPositionIndex,
      ];
}

class UserListViewSettingSortingColumnAdded extends UserListViewSettingEvent {}

class UserListViewSettingSortingColumnSelected extends UserListViewSettingEvent {
  final int columnIndex;
  final ViewSettingColumn selectedValue;
  const UserListViewSettingSortingColumnSelected({
    required this.columnIndex,
    required this.selectedValue,
  });

  @override
  List<Object> get props => [
        columnIndex,
        selectedValue,
      ];
}

class UserListViewSettingSortingColumnSortDirectionChanged
    extends UserListViewSettingEvent {
  final int columnIndex;
  final String sortDirection;
  const UserListViewSettingSortingColumnSortDirectionChanged({
    required this.columnIndex,
    required this.sortDirection,
  });

  @override
  List<Object> get props => [
        columnIndex,
        sortDirection,
      ];
}

class UserListViewSettingSortingColumnDeleted extends UserListViewSettingEvent {
  final int columnIndex;
  const UserListViewSettingSortingColumnDeleted({
    required this.columnIndex,
  });

  @override
  List<Object> get props => [columnIndex];
}
