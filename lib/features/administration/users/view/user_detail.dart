import '/common_libraries.dart';

class UserDetailView extends StatefulWidget {
  final String userId;
  const UserDetailView({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) => setState(() => token = state.token),
      listenWhen: (previous, current) => previous.token != current.token,
      builder: (context, state) {
        token = state.token;
        return RepositoryProvider(
          create: (context) => UsersRepository(token: token),
          child: BlocProvider(
            create: (context) =>
                UserDetailBloc(usersRepository: RepositoryProvider.of(context)),
            child: UserDetailWidget(userId: widget.userId),
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
  State<UserDetailWidget> createState() => _UserDetailWidgetState();
}

class _UserDetailWidgetState extends State<UserDetailWidget> {
  late UserDetailBloc usersBloc;

  static String pageTitle = 'User';
  static String pageLabel = 'user';
  static String descriptionForDelete =
      'This item can not be deleted as it has sites assigned to it.';

  @override
  void initState() {
    usersBloc = context.read<UserDetailBloc>()
      ..add(UserDetailUserLoadedById(userId: widget.userId))
      ..add(UserDetailAssignedUserSiteListLoaded(userId: widget.userId));
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
          deletable: state.deletable,
          descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }

  Map<String, Widget> _buildTabs(UserDetailState state) {
    return {
      'User Details': Container(),
      'Site Access': _buildAssignedUserSiteList(state),
      'Notifications': Container(),
      'Invite Details': Container(),
      '': Container(),
    };
  }

  Widget _buildAssignedUserSiteList(UserDetailState state) {
    var rows = state.userSiteAssignmentList
        .map(
          (userSite) => DataRow(
            cells: userSite
                .tableItemsToMap()
                .values
                .map(
                  (detail) => DataCell(
                    CustomDataCell(data: detail),
                  ),
                )
                .toList(),
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
          'Access granted by',
        ),
      ),
      DataColumn(
        label: Text(
          'Access granted on',
        ),
      ),
    ];
    return state.userSiteAssignmentListLoadStatus == EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: Center(child: Loader()),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.userSiteAssignmentList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '${state.user?.name ?? ''} has access to the following sites. Site access can be changed by editing this user',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Container(),
              state.userSiteAssignmentList.isNotEmpty
                  ? const CustomDivider()
                  : Container(),
              Container(
                child: state.userSiteAssignmentList.isNotEmpty
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
  }

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
