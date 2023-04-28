import '/common_libraries.dart';

class UserDetailView extends StatelessWidget {
  final String userId;
  const UserDetailView({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String token = state.token;
        return RepositoryProvider(
          create: (context) => UsersRepository(token: token),
          child: BlocProvider(
            create: (context) =>
                UserDetailBloc(usersRepository: RepositoryProvider.of(context)),
            child: UserDetailWidget(userId: userId),
          ),
        );
      },
    );
  }
}

class UserDetailWidget extends StatefulWidget {
  final String userId;
  const UserDetailWidget({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailWidget> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailWidget> {
  late UserDetailBloc usersBloc;

  static String pageTitle = 'User';
  static String pageLabel = 'user';
  static String descriptionForDelete =
      'This item can not be deleted as it has sites assigned to it.';

  @override
  void initState() {
    usersBloc = context.read<UserDetailBloc>()
      ..add(UserDetailUserLoadedById(userId: widget.userId));
    super.initState();
  }

  _deleteUser(UserDetailState state) {
    usersBloc.add(UserDetailUserDeleted(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDetailBloc, UserDetailState>(
      listener: (context, state) => _checkDeleteUserStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => _deleteUser(state),
          tabItems: _buildTabs(state),
          entity: state.user,
          crudStatus: state.userDeleteStatus,
          // deletable: state.deletable,
          descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }

  Map<String, Widget> _buildTabs(UserDetailState state) {
    return {
      'User Details': Container(),
      'Site Access': Container(),
      'Notifications': Container(),
      'Invite Details': Container(),
      '': Container(),
    };
  }

  // Widget _buildAssociatedSites(UserDetailState state) {
  //   var rows = state.assignedUserSites
  //       .map(
  //         (userSite) => DataRow(
  //           cells: userSite
  //               .toTableDetailMap()
  //               .values
  //               .map(
  //                 (detail) => DataCell(
  //                   CustomDataCell(data: detail),
  //                 ),
  //               )
  //               .toList(),
  //         ),
  //       )
  //       .toList();
  //   var columns = const [
  //     DataColumn(
  //       label: Text(
  //         'Site',
  //       ),
  //     ),
  //     DataColumn(
  //       label: Text(
  //         'Added By',
  //       ),
  //     ),
  //     DataColumn(
  //       label: Text(
  //         'Added on',
  //       ),
  //     ),
  //   ];
  //   return state.assignedUserSitesRetrievedStatus == EntityStatus.loading
  //       ? const Padding(
  //           padding: EdgeInsets.only(top: 300),
  //           child: Center(child: Loader()),
  //         )
  //       : Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             state.assignedUserSites.isNotEmpty
  //                 ? const Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 20.0),
  //                     child: Text(
  //                       'The following sites are associated with this project. Edit user to associate/ remove sites from this user',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         fontFamily: 'OpenSans',
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   )
  //                 : Container(),
  //             state.assignedUserSites.isNotEmpty
  //                 ? const CustomDivider()
  //                 : Container(),
  //             Container(
  //               child: state.assignedUserSites.isNotEmpty
  //                   ? TableView(
  //                       height: MediaQuery.of(context).size.height - 337,
  //                       columns: columns,
  //                       rows: rows,
  //                     )
  //                   : Column(
  //                       crossAxisAlignment: CrossAxisAlignment.stretch,
  //                       children: const [
  //                         Padding(
  //                           padding: EdgeInsets.symmetric(horizontal: 20.0),
  //                           child: Text(
  //                             'This user has no sites assigned to it yet.',
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               fontFamily: 'OpenSans',
  //                               fontWeight: FontWeight.w400,
  //                             ),
  //                           ),
  //                         ),
  //                         CustomDivider(),
  //                         Padding(
  //                           padding: EdgeInsets.symmetric(horizontal: 20.0),
  //                           child: Text(
  //                             'Sites can be assigned by editing the user and going to the sites tab to select from available users',
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.w400,
  //                             ),
  //                           ),
  //                         ),
  //                         CustomDivider(),
  //                       ],
  //                     ),
  //             ),
  //           ],
  //         );
  // }

  void _checkDeleteUserStatus(UserDetailState state, BuildContext context) {
    if (state.userDeleteStatus.isSuccess) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/users');
    }
    if (state.userDeleteStatus.isFailure) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
