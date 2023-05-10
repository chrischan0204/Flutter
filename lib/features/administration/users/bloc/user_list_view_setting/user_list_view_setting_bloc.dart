import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

part 'user_list_view_setting_event.dart';
part 'user_list_view_setting_state.dart';

class UserListViewSettingBloc
    extends Bloc<UserListViewSettingEvent, UserListViewSettingState> {
  final SettingsRepository settingsRepository;

  UserListViewSettingBloc({required this.settingsRepository})
      : super(const UserListViewSettingState()) {
    on<UserListViewSettingApplied>(_onUserListViewSettingApplied);
    on<UserListViewSettingLoaded>(_onUserListViewSettingLoaded);
    on<UserListViewSettingDisplayColumnOrderChanged>(
        _onUserListViewSettingDisplayColumnOrderChanged);
    on<UserListViewSettingDisplayColumnSelected>(
        _onUserListViewSettingDisplayColumnSelected);
    on<UserListViewSettingDisplayColumnAdded>(
        _onUserListViewSettingDisplayColumnAdded);
    on<UserListViewSettingDisplayColumnDeleted>(
        _onUserListViewSettingDisplayColumnDeleted);

    on<UserListViewSettingSortingColumnOrderChanged>(
        _onUserListViewSettingSortingColumnOrderChanged);
    on<UserListViewSettingSortingColumnSortDirectionChanged>(
        _onUserListViewSettingSortingColumnSortDirectionChanged);
    on<UserListViewSettingSortingColumnSelected>(
        _onUserListViewSettingSortingColumnSelected);
    on<UserListViewSettingSortingColumnAdded>(
        _onUserListViewSettingSortingColumnAdded);
    on<UserListViewSettingSortingColumnDeleted>(
        _onUserListViewSettingSortingColumnDeleted);
  }

  Future<void> _onUserListViewSettingApplied(
    UserListViewSettingApplied event,
    Emitter<UserListViewSettingState> emit,
  ) async {
    if (isNotCompleted(state.viewSettingDisplayColumnList) ||
        isNotCompleted(state.viewSettingSortingColumnList)) {
    } else {
      await settingsRepository.applyViewSetting(ViewSettingUpdate(
        viewName: event.viewName,
        displayColumns: state.viewSettingDisplayColumnList
            .map((e) => e
                .copyWith(
                    order: state.viewSettingDisplayColumnList.indexOf(e) + 1)
                .toViewSettingColumnUpdate()!)
            .toList(),
        sortingColumns: state.viewSettingSortingColumnList
            .map((e) => e
                .copyWith(
                    order: state.viewSettingSortingColumnList.indexOf(e) + 1)
                .toViewSettingColumnUpdate()!)
            .toList(),
      ));
    }
  }

  bool isNotCompleted(List<ViewSettingItemData> columns) {
    return columns.length !=
        columns
            .map((e) => e.toViewSettingColumnUpdate())
            .where((element) => element != null)
            .length;
  }

  Future<void> _onUserListViewSettingLoaded(
    UserListViewSettingLoaded event,
    Emitter<UserListViewSettingState> emit,
  ) async {
    emit(state.copyWith(viewSettingLoadStatus: EntityStatus.loading));
    try {
      ViewSetting viewSetting =
          await settingsRepository.getViewSetting(event.viewName);
      emit(state.copyWith(
        columns: viewSetting.columnList,
        viewSettingDisplayColumnList: viewSetting.displayColumnList
            .map((e) => ViewSettingItemData(
                  id: e.id,
                  order: e.order,
                  key: ValueKey(e.order - 1),
                  selectedValue: e,
                ))
            .toList(),
        viewSettingSortingColumnList: viewSetting.sortingColumnList
            .map((e) => ViewSettingItemData(
                  id: e.id,
                  order: e.order,
                  key: ValueKey(e.order - 1),
                  selectedValue: e,
                  sortDirection: e.sortDirection,
                ))
            .toList(),
        viewSettingLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(viewSettingLoadStatus: EntityStatus.failure));
    }
  }

  void _onUserListViewSettingSortingColumnOrderChanged(
    UserListViewSettingSortingColumnOrderChanged event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingColumnList =
        List.from(state.viewSettingSortingColumnList);
    final draggedItem = viewSettingSortingColumnList[event.draggingIndex];
    viewSettingSortingColumnList.removeAt(event.draggingIndex);
    viewSettingSortingColumnList.insert(event.newPositionIndex, draggedItem);
    emit(state.copyWith(
        viewSettingSortingColumnList: viewSettingSortingColumnList));
  }

  void _onUserListViewSettingDisplayColumnOrderChanged(
    UserListViewSettingDisplayColumnOrderChanged event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayColumnList =
        List.from(state.viewSettingDisplayColumnList);
    final draggedItem = viewSettingDisplayColumnList[event.draggingIndex];
    viewSettingDisplayColumnList.removeAt(event.draggingIndex);
    viewSettingDisplayColumnList.insert(event.newPositionIndex, draggedItem);
    emit(state.copyWith(
        viewSettingDisplayColumnList: viewSettingDisplayColumnList));
  }

  void _onUserListViewSettingDisplayColumnSelected(
    UserListViewSettingDisplayColumnSelected event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayColumnList =
        List.from(state.viewSettingDisplayColumnList);
    final item = viewSettingDisplayColumnList.removeAt(event.columnIndex);
    viewSettingDisplayColumnList.insert(
        event.columnIndex,
        item.copyWith(
          order: event.columnIndex + 1,
          key: ValueKey(event.columnIndex),
          selectedValue: event.selectedValue,
        ));
    emit(state.copyWith(
        viewSettingDisplayColumnList: viewSettingDisplayColumnList));
  }

  void _onUserListViewSettingSortingColumnSelected(
    UserListViewSettingSortingColumnSelected event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingColumnList =
        List.from(state.viewSettingSortingColumnList);
    final item = viewSettingSortingColumnList.removeAt(event.columnIndex);
    viewSettingSortingColumnList.insert(
        event.columnIndex,
        item.copyWith(
          order: event.columnIndex + 1,
          key: ValueKey(event.columnIndex),
          selectedValue: event.selectedValue,
        ));
    emit(state.copyWith(
        viewSettingSortingColumnList: viewSettingSortingColumnList));
  }

  void _onUserListViewSettingDisplayColumnAdded(
    UserListViewSettingDisplayColumnAdded event,
    Emitter<UserListViewSettingState> emit,
  ) {
    emit(state.copyWith(viewSettingDisplayColumnList: [
      ...state.viewSettingDisplayColumnList,
      ViewSettingItemData(
        order: state.viewSettingDisplayColumnList.length + 1,
        key: ValueKey(state.viewSettingDisplayColumnList.length),
      )
    ]));
  }

  void _onUserListViewSettingSortingColumnAdded(
    UserListViewSettingSortingColumnAdded event,
    Emitter<UserListViewSettingState> emit,
  ) {
    emit(state.copyWith(viewSettingSortingColumnList: [
      ...state.viewSettingSortingColumnList,
      ViewSettingItemData(
        order: state.viewSettingDisplayColumnList.length + 1,
        key: ValueKey(state.viewSettingSortingColumnList.length),
      )
    ]));
  }

  void _onUserListViewSettingDisplayColumnDeleted(
    UserListViewSettingDisplayColumnDeleted event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayColumnList =
        List.from(state.viewSettingDisplayColumnList);
    viewSettingDisplayColumnList.removeAt(event.columnIndex);

    emit(state.copyWith(
        viewSettingDisplayColumnList: viewSettingDisplayColumnList));
  }

  void _onUserListViewSettingSortingColumnDeleted(
    UserListViewSettingSortingColumnDeleted event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingColumnList =
        List.from(state.viewSettingSortingColumnList);
    viewSettingSortingColumnList.removeAt(event.columnIndex);

    emit(state.copyWith(
        viewSettingSortingColumnList: viewSettingSortingColumnList));
  }

  void _onUserListViewSettingSortingColumnSortDirectionChanged(
    UserListViewSettingSortingColumnSortDirectionChanged event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingColumnList =
        List.from(state.viewSettingSortingColumnList);

    final columnItem = viewSettingSortingColumnList.removeAt(event.columnIndex);

    viewSettingSortingColumnList.insert(event.columnIndex,
        columnItem.copyWith(sortDirection: event.sortDirection));

    emit(state.copyWith(
        viewSettingSortingColumnList: viewSettingSortingColumnList));
  }
}
