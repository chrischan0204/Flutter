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
            notificationSettingBloc.add(
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
          var rows = state.userSiteNotification.data.sites
              .map(
                (site) => DataRow(cells: [
                  // DataCell(Checkbox(
                  //   value: site.,
                  //   onChanged: (all) {
                  //   //   notificationSettingBloc
                  //   //     .add(NotificationSettingAllChanged(
                  //   //   all: all!,
                  //   //   userSiteNotificationId: site.observationTypes,
                  //   // ));
                  //   },
                  // )),
                  // DataCell(
                  //   CustomDataCell(data: site.siteName),
                  // ),
                  // DataCell(Checkbox(
                  //   value: site.goodCatch,
                  //   onChanged: (goodCatch) => notificationSettingBloc
                  //       .add(NotificationSettingGoodCatchChanged(
                  //     goodCatch: goodCatch!,
                  //     userSiteNotificationId: site.id,
                  //   )),
                  // )),
                  // DataCell(Checkbox(
                  //   value: site.nearMiss,
                  //   onChanged: (nearMiss) => notificationSettingBloc
                  //       .add(NotificationSettingNearMissChanged(
                  //     nearMiss: nearMiss!,
                  //     userSiteNotificationId: site.id,
                  //   )),
                  // )),
                  // DataCell(Checkbox(
                  //   value: site.safe,
                  //   onChanged: (safe) => notificationSettingBloc
                  //       .add(NotificationSettingSafeChanged(
                  //     safe: safe!,
                  //     userSiteNotificationId: site.id,
                  //   )),
                  // )),
                  // DataCell(Checkbox(
                  //   value: site.unsafe,
                  //   onChanged: (unsafe) => notificationSettingBloc
                  //       .add(NotificationSettingUnsafeChanged(
                  //     unsafe: unsafe!,
                  //     userSiteNotificationId: userSiteNotification.id,
                  //   )),
                  // )),
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.userSiteNotification.data.sites.isNotEmpty
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
              state.userSiteNotification.data.sites.isNotEmpty
                  ? const CustomDivider()
                  : Container(),
              Container(
                child: state.userSiteNotification.data.sites.isNotEmpty
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
