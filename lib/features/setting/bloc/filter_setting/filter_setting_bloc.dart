import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '/common_libraries.dart';

part 'filter_setting_event.dart';
part 'filter_setting_state.dart';

class FilterSettingBloc extends Bloc<FilterSettingEvent, FilterSettingState> {
  final SettingsRepository settingsRepository;

  FilterSettingBloc({required this.settingsRepository})
      : super(const FilterSettingState()) {
    on<FilterSettingFilterSettingListLoaded>(
        _onFilterSettingFilterSettingListLoaded);
    on<FilterSettingUserFilterSettingListLoaded>(
        _onFilterSettingUserFilterSettingListLoaded);
    on<FilterSettingUserFilterSettingLoadedById>(
        _onFilterSettingUserFilterSettingLoadedById);
    on<FilterSettingUserFilterSettingDeletedById>(
        _onFilterSettingUserFilterSettingDeletedById);
    on<FilterSettingUserFilterSettingUpdated>(
        _onFilterSettingUserFilterSettingUpdated);
    on<FilterSettingUserFilterSettingSavedAs>(
        _onFilterSettingUserFilterSettingSavedAs);
    on<FilterSettingUserFilterNameChanged>(
        _onFilterSettingUserFilterNameChanged);
    on<FilterSettingUserFilterIsDefaultChanged>(
        _onFilterSettingUserFilterIsDefaultChanged);
    on<FilterSettingUserFilterSettingSelected>(
        _onFilterSettingUserFilterSettingSelected);
    on<FilterSettingUserFilterItemAdded>(_onFilterSettingUserFilterItemAdded);
    on<FilterSettingUserFilterItemDeleted>(
        _onFilterSettingUserFilterItemDeleted);
    on<FilterSettingUserFilterItemBooleanConditionChanged>(
        _onFilterSettingUserFilterItemBooleanConditionChanged);
    on<FilterSettingUserFilterItemOperatorChanged>(
        _onFilterSettingUserFilterItemOperatorChanged);
    on<FilterSettingUserFilterItemValueChanged>(
        _onFilterSettingUserFilterItemValueChanged);
    on<FilterSettingUserFilterItemColumnChanged>(
        _onFilterSettingUserFilterItemColumnChanged);

    on<FilterSettingUserFilterAdded>(_onFilterSettingUserFilterAdded);
    on<FilterSettingIncludeDeletedChanged>(
        _onFilterSettingIncludeDeletedChanged);
  }

