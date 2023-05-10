import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

part 'user_list_view_setting_event.dart';
part 'user_list_view_setting_state.dart';

class UserListViewSettingBloc
    extends Bloc<UserListViewSettingEvent, UserListViewSettingState> {
  final SettingsRepository settingsRepository;

  UserListViewSettingBloc({required this.settingsRepository})
      : super(const UserListViewSettingState()) {
    on<UserListViewSettingLoaded>(_onUserListViewSettingLoaded);
    on<UserListViewSettingDisplayOrderChanged>(
        _onUserListViewSettingDisplayOrderChanged);
    on<UserListViewSettingDisplaySelected>(
        _onUserListViewSettingDisplaySelected);
    on<UserListViewSettingDisplayAdded>(_onUserListViewSettingDisplayAdded);
    on<UserListViewSettingDisplayDeleted>(_onUserListViewSettingDisplayDeleted);

    on<UserListViewSettingSortingOrderChanged>(
        _onUserListViewSettingSortingOrderChanged);
    on<UserListViewSettingSortingSelected>(
        _onUserListViewSettingSortingSelected);
    on<UserListViewSettingSortingAdded>(_onUserListViewSettingSortingAdded);
    on<UserListViewSettingSortingDeleted>(_onUserListViewSettingSortingDeleted);
  }

  Future<void> _onUserListViewSettingLoaded(
    UserListViewSettingLoaded event,
    Emitter<UserListViewSettingState> emit,
  ) async {
    emit(state.copyWith(viewSettingLoadStatus: EntityStatus.loading));
    try {
      ViewSetting viewSetting = await settingsRepository.getViewSetting('user');
      emit(state.copyWith(
        columns: viewSetting.columnList,
        viewSettingDisplayList: viewSetting.displayColumnList
            .map((e) => ViewSettingItemData(
                  key: ValueKey(e.order - 1),
                  selectedValue: e.title,
                ))
            .toList(),
        viewSettingSortingList: viewSetting.sortingColumnList
            .map((e) => ViewSettingItemData(
                  key: ValueKey(e.order - 1),
                  selectedValue: e.title,
                  asc: e.sortDirection == 'asc',
                ))
            .toList(),
        viewSettingLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(viewSettingLoadStatus: EntityStatus.failure));
    }
  }

  void _onUserListViewSettingSortingOrderChanged(
    UserListViewSettingSortingOrderChanged event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingList =
        List.from(state.viewSettingSortingList);
    final draggedItem = viewSettingSortingList[event.draggingIndex];
    viewSettingSortingList.removeAt(event.draggingIndex);
    viewSettingSortingList.insert(event.newPositionIndex, draggedItem);
    emit(state.copyWith(viewSettingSortingList: viewSettingSortingList));
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
    emit(state.copyWith(
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
    emit(state.copyWith(viewSettingDisplayList: viewSettingDisplayList));
  }

  void _onUserListViewSettingSortingSelected(
    UserListViewSettingSortingSelected event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingList =
        List.from(state.viewSettingSortingList);
    viewSettingSortingList.removeAt(event.columnIndex);
    viewSettingSortingList.insert(
        event.columnIndex,
        ViewSettingItemData(
          key: ValueKey(event.columnIndex),
          selectedValue: event.selectedValue,
        ));
    emit(state.copyWith(viewSettingSortingList: viewSettingSortingList));
  }

  void _onUserListViewSettingDisplayAdded(
    UserListViewSettingDisplayAdded event,
    Emitter<UserListViewSettingState> emit,
  ) {
    emit(state.copyWith(viewSettingDisplayList: [
      ...state.viewSettingDisplayList,
      ViewSettingItemData(key: ValueKey(state.viewSettingDisplayList.length))
    ]));
  }

  void _onUserListViewSettingSortingAdded(
    UserListViewSettingSortingAdded event,
    Emitter<UserListViewSettingState> emit,
  ) {
    emit(state.copyWith(viewSettingSortingList: [
      ...state.viewSettingSortingList,
      ViewSettingItemData(key: ValueKey(state.viewSettingSortingList.length))
    ]));
  }

  void _onUserListViewSettingDisplayDeleted(
    UserListViewSettingDisplayDeleted event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayList =
        List.from(state.viewSettingDisplayList);
    viewSettingDisplayList.removeAt(event.columnIndex);

    emit(state.copyWith(viewSettingDisplayList: viewSettingDisplayList));
  }

  void _onUserListViewSettingSortingDeleted(
    UserListViewSettingSortingDeleted event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingList =
        List.from(state.viewSettingSortingList);
    viewSettingSortingList.removeAt(event.columnIndex);

    emit(state.copyWith(viewSettingSortingList: viewSettingSortingList));
  }
}
