import '/common_libraries.dart';

part 'notification_setting_event.dart';
part 'notification_setting_state.dart';

class NotificationSettingBloc
    extends Bloc<NotificationSettingEvent, NotificationSettingState> {
  final UsersRepository usersRepository;
  NotificationSettingBloc({required this.usersRepository})
      : super(const NotificationSettingState()) {
    on<NotificationSettingUserSiteNotificationLoaded>(
        _onNotificationSettingUserSiteNotificationLoaded);
    on<NotificationSettingNotificationUpdated>(
        _onNotificationSettingNotificationUpdated);
    on<NotificationSettingAllChanged>(_onNotificationSettingAllChanged);
    on<NotificationSettingGoodCatchChanged>(
        _onNotificationSettingGoodCatchChanged);
    on<NotificationSettingNearMissChanged>(
        _onNotificationSettingNearMissChanged);
    on<NotificationSettingSafeChanged>(_onNotificationSettingSafeChanged);
    on<NotificationSettingUnsafeChanged>(_onNotificationSettingUnsafeChanged);
  }

  Future<void> _onNotificationSettingUserSiteNotificationLoaded(
    NotificationSettingUserSiteNotificationLoaded event,
    Emitter<NotificationSettingState> emit,
  ) async {
    emit(state.copyWith(userSiteNotificationLoadStatus: EntityStatus.loading));
    try {
      UserSiteNotification userSiteNotification =
          await usersRepository.getUserSiteNotificationByUserId(event.userId);
      emit(state.copyWith(
        userSiteNotificationLoadStatus: EntityStatus.success,
        userSiteNotification: userSiteNotification,
      ));
    } catch (e) {
      emit(
          state.copyWith(userSiteNotificationLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onNotificationSettingNotificationUpdated(
    NotificationSettingNotificationUpdated event,
    Emitter<NotificationSettingState> emit,
  ) async {
    emit(state.copyWith(siteNotificationUpdateStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository
          .updateUserSiteNotificationSetting(event.userSiteNotificationSetting);
      emit(state.copyWith(
        siteNotificationUpdateStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(siteNotificationUpdateStatus: EntityStatus.failure));
    }
  }

  void _onNotificationSettingAllChanged(
    NotificationSettingAllChanged event,
    Emitter<NotificationSettingState> emit,
  ) async {
    // final result = state.userSiteNotification.firstWhere(
    //     (userSiteNotification) =>
    //         userSiteNotification.id == event.userSiteNotificationId);
    // add(NotificationSettingNotificationUpdated(
    //   userSiteNotification: result.copyWith(
    //     goodCatch: event.all,
    //     nearMiss: event.all,
    //     safe: event.all,
    //     unsafe: event.all,
    //   ),
    // ));
  }

  void _onNotificationSettingGoodCatchChanged(
    NotificationSettingGoodCatchChanged event,
    Emitter<NotificationSettingState> emit,
  ) async {
    // final result = state.userSiteNotification.firstWhere(
    //     (userSiteNotification) =>
    //         userSiteNotification.id == event.userSiteNotificationId);
    // add(NotificationSettingNotificationUpdated(
    //   userSiteNotification: result.copyWith(goodCatch: event.goodCatch),
    // ));
  }

  void _onNotificationSettingNearMissChanged(
    NotificationSettingNearMissChanged event,
    Emitter<NotificationSettingState> emit,
  ) async {
    // final result = state.userSiteNotification.firstWhere(
    //     (userSiteNotification) =>
    //         userSiteNotification.id == event.userSiteNotificationId);
    // add(NotificationSettingNotificationUpdated(
    //   userSiteNotification: result.copyWith(nearMiss: event.nearMiss),
    // ));
  }

  void _onNotificationSettingSafeChanged(
    NotificationSettingSafeChanged event,
    Emitter<NotificationSettingState> emit,
  ) async {
    // final result = state.userSiteNotification.firstWhere(
    //     (userSiteNotification) =>
    //         userSiteNotification.id == event.userSiteNotificationId);
    // add(NotificationSettingNotificationUpdated(
    //   userSiteNotification: result.copyWith(safe: event.safe),
    // ));
  }

  void _onNotificationSettingUnsafeChanged(
    NotificationSettingUnsafeChanged event,
    Emitter<NotificationSettingState> emit,
  ) async {
    // final result = state.userSiteNotification.firstWhere(
    //     (userSiteNotification) =>
    //         userSiteNotification.id == event.userSiteNotificationId);
    // add(NotificationSettingNotificationUpdated(
    //   userSiteNotification: result.copyWith(unsafe: event.unsafe),
    // ));
  }
}
