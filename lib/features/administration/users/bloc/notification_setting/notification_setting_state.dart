// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_setting_bloc.dart';

class NotificationSettingState extends Equatable {
  final List<UserSiteNotification> userSiteNotificationList;
  final EntityStatus userSiteNotificationListLoadStatus;
  final EntityStatus siteNotificationUpdateStatus;
  final String message;
  const NotificationSettingState({
    this.userSiteNotificationList = const [],
    this.userSiteNotificationListLoadStatus = EntityStatus.initial,
    this.siteNotificationUpdateStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object> get props => [
        userSiteNotificationList,
        userSiteNotificationListLoadStatus,
        siteNotificationUpdateStatus,
        message,
      ];

  NotificationSettingState copyWith({
    List<UserSiteNotification>? userSiteNotificationList,
    EntityStatus? userSiteNotificationListLoadStatus,
    EntityStatus? siteNotificationUpdateStatus,
    String? message,
  }) {
    return NotificationSettingState(
      userSiteNotificationList:
          userSiteNotificationList ?? this.userSiteNotificationList,
      userSiteNotificationListLoadStatus: userSiteNotificationListLoadStatus ??
          this.userSiteNotificationListLoadStatus,
      siteNotificationUpdateStatus:
          siteNotificationUpdateStatus ?? this.siteNotificationUpdateStatus,
      message: message ?? this.message,
    );
  }
}
