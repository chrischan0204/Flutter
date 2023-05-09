part of 'user_list_view_setting_bloc.dart';

abstract class UserListViewSettingEvent extends Equatable {
  const UserListViewSettingEvent();

  @override
  List<Object> get props => [];
}

class UserListViewSettingLoaded extends UserListViewSettingEvent {}

class UserListViewSettingDisplayOrderChanged extends UserListViewSettingEvent {
  final int draggingIndex;
  final int newPositionIndex;
  const UserListViewSettingDisplayOrderChanged({
    required this.draggingIndex,
    required this.newPositionIndex,
  });

  @override
  List<Object> get props => [
        draggingIndex,
        newPositionIndex,
      ];
}

class UserListViewSettingDisplayAdded extends UserListViewSettingEvent {}

class UserListViewSettingDisplaySelected extends UserListViewSettingEvent {
  final int columnIndex;
  final String selectedValue;
  const UserListViewSettingDisplaySelected({
    required this.columnIndex,
    required this.selectedValue,
  });

  @override
  List<Object> get props => [
        columnIndex,
        selectedValue,
      ];
}

class UserListViewSettingDisplayDeleted extends UserListViewSettingEvent {
  final int columnIndex;
  const UserListViewSettingDisplayDeleted({
    required this.columnIndex,
  });

  @override
  List<Object> get props => [columnIndex];
}

class UserListViewSettingSortingOrderChanged extends UserListViewSettingEvent {
  final int draggingIndex;
  final int newPositionIndex;
  const UserListViewSettingSortingOrderChanged({
    required this.draggingIndex,
    required this.newPositionIndex,
  });

  @override
  List<Object> get props => [
        draggingIndex,
        newPositionIndex,
      ];
}

class UserListViewSettingSortingAdded extends UserListViewSettingEvent {}

class UserListViewSettingSortingSelected extends UserListViewSettingEvent {
  final int columnIndex;
  final String selectedValue;
  const UserListViewSettingSortingSelected({
    required this.columnIndex,
    required this.selectedValue,
  });

  @override
  List<Object> get props => [
        columnIndex,
        selectedValue,
      ];
}

class UserListViewSettingSortingDeleted extends UserListViewSettingEvent {
  final int columnIndex;
  const UserListViewSettingSortingDeleted({
    required this.columnIndex,
  });

  @override
  List<Object> get props => [columnIndex];
}
