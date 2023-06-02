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
    on<NotificationObservationTypeNotificationAllChanged>(
        _onNotificationObservationTypeNotificationAllChanged);
    on<NotificationObservationTypeNotificationChanged>(
        _onNotificationObservationTypeNotificationChanged);
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

  void _onNotificationObservationTypeNotificationAllChanged(
    NotificationObservationTypeNotificationAllChanged event,
    Emitter<NotificationSettingState> emit,
  ) async {
    emit(state.copyWith(siteNotificationUpdateStatus: EntityStatus.loading));

    try {
      EntityResponse response =
          await usersRepository.updateUserSiteNotificationSetting(
              event.userSiteNotificationSetting.copyWith(
                  observationTypes: event
                      .userSiteNotificationSetting.observationTypes
                      .map((e) =>
                          e.copyWith(sendNotification: event.sendNotification))
                      .toList()));

      emit(state.copyWith(
        siteNotificationUpdateStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        siteNotificationUpdateStatus: EntityStatus.failure,
        message: 'Something went wrong',
      ));
    }
  }

  Future<void> _onNotificationObservationTypeNotificationChanged(
    NotificationObservationTypeNotificationChanged event,
    Emitter<NotificationSettingState> emit,
  ) async {
    emit(state.copyWith(siteNotificationUpdateStatus: EntityStatus.loading));

    try {
      EntityResponse response =
          await usersRepository.updateUserSiteNotificationSetting(
              event.userSiteNotificationSetting.copyWith(
                  observationTypes: event
                      .userSiteNotificationSetting.observationTypes
                      .map((e) => e.observationTypeId == event.observationTypeId
                          ? e.copyWith(sendNotification: event.sendNotification)
                          : e)
                      .toList()));

      emit(state.copyWith(
        siteNotificationUpdateStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        siteNotificationUpdateStatus: EntityStatus.failure,
        message: 'Something went wrong',
      ));
    }
  }
}
