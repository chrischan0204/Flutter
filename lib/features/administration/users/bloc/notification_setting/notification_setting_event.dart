part of 'notification_setting_bloc.dart';

abstract class NotificationSettingEvent extends Equatable {
  const NotificationSettingEvent();

  @override
  List<Object> get props => [];
}

class NotificationSettingNotificationListLoaded
    extends NotificationSettingEvent {
  final String userId;

  const NotificationSettingNotificationListLoaded({required this.userId});

  @override
  List<Object> get props => [userId];
}

class NotificationSettingNotificationUpdated extends NotificationSettingEvent {
  final UserSiteNotification userSiteNotification;
  const NotificationSettingNotificationUpdated({
    required this.userSiteNotification,
  });

  @override
  List<Object> get props => [userSiteNotification];
}
