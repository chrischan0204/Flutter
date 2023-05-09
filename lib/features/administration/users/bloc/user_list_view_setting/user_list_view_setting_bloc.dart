import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'user_list_view_setting_event.dart';
part 'user_list_view_setting_state.dart';

class UserListViewSettingBloc
    extends Bloc<UserListViewSettingEvent, UserListViewSettingState> {
  UserListViewSettingBloc() : super(const UserListViewSettingState()) {
    on<UserListViewSettingLoaded>(_onUserListViewSettingLoaded);
    on<UserListViewSettingDisplayOrderChanged>(
        _onUserListViewSettingDisplayOrderChanged);
    on<UserListViewSettingDisplaySelected>(
        _onUserListViewSettingDisplaySelected);
    on<UserListViewSettingDisplayAdded>(_onUserListViewSettingDisplayAdded);
    on<UserListViewSettingDisplayDeleted>(_onUserListViewSettingDisplayDeleted);
  }

  Future<void> _onUserListViewSettingLoaded(
    UserListViewSettingLoaded event,
    Emitter<UserListViewSettingState> emit,
  ) async {
    
  }

  void _onUserListViewSettingDisplayOrderChanged(
    UserListViewSettingDisplayOrderChanged event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayList =
        List.from(state.viewSettingDisplayList);
    final draggedItem = viewSettingDisplayList[event.draggingIndex];
    viewSettingDisplayList.removeAt(event.draggingIndex);
    viewSettingDisplayList.insert(event.newPositionIndex, draggedItem);
    emit(UserListViewSettingState(
        viewSettingDisplayList: viewSettingDisplayList));
  }

  void _onUserListViewSettingDisplaySelected(
    UserListViewSettingDisplaySelected event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayList =
        List.from(state.viewSettingDisplayList);
    viewSettingDisplayList.removeAt(event.columnIndex);
    viewSettingDisplayList.insert(
        event.columnIndex,
        ViewSettingItemData(
          key: ValueKey(event.columnIndex),
          selectedValue: event.selectedValue,
        ));
    emit(UserListViewSettingState(
        viewSettingDisplayList: viewSettingDisplayList));
  }

  void _onUserListViewSettingDisplayAdded(
    UserListViewSettingDisplayAdded event,
    Emitter<UserListViewSettingState> emit,
  ) {
    emit(UserListViewSettingState(viewSettingDisplayList: [
      ...state.viewSettingDisplayList,
      ViewSettingItemData(key: ValueKey(state.viewSettingDisplayList.length))
    ]));
  }

  void _onUserListViewSettingDisplayDeleted(
    UserListViewSettingDisplayDeleted event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayList =
        List.from(state.viewSettingDisplayList);
    viewSettingDisplayList.removeAt(event.columnIndex);

    emit(UserListViewSettingState(
        viewSettingDisplayList: viewSettingDisplayList));
  }
}
