part of 'notification_setting_bloc.dart';

class NotificationSettingState extends Equatable {
  final UserSiteNotification userSiteNotification;
  final EntityStatus userSiteNotificationLoadStatus;
  final EntityStatus siteNotificationUpdateStatus;
  final String message;
  const NotificationSettingState({
    this.userSiteNotification = const UserSiteNotification(),
    this.userSiteNotificationLoadStatus = EntityStatus.initial,
    this.siteNotificationUpdateStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object> get props => [
        userSiteNotification,
        userSiteNotificationLoadStatus,
        siteNotificationUpdateStatus,
        message,
      ];

  NotificationSettingState copyWith({
    UserSiteNotification? userSiteNotification,
    EntityStatus? userSiteNotificationLoadStatus,
    EntityStatus? siteNotificationUpdateStatus,
    String? message,
  }) {
    return NotificationSettingState(
      userSiteNotification: userSiteNotification ?? this.userSiteNotification,
      userSiteNotificationLoadStatus:
          userSiteNotificationLoadStatus ?? this.userSiteNotificationLoadStatus,
      siteNotificationUpdateStatus:
          siteNotificationUpdateStatus ?? this.siteNotificationUpdateStatus,
      message: message ?? this.message,
    );
  }
}