  Future<void> _onFilterSettingFilterSettingListLoaded(
    FilterSettingFilterSettingListLoaded event,
    Emitter<FilterSettingState> emit,
  ) async {
    emit(state.copyWith(filterSettingListLoadStatus: EntityStatus.loading));
    try {
      final List<FilterSetting> filterSettingList =
          await settingsRepository.getFilterSettingList(event.name);
      for (var filterSetting in filterSettingList
          .where((element) => element.columnValueURL.contains('api'))) {
        if (filterSetting.columnValueURL.contains('api')) {
          try {
            List<String> columnValues = await settingsRepository
                .getNameList(filterSetting.columnValueURL);

            int index = filterSettingList.indexOf(filterSetting);
            filterSettingList.remove(filterSetting);
            filterSettingList.insert(
                index, filterSetting.copyWith(columnValues: columnValues));
          } catch (e) {
            // print(e);
          }
        }
      }

      emit(state.copyWith(
        filterSettingList: filterSettingList,
        filterSettingListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(filterSettingListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onFilterSettingUserFilterSettingListLoaded(
    FilterSettingUserFilterSettingListLoaded event,
    Emitter<FilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingListLoadStatus: EntityStatus.loading));

    try {
      List<UserFilterSetting> userFilterSettingList =
          await settingsRepository.getUserFilterSettingList(event.name);

      if (userFilterSettingList.isEmpty) {
        emit(state.copyWith(
          userFilterUpdate: UserFilter(
            viewName: event.name,
            userFilterItems: const [UserFilterItem()],
          ),
          selectedUserFilterSetting: const UserFilterSetting(),
          saveAsButtonName: 'Add new',
        ));
      } else {
        if (state.selectedUserFilterSetting == null) {
          if (userFilterSettingList
                  .indexWhere((element) => element.isDefault) !=
              -1) {
            add(FilterSettingUserFilterSettingSelected(
                userFilterSetting: userFilterSettingList
                    .firstWhere((element) => element.isDefault)));
          } else if (userFilterSettingList.isNotEmpty) {
            add(FilterSettingUserFilterSettingSelected(
                userFilterSetting: userFilterSettingList[0]));
          }
        }
        emit(state.copyWith(
          userFilterSettingListLoadStatus: EntityStatus.success,
          userFilterSettingList: userFilterSettingList,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          userFilterSettingListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onFilterSettingUserFilterSettingLoadedById(
    FilterSettingUserFilterSettingLoadedById event,
    Emitter<FilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingLoadStatus: EntityStatus.loading));
    try {
      final UserFilter userFilter =
          await settingsRepository.getUserFilterById(event.filterId);
      try {
        // print(state.filterSettingList.map((e) => e.id).toString());
        // for(var e in state.filterSettingList.map((e) => e.id)) {
        //   print(e);
        // }
        // print(userFilter.userFilterItems.map((e) => e.id));
        emit(state.copyWith(
          userFilterUpdate: userFilter.userFilterItems.isEmpty
              ? userFilter.copyWith(
                  userFilterItems: [UserFilterItem(id: const Uuid().v1())])
              : userFilter.copyWith(
                  userFilterItems: userFilter.userFilterItems.map((e) {
                  return e.copyWith(
                    filterSetting:
                        state.getFilterSettingById(e.filterSetting.id),
                    filterValue: e.filterValue
                        .where((element) => element.isNotEmpty)
                        .toList(),
                  );
                }).toList()),
          userFilterSettingLoadStatus: EntityStatus.success,
          saveAsButtonName: 'Save as',
        ));
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(userFilterSettingLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onFilterSettingUserFilterSettingDeletedById(
    FilterSettingUserFilterSettingDeletedById event,
    Emitter<FilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingDeleteStatus: EntityStatus.loading));

    try {
      final EntityResponse response =
          await settingsRepository.deleteUserFilterSettingById(event.filterId);
      emit(state.copyWith(
        userFilterSettingDeleteStatus: response.isSuccess.toEntityStatusCode(),
        selectedUserFilterSetting: null,
      ));
    } catch (e) {
      emit(state.copyWith(userFilterSettingDeleteStatus: EntityStatus.failure));
    }
  }

  Future<void> _onFilterSettingUserFilterSettingUpdated(
    FilterSettingUserFilterSettingUpdated event,
    Emitter<FilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingUpdateStatus: EntityStatus.loading));

    try {
      UserFilter updatedUserFilter = await settingsRepository
          .updateUserFilterSetting(state.userFilterUpdate);
      print(updatedUserFilter.id);
      emit(state.copyWith(
        userFilterSettingUpdateStatus: EntityStatus.success,
        selectedUserFilterSetting: UserFilterSetting(
          id: updatedUserFilter.id,
          filterName: updatedUserFilter.filterName,
          isDefault: updatedUserFilter.isDefault,
        ),
        userFilterUpdate: state.userFilterUpdate.copyWith(
            id: updatedUserFilter.id,
            filterName: updatedUserFilter.filterName,
            userFilterItems: state.userFilterUpdate.undeletedUserFilterItems
                .map((e) => e.copyWith(
                    id: updatedUserFilter
                        .userFilterItems[
                            state.userFilterUpdate.userFilterItems.indexOf(e)]
                        .id))
                .toList()
                .toSet()
                .toList()),
        addButtonName: 'Update',
        saveAsButtonName: 'Save as',
      ));
    } catch (e) {
      emit(state.copyWith(userFilterSettingUpdateStatus: EntityStatus.failure));
    }
  }

  Future<void> _onFilterSettingUserFilterSettingSavedAs(
    FilterSettingUserFilterSettingSavedAs event,
    Emitter<FilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingUpdateStatus: EntityStatus.loading));

    try {
      UserFilter updatedUserFilter = await settingsRepository
          .updateUserFilterSetting(state.userFilterUpdate.copyWith(
              id: '00000000-0000-0000-0000-000000000000',
              filterName: event.saveAsName,
              userFilterItems: state.userFilterUpdate.userFilterItems
                  .map((e) => e.copyWith(
                        id: '00000000-0000-0000-0000-000000000000',
                      ))
                  .toList()));
      emit(state.copyWith(
        userFilterSettingUpdateStatus: EntityStatus.success,
        selectedUserFilterSetting: UserFilterSetting(
          id: updatedUserFilter.id,
          filterName: updatedUserFilter.filterName,
          isDefault: updatedUserFilter.isDefault,
        ),
        userFilterUpdate: state.userFilterUpdate.copyWith(
            id: updatedUserFilter.id,
            filterName: updatedUserFilter.filterName,
            userFilterItems: state.userFilterUpdate.undeletedUserFilterItems
                .map((e) => e.copyWith(
                    id: updatedUserFilter
                        .userFilterItems[
                            state.userFilterUpdate.userFilterItems.indexOf(e)]
                        .id))
                .toList()
                .toSet()
                .toList()),
        addButtonName: 'Update',
        saveAsButtonName: 'Save as',
      ));
    } catch (e) {
      emit(state.copyWith(userFilterSettingUpdateStatus: EntityStatus.failure));
    }
  }

  void _onFilterSettingUserFilterNameChanged(
    FilterSettingUserFilterNameChanged event,
    Emitter<FilterSettingState> emit,
  ) {
    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(filterName: event.filterName)));
  }

  void _onFilterSettingUserFilterIsDefaultChanged(
    FilterSettingUserFilterIsDefaultChanged event,
    Emitter<FilterSettingState> emit,
  ) {
    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(isDefault: event.isDefault)));
  }

