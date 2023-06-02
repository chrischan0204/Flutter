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

class NotificationObservationTypeNotificationAllChanged
    extends NotificationSettingEvent {
  final UserSiteNotificationSetting userSiteNotificationSetting;
  final bool sendNotification;
  const NotificationObservationTypeNotificationAllChanged({
    required this.userSiteNotificationSetting,
    required this.sendNotification,
  });

  @override
  List<Object> get props => [
        userSiteNotificationSetting,
        sendNotification,
      ];
}

class NotificationObservationTypeNotificationChanged
    extends NotificationSettingEvent {
  final UserSiteNotificationSetting userSiteNotificationSetting;
  final String observationTypeId;
  final bool sendNotification;
  const NotificationObservationTypeNotificationChanged({
    required this.userSiteNotificationSetting,
    required this.observationTypeId,
    required this.sendNotification,
  });

  @override
  List<Object> get props => [
        userSiteNotificationSetting,
        observationTypeId,
        sendNotification,
      ];
}
