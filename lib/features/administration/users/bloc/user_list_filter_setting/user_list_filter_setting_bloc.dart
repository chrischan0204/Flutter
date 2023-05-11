import 'package:equatable/equatable.dart';
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
    } catch (e) {
      emit(state.copyWith(
          userFilterSettingListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUserListFilterSettingUserFilterSettingLoadedById(
    UserListFilterSettingUserFilterSettingLoadedById event,
    Emitter<UserListFilterSettingState> emit,
  ) async {}

  Future<void> _onUserListFilterSettingUserFilterSettingDeletedById(
    UserListFilterSettingUserFilterSettingDeletedById event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    emit(state.copyWith(userFilterSettingLoadStatus: EntityStatus.loading));

    try {
      final UserFilter userFilterUpdate =
          await settingsRepository.getUserFilterById(event.filterId);
      emit(state.copyWith(
        userFilterSettingLoadStatus: EntityStatus.success,
        userFilterUpdate: userFilterUpdate,
      ));
    } catch (e) {
      emit(state.copyWith(userFilterSettingLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUserListFilterSettingUserFilterSettingUpdated(
    UserListFilterSettingUserFilterSettingUpdated event,
    Emitter<UserListFilterSettingState> emit,
  ) async {
    if (state.userFilterUpdate != null) {
      emit(state.copyWith(userFilterSettingUpdateStatus: EntityStatus.loading));

      try {
        await settingsRepository
            .updateUserFilterSetting(state.userFilterUpdate!);
      } catch (e) {
        emit(state.copyWith(
            userFilterSettingUpdateStatus: EntityStatus.failure));
      }
    }
  }
}
