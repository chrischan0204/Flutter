import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

part 'view_setting_event.dart';
part 'view_setting_state.dart';

class ViewSettingBloc
    extends Bloc<ViewSettingEvent, ViewSettingState> {
  final SettingsRepository settingsRepository;

  ViewSettingBloc({required this.settingsRepository})
      : super(const ViewSettingState()) {
    on<ViewSettingApplied>(_onViewSettingApplied);
    on<ViewSettingLoaded>(_onViewSettingLoaded);
    on<ViewSettingDisplayColumnOrderChanged>(
        _onViewSettingDisplayColumnOrderChanged);
    on<ViewSettingDisplayColumnSelected>(
        _onViewSettingDisplayColumnSelected);
    on<ViewSettingDisplayColumnAdded>(
        _onViewSettingDisplayColumnAdded);
    on<ViewSettingDisplayColumnDeleted>(
        _onViewSettingDisplayColumnDeleted);

    on<ViewSettingSortingColumnOrderChanged>(
        _onViewSettingSortingColumnOrderChanged);
    on<ViewSettingSortingColumnSortDirectionChanged>(
        _onViewSettingSortingColumnSortDirectionChanged);
    on<ViewSettingSortingColumnSelected>(
        _onViewSettingSortingColumnSelected);
    on<ViewSettingSortingColumnAdded>(
        _onViewSettingSortingColumnAdded);
    on<ViewSettingSortingColumnDeleted>(
        _onViewSettingSortingColumnDeleted);
  }

  Future<void> _onViewSettingApplied(
    ViewSettingApplied event,
    Emitter<ViewSettingState> emit,
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

  Future<void> _onViewSettingLoaded(
    ViewSettingLoaded event,
    Emitter<ViewSettingState> emit,
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

  void _onViewSettingSortingColumnOrderChanged(
    ViewSettingSortingColumnOrderChanged event,
    Emitter<ViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingColumnList =
        List.from(state.viewSettingSortingColumnList);
    final draggedItem = viewSettingSortingColumnList[event.draggingIndex];
    viewSettingSortingColumnList.removeAt(event.draggingIndex);
    viewSettingSortingColumnList.insert(event.newPositionIndex, draggedItem);
    emit(state.copyWith(
        viewSettingSortingColumnList: viewSettingSortingColumnList));
  }

  void _onViewSettingDisplayColumnOrderChanged(
    ViewSettingDisplayColumnOrderChanged event,
    Emitter<ViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayColumnList =
        List.from(state.viewSettingDisplayColumnList);
    final draggedItem = viewSettingDisplayColumnList[event.draggingIndex];
    viewSettingDisplayColumnList.removeAt(event.draggingIndex);
    viewSettingDisplayColumnList.insert(event.newPositionIndex, draggedItem);
    emit(state.copyWith(
        viewSettingDisplayColumnList: viewSettingDisplayColumnList));
  }

  void _onViewSettingDisplayColumnSelected(
    ViewSettingDisplayColumnSelected event,
    Emitter<ViewSettingState> emit,
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

  void _onViewSettingSortingColumnSelected(
    ViewSettingSortingColumnSelected event,
    Emitter<ViewSettingState> emit,
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

  void _onViewSettingDisplayColumnAdded(
    ViewSettingDisplayColumnAdded event,
    Emitter<ViewSettingState> emit,
  ) {
    emit(state.copyWith(viewSettingDisplayColumnList: [
      ...state.viewSettingDisplayColumnList,
      ViewSettingItemData(
        key: ValueKey(const Uuid().v1()),
      )
    ]));
  }

  void _onViewSettingSortingColumnAdded(
    ViewSettingSortingColumnAdded event,
    Emitter<ViewSettingState> emit,
  ) {
    emit(state.copyWith(viewSettingSortingColumnList: [
      ...state.viewSettingSortingColumnList,
      ViewSettingItemData(
        key: ValueKey(const Uuid().v1()),
      )
    ]));
  }

  void _onViewSettingDisplayColumnDeleted(
    ViewSettingDisplayColumnDeleted event,
    Emitter<ViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingDisplayColumnList =
        List.from(state.viewSettingDisplayColumnList);
    final int index = viewSettingDisplayColumnList.indexOf(event.column);
    final item = viewSettingDisplayColumnList.removeAt(index);
    viewSettingDisplayColumnList.insert(index, item.copyWith(deleted: true));

    emit(state.copyWith(
        viewSettingDisplayColumnList: viewSettingDisplayColumnList));
  }

  void _onViewSettingSortingColumnDeleted(
    ViewSettingSortingColumnDeleted event,
    Emitter<ViewSettingState> emit,
  ) {
    List<ViewSettingItemData> viewSettingSortingColumnList =
        List.from(state.viewSettingSortingColumnList);

    final int index = viewSettingSortingColumnList.indexOf(event.column);
    final item = viewSettingSortingColumnList.removeAt(index);
    viewSettingSortingColumnList.insert(index, item.copyWith(deleted: true));

    emit(state.copyWith(
        viewSettingSortingColumnList: viewSettingSortingColumnList));
  }

  void _onViewSettingSortingColumnSortDirectionChanged(
    ViewSettingSortingColumnSortDirectionChanged event,
    Emitter<ViewSettingState> emit,
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
