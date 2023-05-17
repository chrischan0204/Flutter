import '/common_libraries.dart';
import 'widgets/users_list_view_setting.dart';

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
            RepositoryProvider(
                create: (context) => SettingsRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
            RepositoryProvider(
                create: (context) => SitesRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
            RepositoryProvider(
                create: (context) => RegionsRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
            RepositoryProvider(
                create: (context) => RolesRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
            RepositoryProvider(
                create: (context) => TimeZonesRepository(
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
              BlocProvider(
                  create: (context) => FilterSettingBloc(
                      settingsRepository:
                          RepositoryProvider.of<SettingsRepository>(context))),
              BlocProvider(
                  create: (context) => UserListViewSettingBloc(
                      settingsRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => SitesBloc(
                      sitesRepository:
                          RepositoryProvider.of<SitesRepository>(context))),
              BlocProvider(
                  create: (context) => RegionsBloc(
                      regionsRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => RolesBloc(
                      rolesRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => TimeZonesBloc(
                      timeZonesRepository: RepositoryProvider.of(context))),
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
  late FilterSettingBloc filterSettingBloc;
  late UserListViewSettingBloc userListViewSettingBloc;
  late SitesBloc sitesBloc;
  late RegionsBloc regionsBloc;
  late RolesBloc rolesBloc;
  late TimeZonesBloc timeZonesBloc;

  bool filterApplied = false;

  List<Site> filterSites = [];
  List<Role> filterRoles = [];
  bool filterActive = true;

  TextEditingController filterNameHasController =
      TextEditingController(text: '');
  TextEditingController filterTitleController = TextEditingController(text: '');

  static String pageTitle = 'Users';
  static String pageLabel = 'user';
  static String emptyMessage =
      'There are no users. Please click on New User to add new user';

  @override
  void initState() {
    userListBloc = context.read<UserListBloc>();
    filterSettingBloc = context.read()
      ..add(const FilterSettingUserFilterSettingListLoaded(name: 'user'));
    userDetailBloc = context.read<UserDetailBloc>();
    userListViewSettingBloc = context.read();
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    regionsBloc = context.read<RegionsBloc>()..add(AssignedRegionsRetrieved());
    rolesBloc = context.read<RolesBloc>()..add(RolesRetrieved());
    timeZonesBloc = context.read()..add(TimeZoneListLoaded());

    // if (filterSettingBloc.state.selectedUserFilterSetting != null &&
    //     filterSettingBloc.state.selectedUserFilterSetting!.id.isNotEmpty) {
    //   userListBloc.add(UserListFiltered(
    //     filterId: filterSettingBloc.state.selectedUserFilterSetting!.id,
    //     includeDeleted: filterSettingBloc.state.includeDeleted,
    //   ));
    // } else {
    //   userListBloc.add(UserListLoaded());
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterSettingBloc, FilterSettingState>(
        listener: (context, state) {
          if (state.selectedUserFilterSetting!.id.isNotEmpty) {
            userListBloc.add(UserListFiltered(
              filterId: state.selectedUserFilterSetting!.id,
              includeDeleted: state.includeDeleted,
            ));
          } else {
            userListBloc.add(UserListLoaded());
          }
        },
        listenWhen: (previous, current) =>
            previous.selectedUserFilterSetting !=
            current.selectedUserFilterSetting,
        builder: (context, state) {
          return BlocBuilder<UserListBloc, UserListState>(
            builder: (context, userListState) {
              return BlocBuilder<UserDetailBloc, UserDetailState>(
                builder: (context, userDetailState) {
                  return BlocListener<UserListViewSettingBloc,
                      UserListViewSettingState>(
                    listener: (context, viewSettingState) {
                      userListBloc.add(UserListFiltered(
                          filterId: state.selectedUserFilterSetting!.id));
                    },
                    listenWhen: (previous, current) =>
                        previous.viewSettingSaveStatus !=
                        current.viewSettingSaveStatus,
                    child: EntityListTemplate(
                      title: pageTitle,
                      label: pageLabel,
                      entities: userListState.userList,
                      showTableHeaderButtons: true,
                      onRowClick: (selectedUser) => _selectUser(selectedUser),
                      emptyMessage: emptyMessage,
                      entityRetrievedStatus: userListState.userListLoadStatus,
                      selectedEntity: userDetailState.user,
                      onTableSorted: (sortedUsers) => _sortUsers(sortedUsers),
                      viewSettingBody: const UserListViewSettingView(),
                      onViewSettingApplied: () {
                        userListViewSettingBloc.add(
                            const UserListViewSettingApplied(viewName: 'user'));
                        userListBloc.add(UserListFiltered(
                          filterId: state.selectedUserFilterSetting!.id,
                          includeDeleted: state.includeDeleted,
                        ));
                      },
                      onIncludeDeletedChanged: (value) {
                        filterSettingBloc.add(
                            FilterSettingIncludeDeletedChanged(
                                includeDeleted: value));
                        userListBloc.add(UserListFiltered(
                          filterId: state.selectedUserFilterSetting!.id,
                          includeDeleted: value,
                        ));
                      },
                      onViewSettingSliderOpened: () => userListViewSettingBloc
                          .add(const UserListViewSettingLoaded(
                              viewName: 'user')),
                      onFilterSaved: (filterId) =>
                          userListBloc.add(UserListFiltered(
                        filterId: filterId,
                        includeDeleted: state.includeDeleted,
                      )),
                      onFilterApplied: () => userListBloc.add(UserListFiltered(
                          filterId: state.selectedUserFilterSetting!.id)),
                      newIconData: PhosphorIcons.userPlus,
                    ),
                  );
                },
              );
            },
          );
        });
  }

  void _selectUser(Entity selectedUser) {
    userDetailBloc.add(UserDetailUserLoadedById(userId: selectedUser.id!));
  }

  void _sortUsers(List<Entity> sortedUsers) {
    userListBloc.add(UserListSorted(
        sortedUserList:
            sortedUsers.map((sortedUser) => sortedUser as User).toList()));
  }
}
