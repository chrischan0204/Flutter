import '/common_libraries.dart';
import 'widgets/widgets.dart';

class UpdateNotificationForUserView extends StatefulWidget {
  final String userId;
  const UpdateNotificationForUserView({
    super.key,
    required this.userId,
  });

  @override
  State<UpdateNotificationForUserView> createState() =>
      _UpdateNotificationForUserViewState();
}

class _UpdateNotificationForUserViewState
    extends State<UpdateNotificationForUserView> {
  late NotificationSettingBloc _notificationSettingBloc;

  @override
  void initState() {
    _notificationSettingBloc = context.read()
      ..add(
          NotificationSettingUserSiteNotificationLoaded(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationSettingBloc, NotificationSettingState>(
        listener: (context, state) {
          if (state.siteNotificationUpdateStatus.isSuccess) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification();
            _notificationSettingBloc.add(
                NotificationSettingUserSiteNotificationLoaded(
                    userId: widget.userId));
          } else if (state.siteNotificationUpdateStatus.isFailure) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        },
        listenWhen: (previous, current) =>
            previous.siteNotificationUpdateStatus !=
            current.siteNotificationUpdateStatus,
        builder: (context, state) {
          return state.userSiteNotification.data.sites.isNotEmpty
              ? NotificationListView(userId: widget.userId)
              : const EmptyMessageView();
        });
  }
}
