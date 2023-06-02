part of 'notification_setting_bloc.dart';

abstract class NotificationSettingEvent extends Equatable {
  const NotificationSettingEvent();

  @override
  List<Object> get props => [];
}

class NotificationSettingUserSiteNotificationLoaded
    extends NotificationSettingEvent {
  final String userId;

  const NotificationSettingUserSiteNotificationLoaded({required this.userId});

  @override
  List<Object> get props => [userId];
}

class NotificationSettingNotificationUpdated extends NotificationSettingEvent {
  final UserSiteNotificationSetting userSiteNotificationSetting;
  const NotificationSettingNotificationUpdated({
    required this.userSiteNotificationSetting,
  });

  @override
  List<Object> get props => [userSiteNotificationSetting];
}

class NotificationSettingAllChanged extends NotificationSettingEvent {
  final bool all;
  final String userSiteNotificationId;
  const NotificationSettingAllChanged({
    required this.all,
    required this.userSiteNotificationId,
  });

  @override
  List<Object> get props => [
        userSiteNotificationId,
        all,
      ];
}

class NotificationSettingGoodCatchChanged extends NotificationSettingEvent {
  final bool goodCatch;
  final String userSiteNotificationId;
  const NotificationSettingGoodCatchChanged({
    required this.goodCatch,
    required this.userSiteNotificationId,
  });

  @override
  List<Object> get props => [
        userSiteNotificationId,
        goodCatch,
      ];
}

class NotificationSettingNearMissChanged extends NotificationSettingEvent {
  final bool nearMiss;
  final String userSiteNotificationId;
  const NotificationSettingNearMissChanged({
    required this.nearMiss,
    required this.userSiteNotificationId,
  });

  @override
  List<Object> get props => [
        userSiteNotificationId,
        nearMiss,
      ];
}

class NotificationSettingSafeChanged extends NotificationSettingEvent {
  final bool safe;
  final String userSiteNotificationId;
  const NotificationSettingSafeChanged({
    required this.safe,
    required this.userSiteNotificationId,
  });

  @override
  List<Object> get props => [
        userSiteNotificationId,
        safe,
      ];
}

class NotificationSettingUnsafeChanged extends NotificationSettingEvent {
  final bool unsafe;
  final String userSiteNotificationId;
  const NotificationSettingUnsafeChanged({
    required this.unsafe,
    required this.userSiteNotificationId,
  });

  @override
  List<Object> get props => [
        userSiteNotificationId,
        unsafe,
      ];
}
