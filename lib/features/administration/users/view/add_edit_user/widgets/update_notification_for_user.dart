import '/common_libraries.dart';

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
  late NotificationSettingBloc notificationSettingBloc;

  @override
  void initState() {
    notificationSettingBloc = context.read()
      ..add(NotificationSettingNotificationListLoaded(userId: widget.userId));
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
            notificationSettingBloc.add(
                NotificationSettingNotificationListLoaded(
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
          var rows = state.userSiteNotificationList
              .map(
                (userSiteNotification) => DataRow(cells: [
                  DataCell(Checkbox(
                    value: userSiteNotification.all,
                    onChanged: (all) => notificationSettingBloc
                        .add(NotificationSettingAllChanged(
                      all: all!,
                      userSiteNotificationId: userSiteNotification.id,
                    )),
                  )),
                  DataCell(
                    CustomDataCell(data: userSiteNotification.siteName),
                  ),
                  DataCell(Checkbox(
                    value: userSiteNotification.goodCatch,
                    onChanged: (goodCatch) => notificationSettingBloc
                        .add(NotificationSettingGoodCatchChanged(
                      goodCatch: goodCatch!,
                      userSiteNotificationId: userSiteNotification.id,
                    )),
                  )),
                  DataCell(Checkbox(
                    value: userSiteNotification.nearMiss,
                    onChanged: (nearMiss) => notificationSettingBloc
                        .add(NotificationSettingNearMissChanged(
                      nearMiss: nearMiss!,
                      userSiteNotificationId: userSiteNotification.id,
                    )),
                  )),
                  DataCell(Checkbox(
                    value: userSiteNotification.safe,
                    onChanged: (safe) => notificationSettingBloc
                        .add(NotificationSettingSafeChanged(
                      safe: safe!,
                      userSiteNotificationId: userSiteNotification.id,
                    )),
                  )),
                  DataCell(Checkbox(
                    value: userSiteNotification.unsafe,
                    onChanged: (unsafe) => notificationSettingBloc
                        .add(NotificationSettingUnsafeChanged(
                      unsafe: unsafe!,
                      userSiteNotificationId: userSiteNotification.id,
                    )),
                  )),
                ]),
              )
              .toList();
          var columns = const [
            DataColumn(
              label: Text(
                'All',
              ),
            ),
            DataColumn(
              label: Text(
                'Site Name',
              ),
            ),
            DataColumn(
              label: Text(
                'Good Catch',
              ),
            ),
            DataColumn(
              label: Text(
                'Near Miss',
              ),
            ),
            DataColumn(
              label: Text(
                'Safe',
              ),
            ),
            DataColumn(
              label: Text(
                'Unsafe',
              ),
            ),
          ];
          return
              // state.userSiteNotificationListLoadStatus ==
              //         EntityStatus.loading
              //     ? const Padding(
              //         padding: EdgeInsets.only(top: 300),
              //         child: Center(child: Loader()),
              //       )
              //     :
              Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.userSiteNotificationList.isNotEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Mark all Awareness categories for sites where the notification should be routed to this user.',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Container(),
              state.userSiteNotificationList.isNotEmpty
                  ? const CustomDivider()
                  : Container(),
              Container(
                child: state.userSiteNotificationList.isNotEmpty
                    ? TableView(
                        height: MediaQuery.of(context).size.height - 337,
                        columns: columns,
                        rows: rows,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'This user has no sites assigned to it yet.',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomDivider(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Sites can be assigned by editing the user and going to the sites tab to select from available users',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomDivider(),
                        ],
                      ),
              ),
            ],
          );
        });
  }
}
