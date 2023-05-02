// ignore_for_file: public_member_api_docs, sort_constructors_first
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
