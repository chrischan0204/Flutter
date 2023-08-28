part of 'notification_setting_bloc.dart';

abstract class NotificationSettingEvent extends Equatable {
  const NotificationSettingEvent();

  @override
  List<Object> get props => [];
}

/// event to load site notification list for user
class NotificationSettingUserSiteNotificationLoaded
    extends NotificationSettingEvent {
  final String userId;

  const NotificationSettingUserSiteNotificationLoaded({required this.userId});

  @override
  List<Object> get props => [userId];
}

/// event to update notifation
class NotificationSettingNotificationUpdated extends NotificationSettingEvent {
  final UserSiteNotificationSetting userSiteNotificationSetting;
  const NotificationSettingNotificationUpdated({
    required this.userSiteNotificationSetting,
  });

  @override
  List<Object> get props => [userSiteNotificationSetting];
}

/// event to change all notification
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

/// event to change observation type notification
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
