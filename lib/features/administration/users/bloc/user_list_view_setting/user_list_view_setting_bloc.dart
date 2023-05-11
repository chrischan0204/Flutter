import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

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
      emit(state.copyWith(viewSettingSaveStatus: EntityStatus.loading));
      final viewSettingUpdate = ViewSettingUpdate(
        viewName: event.viewName,
        displayColumns: state.viewSettingDisplayColumnList
            .map((e) => e
                .copyWith(
                    order:
                        state.undeletedViewSettingDisplayColumnList.indexOf(e) +
                            1)
                .toViewSettingColumnUpdate()!)
            .toList(),
        sortingColumns: state.viewSettingSortingColumnList
            .map((e) => e
                .copyWith(
                    order:
                        state.undeletedViewSettingSortingColumnList.indexOf(e) +
                            1)
                .toViewSettingColumnUpdate()!)
            .toList(),
      );
      try {
        await settingsRepository.applyViewSetting(viewSettingUpdate);
        emit(state.copyWith(viewSettingSaveStatus: EntityStatus.success));
      } catch (e) {
        emit(state.copyWith(viewSettingSaveStatus: EntityStatus.failure));
      }
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
                  key: ValueKey(const Uuid().v1()),
                  selectedValue: e,
                ))
            .toList(),
        viewSettingSortingColumnList: viewSetting.sortingColumnList
            .map((e) => ViewSettingItemData(
                  id: e.id,
                  order: e.order,
                  key: ValueKey(const Uuid().v1()),
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
    final deletedViewSettingDisplayColumnList = List.from(
        state.viewSettingDisplayColumnList.where((element) => element.deleted));

    int index = state.viewSettingDisplayColumnList.indexWhere((element) =>
        element.selectedValue?.viewSettingId ==
        event.selectedValue.viewSettingId);
    if (index != -1) {
      viewSettingDisplayColumnList.removeAt(index);
    }

    index = viewSettingDisplayColumnList.indexOf(event.column);
    final item = viewSettingDisplayColumnList.removeAt(index);
    viewSettingDisplayColumnList.insert(
        index,
        item.copyWith(
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
    final int index = viewSettingSortingColumnList.indexOf(event.column);
    final item = viewSettingSortingColumnList.removeAt(index);

    viewSettingSortingColumnList.insert(
        index,
        item.copyWith(
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
        key: ValueKey(const Uuid().v1()),
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
        key: ValueKey(const Uuid().v1()),
      )
    ]));
  }

  void _onUserListViewSettingDisplayColumnDeleted(
    UserListViewSettingDisplayColumnDeleted event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayColumnList =
        List.from(state.viewSettingDisplayColumnList);
    final int index = viewSettingDisplayColumnList.indexOf(event.column);
    final item = viewSettingDisplayColumnList.removeAt(index);
    viewSettingDisplayColumnList.insert(index, item.copyWith(deleted: true));

    emit(state.copyWith(
        viewSettingDisplayColumnList: viewSettingDisplayColumnList));
  }

  void _onUserListViewSettingSortingColumnDeleted(
    UserListViewSettingSortingColumnDeleted event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingColumnList =
        List.from(state.viewSettingSortingColumnList);

    final int index = viewSettingSortingColumnList.indexOf(event.column);
    final item = viewSettingSortingColumnList.removeAt(index);
    viewSettingSortingColumnList.insert(index, item.copyWith(deleted: true));

    emit(state.copyWith(
        viewSettingSortingColumnList: viewSettingSortingColumnList));
  }

  void _onUserListViewSettingSortingColumnSortDirectionChanged(
    UserListViewSettingSortingColumnSortDirectionChanged event,
    Emitter<UserListViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingColumnList =
        List.from(state.viewSettingSortingColumnList);
    final int index = viewSettingSortingColumnList.indexOf(event.column);
    final columnItem = viewSettingSortingColumnList.removeAt(index);

    viewSettingSortingColumnList.insert(
        index, columnItem.copyWith(sortDirection: event.sortDirection));

    emit(state.copyWith(
        viewSettingSortingColumnList: viewSettingSortingColumnList));
  }
}
