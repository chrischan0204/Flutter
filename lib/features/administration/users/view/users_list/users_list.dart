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
        return MultiBlocProvider(
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
                viewName: pageLabel,
                entities: userListState.userList,
                showTableHeaderButtons: true,
                onRowClick: (selectedUser) => _selectUser(selectedUser),
                emptyMessage: emptyMessage,
                entityListLoadStatusLoading:
                    filterSettingState.filterSettingLoading ||
                        userListState.userListLoadStatus.isLoading,
                entityDetailLoadStatusLoading:
                    userDetailState.userLoadStatus.isLoading,
                selectedEntity: userDetailState.user,
                onTableSorted: (sortedUsers) => _sortUsers(sortedUsers),
                onViewSettingApplied: () {
                  _filterUsers();
                },
                onIncludeDeletedChanged: (value) {
                  _filterUsers(null, value, 1);
                },
                onFilterSaved: (value) {
                  _filterUsers(value, null, 1);
                },
                onFilterApplied: ([value, withoutSave]) {
                  _filterUsers(value, null, 1, null, withoutSave);
                },
                onPaginate: (pageNum, pageRow) {
                  _filterUsers(null, null, pageNum, pageRow);
                },
                totalRows: userListState.totalRows,
                newIconData: PhosphorIcons.regular.userPlus,
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
    int? pageNum,
    int? rowPerPage,
    bool? withoutSave,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    final PaginationBloc paginationBloc = context.read();
    userListBloc.add(UserListFiltered(
        option: FilteredTableParameter(
      filterId: filterId ??
          filterSettingBloc.state.appliedUserFilterSetting?.id ??
          emptyGuid,
      includeDeleted: includeDeleted ?? filterSettingBloc.state.includeDeleted,
      pageNum: pageNum ?? paginationBloc.state.selectedPageNum,
      pageSize: rowPerPage ?? paginationBloc.state.rowsPerPage,
      filterOption: filterSettingBloc.state.appliedUserFilterSetting != null
          ? filterSettingBloc.state.userFilterUpdate
          : null,
    )));
  }
}
