import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '/common_libraries.dart';

part 'user_list_filter_setting_event.dart';
part 'user_list_filter_setting_state.dart';

class UserListFilterSettingBloc
    extends Bloc<UserListFilterSettingEvent, UserListFilterSettingState> {
  final SettingsRepository settingsRepository;

  UserListFilterSettingBloc({required this.settingsRepository})
      : super(const UserListFilterSettingState()) {
    on<UserListFilterSettingFilterSettingListLoaded>(
        _onUserListFilterSettingFilterSettingListLoaded);
    on<UserListFilterSettingUserFilterSettingListLoaded>(
        _onUserListFilterSettingUserFilterSettingListLoaded);
    on<UserListFilterSettingUserFilterSettingLoadedById>(
        _onUserListFilterSettingUserFilterSettingLoadedById);
    on<UserListFilterSettingUserFilterSettingDeletedById>(
        _onUserListFilterSettingUserFilterSettingDeletedById);
    on<UserListFilterSettingUserFilterSettingUpdated>(
        _onUserListFilterSettingUserFilterSettingUpdated);
    on<UserListFilterSettingUserFilterNameChanged>(
        _onUserListFilterSettingUserFilterNameChanged);
    on<UserListFilterSettingUserFilterIsDefaultChanged>(
        _onUserListFilterSettingUserFilterIsDefaultChanged);

    on<UserListFilterSettingUserFilterSettingSelected>(
        _onUserListFilterSettingUserFilterSettingSelected);
    on<UserListFilterSettingUserFilterItemAdded>(
        _onUserListFilterSettingUserFilterItemAdded);
    on<UserListFilterSettingUserFilterItemDeleted>(
        _onUserListFilterSettingUserFilterItemDeleted);
    on<UserListFilterSettingUserFilterItemBooleanConditionChanged>(
        _onUserListFilterSettingUserFilterItemBooleanConditionChanged);
    on<UserListFilterSettingUserFilterItemOperatorChanged>(
        _onUserListFilterSettingUserFilterItemOperatorChanged);
    on<UserListFilterSettingUserFilterItemValueChanged>(
        _onUserListFilterSettingUserFilterItemValueChanged);
    on<UserListFilterSettingUserFilterItemColumnChanged>(
        _onUserListFilterSettingUserFilterItemColumnChanged);

    on<UserListFilterSettingUserFilterAdded>(
        _onUserListFilterSettingUserFilterAdded);
  }

  Future<void> _onUserListFilterSettingFilterSettingListLoaded(
    UserListFilterSettingFilterSettingListLoaded event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    emit(state.copyWith(filterSettingListLoadStatus: EntityStatus.loading));
    try {
      final List<FilterSetting> filterSettingList =
          await settingsRepository.getFilterSettingList(event.name);
      emit(state.copyWith(
        filterSettingList: filterSettingList,
        filterSettingListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(filterSettingListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUserListFilterSettingUserFilterSettingListLoaded(
    UserListFilterSettingUserFilterSettingListLoaded event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingListLoadStatus: EntityStatus.loading));

    try {
      List<UserFilterSetting> userFilterSettingList =
          await settingsRepository.getUserFilterSettingList(event.name);

      emit(state.copyWith(
        userFilterSettingListLoadStatus: EntityStatus.success,
        userFilterSettingList: userFilterSettingList,
      ));

      if (state.selectedUserFilterSetting == null) {
        if (userFilterSettingList.indexWhere((element) => element.isDefault) !=
            -1) {
          add(UserListFilterSettingUserFilterSettingSelected(
              userFilterSetting: userFilterSettingList
                  .firstWhere((element) => element.isDefault)));
        } else if (userFilterSettingList.isNotEmpty) {
          add(UserListFilterSettingUserFilterSettingSelected(
              userFilterSetting: userFilterSettingList[0]));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          userFilterSettingListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUserListFilterSettingUserFilterSettingLoadedById(
    UserListFilterSettingUserFilterSettingLoadedById event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingLoadStatus: EntityStatus.loading));
    try {
      final UserFilter userFilter =
          await settingsRepository.getUserFilterById(event.filterId);
      emit(state.copyWith(
          userFilterUpdate: userFilter.userFilterItems.isEmpty
              ? userFilter.copyWith(
                  userFilterItems: [UserFilterItem(id: const Uuid().v1())])
              : userFilter.copyWith(
                  userFilterItems: userFilter.userFilterItems
                      .map((e) => e.copyWith(
                          filterSetting:
                              state.getFilterSettingById(e.filterSetting.id)))
                      .toList()),
          userFilterSettingLoadStatus: EntityStatus.success));
    } catch (e) {
      emit(state.copyWith(userFilterSettingLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUserListFilterSettingUserFilterSettingDeletedById(
    UserListFilterSettingUserFilterSettingDeletedById event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingDeleteStatus: EntityStatus.loading));

    try {
      final EntityResponse response =
          await settingsRepository.deleteUserFilterSettingById(event.filterId);
      emit(state.copyWith(
        userFilterSettingDeleteStatus: response.isSuccess.toEntityStatusCode(),
      ));

      if (response.isSuccess) {
        add(const UserListFilterSettingUserFilterSettingListLoaded(
            name: 'user'));
      }
    } catch (e) {
      emit(state.copyWith(userFilterSettingDeleteStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUserListFilterSettingUserFilterSettingUpdated(
    UserListFilterSettingUserFilterSettingUpdated event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingUpdateStatus: EntityStatus.loading));

    try {
      EntityResponse response = await settingsRepository
          .updateUserFilterSetting(state.userFilterUpdate);
      emit(state.copyWith(
          userFilterSettingUpdateStatus:
              response.isSuccess.toEntityStatusCode()));
      if (response.isSuccess) {
        add(const UserListFilterSettingUserFilterSettingListLoaded(
            name: 'user'));
      }
    } catch (e) {
      emit(state.copyWith(userFilterSettingUpdateStatus: EntityStatus.failure));
    }
  }

  void _onUserListFilterSettingUserFilterNameChanged(
    UserListFilterSettingUserFilterNameChanged event,
    Emitter<UserListFilterSettingState> emit,
  ) {
    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(filterName: event.filterName)));
  }

  void _onUserListFilterSettingUserFilterIsDefaultChanged(
    UserListFilterSettingUserFilterIsDefaultChanged event,
    Emitter<UserListFilterSettingState> emit,
  ) {
    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(isDefault: event.isDefault)));
  }

  void _onUserListFilterSettingUserFilterSettingSelected(
    UserListFilterSettingUserFilterSettingSelected event,
    Emitter<UserListFilterSettingState> emit,
  ) {
    emit(state.copyWith(selectedUserFilterSetting: event.userFilterSetting));
    if (event.userFilterSetting != null) {
      add(UserListFilterSettingUserFilterSettingLoadedById(
          filterId: event.userFilterSetting!.id));
    }
  }

  void _onUserListFilterSettingUserFilterItemAdded(
    UserListFilterSettingUserFilterItemAdded event,
    Emitter<UserListFilterSettingState> emit,
  ) {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    if (event.userFilterItem != null) {
      final index = userFilterItems.indexOf(event.userFilterItem!);
      userFilterItems.insert(index, UserFilterItem(id: const Uuid().v1()));
    } else {
      userFilterItems.add(UserFilterItem(id: const Uuid().v1()));
    }

    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(userFilterItems: userFilterItems)));
  }

  void _onUserListFilterSettingUserFilterItemDeleted(
    UserListFilterSettingUserFilterItemDeleted event,
    Emitter<UserListFilterSettingState> emit,
  ) {
    if (state.userFilterUpdate.undeletedUserFilterItems.length > 1) {
      final List<UserFilterItem> userFilterItems =
          List.from(state.userFilterUpdate.userFilterItems);
      final index = userFilterItems.indexOf(event.userFilterItem);
      userFilterItems.remove(event.userFilterItem);
      userFilterItems.insert(
          index, event.userFilterItem.copyWith(deleted: true));

      emit(state.copyWith(
          userFilterUpdate: state.userFilterUpdate
              .copyWith(userFilterItems: userFilterItems)));
    }
  }

  void _onUserListFilterSettingUserFilterItemBooleanConditionChanged(
    UserListFilterSettingUserFilterItemBooleanConditionChanged event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    final index = userFilterItems.indexOf(event.userFilterItem);
    userFilterItems.remove(event.userFilterItem);
    userFilterItems.insert(
        index,
        event.userFilterItem
            .copyWith(booleanCondition: event.booleanCondition));

    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(userFilterItems: userFilterItems)));
  }

  void _onUserListFilterSettingUserFilterItemOperatorChanged(
    UserListFilterSettingUserFilterItemOperatorChanged event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    final index = userFilterItems.indexOf(event.userFilterItem);
    userFilterItems.remove(event.userFilterItem);
    userFilterItems.insert(
        index, event.userFilterItem.copyWith(operator: event.operator));

    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(userFilterItems: userFilterItems)));
  }

  void _onUserListFilterSettingUserFilterItemValueChanged(
    UserListFilterSettingUserFilterItemValueChanged event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    final index = userFilterItems.indexOf(event.userFilterItem);
    userFilterItems.remove(event.userFilterItem);
    userFilterItems.insert(
        index, event.userFilterItem.copyWith(filterValue: [event.value]));

    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(userFilterItems: userFilterItems)));
  }

  void _onUserListFilterSettingUserFilterItemColumnChanged(
    UserListFilterSettingUserFilterItemColumnChanged event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    final List<UserFilterItem> userFilterItems =
        List.from(state.userFilterUpdate.userFilterItems);
    final index = userFilterItems.indexOf(event.userFilterItem);
    userFilterItems.remove(event.userFilterItem);
    userFilterItems.insert(
        index,
        event.userFilterItem
            .copyWith(filterSetting: event.column, filterValue: ['']));

    emit(state.copyWith(
        userFilterUpdate:
            state.userFilterUpdate.copyWith(userFilterItems: userFilterItems)));
  }

  void _onUserListFilterSettingUserFilterAdded(
    UserListFilterSettingUserFilterAdded event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    emit(state.copyWith(
        userFilterUpdate: const UserFilter(
            viewName: 'user', userFilterItems: [UserFilterItem()])));
  }
}
