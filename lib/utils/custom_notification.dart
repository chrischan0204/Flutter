import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

enum NotifyType {
  success,
  info,
  error,
}

class CustomNotification {
  final BuildContext context;
  final NotifyType notifyType;
  final String? title;
  final String content;
  final double width;
  final int duration;
  CustomNotification({
    required this.context,
    required this.notifyType,
    this.title,
    required this.content,
    this.width = 400,
    this.duration = 5,
  });

  void showNotification() {
    switch (notifyType) {
      case NotifyType.success:
        ElegantNotification.success(
          width: width,
          notificationPosition: NotificationPosition.bottomRight,
          animation: AnimationType.fromRight,
          toastDuration: Duration(seconds: duration),
          title: title != null ? Text(title!) : null,
          description: Text(content),
          onDismiss: () {},
        ).show(context);
        break;
      case NotifyType.info:
        ElegantNotification.info(
          width: width,
          notificationPosition: NotificationPosition.bottomRight,
          animation: AnimationType.fromRight,
          toastDuration: Duration(seconds: duration),
          title: title != null ? Text(title!) : null,
          description: Text(content),
          onDismiss: () {},
        ).show(context);
        break;
      case NotifyType.error:
        ElegantNotification.error(
          width: width,
          notificationPosition: NotificationPosition.bottomRight,
          animation: AnimationType.fromRight,
          toastDuration: Duration(seconds: duration),
          title: title != null ? Text(title!) : null,
          description: Text(content),
          onDismiss: () {},
        ).show(context);
        break;
    }
  }
}
