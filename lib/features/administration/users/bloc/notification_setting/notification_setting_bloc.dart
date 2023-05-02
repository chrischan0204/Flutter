import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

part 'notification_setting_event.dart';
part 'notification_setting_state.dart';

class NotificationSettingBloc
    extends Bloc<NotificationSettingEvent, NotificationSettingState> {
  final UsersRepository usersRepository;
  NotificationSettingBloc({required this.usersRepository})
      : super(const NotificationSettingState()) {
    on<NotificationSettingNotificationListLoaded>(
        _onNotificationSettingNotificationListLoaded);
    on<NotificationSettingNotificationUpdated>(
        _onNotificationSettingNotificationUpdated);
  }

  Future<void> _onNotificationSettingNotificationListLoaded(
    NotificationSettingNotificationListLoaded event,
    Emitter<NotificationSettingState> emit,
  ) async {
    emit(state.copyWith(
        userSiteNotificationListLoadStatus: EntityStatus.loading));
    try {
      List<UserSiteNotification> userSiteNotificationList =
          await usersRepository
              .getSiteNotificationSettingsByUserId(event.userId);
      emit(state.copyWith(
        userSiteNotificationListLoadStatus: EntityStatus.success,
        userSiteNotificationList: userSiteNotificationList,
      ));
    } catch (e) {
      emit(state.copyWith(
          userSiteNotificationListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onNotificationSettingNotificationUpdated(
    NotificationSettingNotificationUpdated event,
    Emitter<NotificationSettingState> emit,
  ) async {
    emit(state.copyWith(siteNotificationUpdateStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository
          .updateUserSiteNotificationSetting(event.userSiteNotification);
      emit(state.copyWith(
        siteNotificationUpdateStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(siteNotificationUpdateStatus: EntityStatus.failure));
    }
  }
}
