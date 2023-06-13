import '/common_libraries.dart';

class NotificationListView extends StatefulWidget {
  final String userId;

  const NotificationListView({
    super.key,
    required this.userId,
  });

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  late NotificationSettingBloc _notificationSettingBloc;

  @override
  void initState() {
    _notificationSettingBloc = context.read();
    super.initState();
  }

  void _updateUserNotificationSetting({
    required String siteId,
    String? observationTypeId,
    required bool sendNotification,
    required List<UserObservationType> observationTypes,
    bool all = false,
  }) {
    if (all) {
      _notificationSettingBloc
          .add(NotificationObservationTypeNotificationAllChanged(
              sendNotification: sendNotification,
              userSiteNotificationSetting: UserSiteNotificationSetting(
                siteId: siteId,
                userId: widget.userId,
                observationTypes: observationTypes,
              )));
    } else {
      _notificationSettingBloc
          .add(NotificationObservationTypeNotificationChanged(
        userSiteNotificationSetting: UserSiteNotificationSetting(
          siteId: siteId,
          userId: widget.userId,
          observationTypes: observationTypes,
        ),
        sendNotification: sendNotification,
        observationTypeId: observationTypeId!,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Mark all Awareness categories for sites where the notification should be routed to this user.',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const CustomDivider(),
        BlocBuilder<NotificationSettingBloc, NotificationSettingState>(
          builder: (context, state) {
            var rows = state.userSiteNotification.data.sites
                .map(
                  (site) => [
                    Checkbox(
                      value: site.allSendNotification,
                      onChanged: (sendNotification) =>
                          _updateUserNotificationSetting(
                        siteId: site.siteId,
                        sendNotification: sendNotification!,
                        observationTypes: site.observationTypes,
                        all: true,
                      ),
                    ),
                    CustomDataCell(data: site.siteName),
                    ...site.observationTypes
                        .map((observationType) => Checkbox(
                              value: observationType.sendNotification,
                              onChanged: (sendNotification) =>
                                  _updateUserNotificationSetting(
                                siteId: site.siteId,
                                observationTypeId:
                                    observationType.observationTypeId,
                                sendNotification: sendNotification!,
                                observationTypes: site.observationTypes,
                              ),
                            ))
                        .toList()
                  ],
                )
                .toList();
            var columns = [
              'All',
              'Site Name',
              ...List.generate(
                  state.userSiteNotification.headers.length,
                  (index) => state
                      .userSiteNotification.headers[index].observationTypeName)
            ];
            return TableView(
              height: MediaQuery.of(context).size.height - 360,
              columns: columns,
              rows: rows,
            );
          },
        )
      ],
    );
  }
}
