import '/common_libraries.dart';

class UserNotificationSettingView extends StatelessWidget {
  const UserNotificationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationSettingBloc, NotificationSettingState>(
        builder: (context, state) {
      var rows = state.userSiteNotification.data.sites
          .map(
            (userSiteNotification) => DataRow(
              cells: [
                DataCell(CustomDataCell(data: userSiteNotification.siteName)),
                ...userSiteNotification.observationTypes
                    .map((observationType) => DataCell(
                        CustomDataCell(data: observationType.sendNotification)))
                    .toList()
              ],
            ),
          )
          .toList();
      var columns = [
        const DataColumn(
          label: Text(
            'Site Name',
          ),
        ),
        ...List.generate(
            state.userSiteNotification.headers.length,
            (index) => DataColumn(
                  label: Text(
                    state.userSiteNotification.headers[index]
                        .observationTypeName,
                  ),
                ))
      ];
      return state.userSiteNotificationLoadStatus == EntityStatus.loading
          ? const Padding(
              padding: EdgeInsets.only(top: 300),
              child: Center(child: Loader()),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                state.userSiteNotification.data.sites.isNotEmpty
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
