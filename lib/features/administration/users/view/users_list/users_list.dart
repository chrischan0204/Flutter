import '/common_libraries.dart';
import 'widgets/users_list_filter_setting.dart';
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
      listener: (context, state) => token = state.authUser?.token ?? '',
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
                create: (context) => SettingsRepository(
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
                  create: (context) => UserListViewSettingBloc(
                      settingsRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => UserListFilterSettingBloc(
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
    userListBloc = context.read<UserListBloc>()..add(UserListLoaded());
    userDetailBloc = context.read<UserDetailBloc>();
    userListViewSettingBloc = context.read();
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    regionsBloc = context.read<RegionsBloc>()..add(AssignedRegionsRetrieved());
    rolesBloc = context.read<RolesBloc>()..add(RolesRetrieved());
    timeZonesBloc = context.read()..add(TimeZoneListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, userListState) {
        return BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, userDetailState) {
            return EntityListTemplate(
              title: pageTitle,
              label: pageLabel,
              entities: userListState.userList,
              columns: const ['First Name', 'Last Name', 'Title', 'Role'],
              showTableHeaderButtons: true,
              onRowClick: (selectedUser) => _selectUser(selectedUser),
              emptyMessage: emptyMessage,
              entityRetrievedStatus: userListState.userListLoadStatus,
              selectedEntity: userDetailState.user,
              onTableSorted: (sortedUsers) => _sortUsers(sortedUsers),
              // onFilterApplied: () => _onFilterApplied(),
              // clearFilter: () => _clearFilter(),
              // filterResultBody: _buildFilterResultBody(),
              // filterApplied: filterApplied,
              filterBody: const UserListFilterSettingView(),
              viewSettingBody: const UserListViewSettingView(),
              onViewSettingApplied: () => userListViewSettingBloc
                  .add(const UserListViewSettingApplied(viewName: 'user')),
              onViewSettingSliderOpened: () => userListViewSettingBloc
                  .add(const UserListViewSettingLoaded(viewName: 'user')),
              newIconData: PhosphorIcons.userPlus,
            );
          },
        );
      },
    );
  }

  void _clearFilter() {
    setState(() {
      filterApplied = false;
      filterSites = [];
      filterRoles = [];
      filterActive = true;
      filterNameHasController.text = '';
    });
  }

  void _onFilterApplied() {
    setState(() {
      filterApplied = true;
    });
  }

  Column _buildFilterBody() {
    return Column(
      children: [
        _buildFilterUserNameTextField(),
        _buildFilterRoleMultiSelectField(),
        _buildFilterTitleTextField(),
        _buildFilterSiteMultiSelectField(),
        _buildFilterActiveSwitch(),
      ],
    );
  }

  DetailItem _buildFilterUserNameTextField() {
    return DetailItem(
      label: 'Name has',
      content: CustomTextField(
        controller: filterNameHasController,
        hintText: 'User Name contains...',
        onChanged: (nameHas) {},
      ),
    );
  }

  DetailItem _buildFilterTitleTextField() {
    return DetailItem(
      label: 'Title',
      content: CustomTextField(
        controller: filterTitleController,
        hintText: 'User Title contains...',
        onChanged: (nameHas) {},
      ),
    );
  }

  DetailItem _buildFilterActiveSwitch() {
    return DetailItem(
      label: 'Active',
      content: CustomSwitch(
        switchValue: filterActive,
        trueString: 'Yes',
        falseString: 'No',
        textColor: darkTeal,
        onChanged: (value) {
          setState(() {
            filterActive = value;
          });
        },
      ),
    );
  }

  DetailItem _buildFilterSiteMultiSelectField() {
    return DetailItem(
      label: 'Site',
      content: BlocBuilder<SitesBloc, SitesState>(
        builder: (context, userListState) {
          return CustomMultiSelect(
            items: <String, Site>{}..addEntries(
                userListState.sites.map(
                  (site) => MapEntry(site.name!, site),
                ),
              ),
            selectedItems: filterSites,
            hint: 'Associated with sites',
            onChanged: (sites) {
              filterSites = sites.map((site) => site as Site).toList();
            },
          );
        },
      ),
    );
  }

  DetailItem _buildFilterRoleMultiSelectField() {
    return DetailItem(
      label: 'Role',
      content: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, userListState) {
          return CustomMultiSelect(
            items: <String, Entity>{}..addEntries(
                userListState.roles.map(
                  (role) => MapEntry(
                      role.name,
                      Entity(
                        id: role.id,
                        name: role.name,
                      )),
                ),
              ),
            selectedItems: filterRoles
                .map((filterRole) => Entity(
                      id: filterRole.id,
                      name: filterRole.name,
                    ))
                .toList(),
            hint: 'Select role',
            onChanged: (roles) {
              filterRoles = roles
                  .map((role) => Role(
                        id: role.id ?? '',
                        name: role.name ?? '',
                      ))
                  .toList();
            },
          );
        },
      ),
    );
  }

  void _selectUser(Entity selectedUser) {
    userDetailBloc.add(UserDetailUserLoadedById(userId: selectedUser.id!));
  }

  Wrap _buildFilterResultBody() {
    return Wrap(
      children: [
        FilterItem(
          label: 'Name has:',
          content: filterNameHasController.text,
        ),
        FilterItem(
          label: 'Role:',
          content: filterRoles.map((role) => role.name).join(', '),
        ),
        FilterItem(
          label: 'Title:',
          content: filterTitleController.text,
        ),
        FilterItem(
          label: 'Site:',
          content: filterSites.map((site) => site.name ?? '').join(', '),
        ),
        FilterItem(
          label: 'Active:',
          content: filterActive ? 'Yes' : 'No',
        ),
      ],
    );
  }

  void _sortUsers(List<Entity> sortedUsers) {
    userListBloc.add(UserListSorted(
        sortedUserList:
            sortedUsers.map((sortedUser) => sortedUser as User).toList()));
  }
}
