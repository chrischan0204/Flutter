import '/common_libraries.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => UsersRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => UserListBloc(
                      usersRepository:
                          RepositoryProvider.of<UsersRepository>(context))),
              BlocProvider(
                  create: (context) => UserDetailBloc(
                      usersRepository:
                          RepositoryProvider.of<UsersRepository>(context))),
            ],
            child: const UsersListWidget(),
          ),
        );
      },
    );
  }
}

class UsersListWidget extends StatefulWidget {
  const UsersListWidget({super.key});

  @override
  State<UsersListWidget> createState() => _UsersListState();
}

class _UsersListState extends State<UsersListWidget> {
  late UserListBloc userListBloc;
  late UserDetailBloc userDetailBloc;

  static String pageTitle = 'Users';
  static String pageLabel = 'user';
  static String emptyMessage =
      'There are no users. Please click on New User to add new user';

  @override
  void initState() {
    userListBloc = context.read<UserListBloc>();
    userDetailBloc = context.read<UserDetailBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, filterSettingState) =>
          BlocBuilder<UserListBloc, UserListState>(
        builder: (context, userListState) {
          return BlocBuilder<UserDetailBloc, UserDetailState>(
            builder: (context, userDetailState) {
              return EntityListTemplate(
                title: pageTitle,
                label: pageLabel,
                entities: userListState.userList,
                showTableHeaderButtons: true,
                onRowClick: (selectedUser) => _selectUser(selectedUser),
                emptyMessage: emptyMessage,
                entityListLoadStatusLoading:
                    filterSettingState.filterSettingLoading ||
                        userListState.userListLoadStatus.isLoading,
                selectedEntity: userDetailState.user,
                onTableSorted: (sortedUsers) => _sortUsers(sortedUsers),
                onViewSettingApplied: () => _filterUsers(),
                onIncludeDeletedChanged: (value) => _filterUsers(null, value),
                viewName: 'user',
                onFilterSaved: _filterUsers,
                onFilterApplied: _filterUsers,
                newIconData: PhosphorIcons.userPlus,
              );
            },
          );
        },
      ),
    );
  }

  void _selectUser(Entity selectedUser) {
    userDetailBloc.add(UserDetailUserLoadedById(userId: selectedUser.id!));
  }

  void _sortUsers(List<Entity> sortedUsers) {
    userListBloc.add(UserListSorted(
        sortedUserList:
            sortedUsers.map((sortedUser) => sortedUser as User).toList()));
  }

  void _filterUsers([
    String? filterId,
    bool? includeDeleted,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    userListBloc.add(UserListFiltered(
      filterId: filterId ??
          filterSettingBloc.state.appliedUserFilterSetting?.id ??
          '00000000-0000-0000-0000-000000000000',
      includeDeleted: includeDeleted ?? filterSettingBloc.state.includeDeleted,
    ));
  }
}
