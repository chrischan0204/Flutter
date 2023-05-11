import '/common_libraries.dart';

class UserNotificationSettingView extends StatelessWidget {
  const UserNotificationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationSettingBloc, NotificationSettingState>(
        builder: (context, state) {
      var rows = state.userSiteNotificationList
          .map(
            (userSiteNotification) => DataRow(
              cells: [
                DataCell(CustomDataCell(data: userSiteNotification.siteName)),
                DataCell(CustomDataCell(data: userSiteNotification.goodCatch)),
                DataCell(CustomDataCell(data: userSiteNotification.nearMiss)),
                DataCell(CustomDataCell(data: userSiteNotification.safe)),
                DataCell(CustomDataCell(data: userSiteNotification.unsafe)),
              ],
            ),
          )
          .toList();
      var columns = const [
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
      return state.userSiteNotificationListLoadStatus == EntityStatus.loading
          ? const Padding(
              padding: EdgeInsets.only(top: 300),
              child: Center(child: Loader()),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                state.userSiteNotificationList.isNotEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'The user gets notifications for the following sites/ awareness categories.',
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
                                'This user does not get any notifications for any awareness categories.',
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
                                'Notifications can be set for the user by editing the user.',
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
