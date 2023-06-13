import '/common_libraries.dart';

class UserSiteAccessView extends StatefulWidget {
  final String username;
  const UserSiteAccessView({
    super.key,
    required this.username,
  });

  @override
  State<UserSiteAccessView> createState() => _UserSiteAccessViewState();
}

class _UserSiteAccessViewState extends State<UserSiteAccessView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignSiteToUserBloc, AssignSiteToUserState>(
        builder: (context, state) {
      var rows = state.assignedUserSiteList
          .map(
            (userSite) => [
              RichText(
                text: TextSpan(
                  text: userSite.siteName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: textColor,
                  ),
                  children: [
                    TextSpan(
                      text: userSite.isDefault ? ' (default)' : '',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color:
                              Color.fromARGB((0.75 * 255).toInt(), 31, 41, 55)),
                    )
                  ],
                ),
              ),
              CustomDataCell(data: userSite.createdByUserName),
              CustomDataCell(data: userSite.createdOn),
            ],
          )
          .toList();
      var columns = const [
        'Site Name',
        'Access granted by',
        'Access granted on'
      ];
      return state.assignedUserSiteListLoadStatus == EntityStatus.loading
          ? const Padding(
              padding: EdgeInsets.only(top: 300),
              child: Center(child: Loader()),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                state.assignedUserSiteList.isNotEmpty
                    ? Padding(
                        padding: insetx20,
                        child: Text(
                          '${widget.username} has access to the following sites. Site access can be changed by editing this user',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : Container(),
                state.assignedUserSiteList.isNotEmpty
                    ? const CustomDivider()
                    : Container(),
                Container(
                  child: state.assignedUserSiteList.isNotEmpty
                      ? TableView(
                          height: MediaQuery.of(context).size.height - 360,
                          columns: columns,
                          rows: rows,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: insetx20,
                              child: const Text(
                                'This user has no sites assigned to it yet.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const CustomDivider(),
                            Padding(
                              padding: insetx20,
                              child: const Text(
                                'Sites can be assigned by editing the user and going to the sites tab to select from available users',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const CustomDivider(),
                          ],
                        ),
                ),
              ],
            );
    });
  }
}