  void _onFilterSettingUserFilterSettingSelected(
    FilterSettingUserFilterSettingSelected event,
    Emitter<FilterSettingState> emit,
  ) {
    emit(state.copyWith(selectedUserFilterSetting: event.userFilterSetting));
    if (event.userFilterSetting != null) {
      add(FilterSettingUserFilterSettingLoadedById(
          filterId: event.userFilterSetting!.id));
    }
  }

  void _onFilterSettingUserFilterItemAdded(
    FilterSettingUserFilterItemAdded event,
    Emitter<FilterSettingState> emit,
  ) {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    if (event.userFilterItem != null) {
      final index = userFilterItems.indexOf(event.userFilterItem!);
      userFilterItems.insert(
          index,
          UserFilterItem(
            id: '00000000-0000-0000-0000-000000000000',
            filterSetting: FilterSetting(id: const Uuid().v1()),
          ));
    } else {
      userFilterItems.add(UserFilterItem(
        id: '00000000-0000-0000-0000-000000000000',
        filterSetting: FilterSetting(id: const Uuid().v1()),
      ));
    }

    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(userFilterItems: userFilterItems)));
  }

  void _onFilterSettingUserFilterItemDeleted(
    FilterSettingUserFilterItemDeleted event,
    Emitter<FilterSettingState> emit,
  ) {
    if (state.userFilterUpdate.undeletedUserFilterItems.length > 1) {
      final List<UserFilterItem> userFilterItems =
          List.from(state.userFilterUpdate.userFilterItems);
      final index = userFilterItems.indexOf(event.userFilterItem);
      if (index != -1) {
        userFilterItems.remove(event.userFilterItem);

        if (!event.userFilterItem.isNew) {
          userFilterItems.insert(
              index, event.userFilterItem.copyWith(deleted: true));
        }

        emit(state.copyWith(
            userFilterUpdate: state.userFilterUpdate
                .copyWith(userFilterItems: userFilterItems)));
      }
    }
  }

  void _onFilterSettingUserFilterItemBooleanConditionChanged(
    FilterSettingUserFilterItemBooleanConditionChanged event,
    Emitter<FilterSettingState> emit,
  ) async {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    final index = userFilterItems.indexOf(event.userFilterItem);
    if (index != -1) {
      userFilterItems.remove(event.userFilterItem);
      userFilterItems.insert(
          index,
          event.userFilterItem
              .copyWith(booleanCondition: event.booleanCondition));

      emit(state.copyWith(
          userFilterUpdate: state.userFilterUpdate
              .copyWith(userFilterItems: userFilterItems)));
    }
  }

  void _onFilterSettingUserFilterItemOperatorChanged(
    FilterSettingUserFilterItemOperatorChanged event,
    Emitter<FilterSettingState> emit,
  ) async {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    final index = userFilterItems.indexOf(event.userFilterItem);
    if (index != -1) {
      userFilterItems.remove(event.userFilterItem);
      userFilterItems.insert(
          index, event.userFilterItem.copyWith(operator: event.operator));

      emit(state.copyWith(
          userFilterUpdate: state.userFilterUpdate
              .copyWith(userFilterItems: userFilterItems)));
    }
  }

  void _onFilterSettingUserFilterItemValueChanged(
    FilterSettingUserFilterItemValueChanged event,
    Emitter<FilterSettingState> emit,
  ) async {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    final index = userFilterItems.indexOf(event.userFilterItem);
    if (index != -1) {
      userFilterItems.remove(event.userFilterItem);
      userFilterItems.insert(
          index, event.userFilterItem.copyWith(filterValue: event.value));

      emit(state.copyWith(
          userFilterUpdate: state.userFilterUpdate
              .copyWith(userFilterItems: userFilterItems)));
    }
  }

  void _onFilterSettingUserFilterItemColumnChanged(
    FilterSettingUserFilterItemColumnChanged event,
    Emitter<FilterSettingState> emit,
  ) async {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    int index = userFilterItems.indexOf(event.userFilterItem);

    if (index != -1) {
      userFilterItems.remove(event.userFilterItem);
      userFilterItems.insert(
          index,
          event.userFilterItem
              .copyWith(filterSetting: event.column, filterValue: []));

      emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(userFilterItems: userFilterItems),
      ));
    }
  }

  void _onFilterSettingUserFilterAdded(
    FilterSettingUserFilterAdded event,
    Emitter<FilterSettingState> emit,
  ) async {
    emit(state.copyWith(
      userFilterUpdate: UserFilter(
          viewName: event.viewName, userFilterItems: const [UserFilterItem()]),
      addButtonName: 'Add',
    ));
  }

  void _onFilterSettingIncludeDeletedChanged(
    FilterSettingIncludeDeletedChanged event,
    Emitter<FilterSettingState> emit,
  ) {
    emit(state.copyWith(includeDeleted: event.includeDeleted));
  }
}
