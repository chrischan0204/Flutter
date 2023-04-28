import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/common_libraries.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  late UsersBloc usersBloc;
  late SitesBloc sitesBloc;
  late RegionsBloc regionsBloc;
  late RolesBloc rolesBloc;

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
    usersBloc = context.read<UsersBloc>()..add(UsersRetrieved());
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    regionsBloc = context.read<RegionsBloc>()..add(AssignedRegionsRetrieved());
    rolesBloc = context.read<RolesBloc>()..add(RolesRetrieved());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return EntityListTemplate(
          title: pageTitle,
          label: pageLabel,
          entities: state is UserListLoadSuccess ? state.users : [],
          showTableHeaderButtons: true,
          onRowClick: (selectedUser) => _selectUser(selectedUser),
          emptyMessage: emptyMessage,
          entityRetrievedStatus: state is UserListLoadInProgress
              ? EntityStatus.loading
              : state is UserListLoadFailure
                  ? EntityStatus.failure
                  : EntityStatus.success,
          onTableSort: (sortedUsers) => _sortUsers(sortedUsers),
          applyFilter: () => _applyFilter(),
          clearFilter: () => _clearFilter(),
          filterResultBody: _buildFilterResultBody(),
          filterApplied: filterApplied,
          filterBody: _buildFilterBody(),
          newIconData: PhosphorIcons.userPlus,
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

  void _applyFilter() {
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
        builder: (context, state) {
          return CustomMultiSelect(
            items: <String, Site>{}..addEntries(
                state.sites.map(
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
        builder: (context, state) {
          return CustomMultiSelect(
            items: <String, Entity>{}..addEntries(
                state.roles.map(
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
    usersBloc.add(UserSelectedById(userId: selectedUser.id!));
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
    usersBloc.add(UsersSorted(
        users: sortedUsers.map((sortedUser) => sortedUser as User).toList()));
  }
}
