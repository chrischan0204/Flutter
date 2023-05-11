import '/common_libraries.dart';

class AssignSitesToUserView extends StatefulWidget {
  final String userId;
  final String userName;
  final String? view;
  const AssignSitesToUserView({
    super.key,
    required this.userId,
    this.userName = '',
    this.view,
  });

  @override
  State<AssignSitesToUserView> createState() => _AssignSitesToUserViewState();
}

class _AssignSitesToUserViewState extends State<AssignSitesToUserView> {
  late AssignSiteToUserBloc addEditUserBloc;
  TextEditingController filterController = TextEditingController(text: '');

  @override
  void initState() {
    addEditUserBloc = context.read<AssignSiteToUserBloc>()
      ..add(AssignSiteToUserAssignedUserSiteListLoaded(userId: widget.userId))
      ..add(
          AssignSiteToUserUnassignedUserSiteListLoaded(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignSiteToUserBloc, AssignSiteToUserState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAssignedSitesView(state, context),
                  const SizedBox(
                    width: 150,
                  ),
                  _buildUnassignedSitesView(state)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Expanded _buildUnassignedSitesView(AssignSiteToUserState state) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sites can be assigned to this project by selecting from the list below.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomDivider(),
          _buildFilterTextField(state),
          const CustomDivider(),
          _buildUnassignedSitesTableView(state),
        ],
      ),
    );
  }

  Expanded _buildAssignedSitesView(
      AssignSiteToUserState state, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAssignedSitesTableViewHeader(state),
          const CustomDivider(),
          _buildAssignedSitesTableView(state, context),
        ],
      ),
    );
  }

  Padding _buildAssignedSitesTableViewHeader(AssignSiteToUserState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: 'OpenSans',
          ),
          children: <TextSpan>[
            TextSpan(
              text:
                  ' Sites can be assigned from list on right. Once assigned they will show here in this list.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnassignedSitesTableView(AssignSiteToUserState state) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<AssignSiteToUserBloc, AssignSiteToUserState>(
        listener: (context, state) {
          if (state.unassignStatus == EntityStatus.success) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification();
            _refetchUserSites(state.filterText);
          } else if (state.unassignStatus == EntityStatus.failure) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        },
        listenWhen: (previous, current) =>
            previous.unassignStatus != current.unassignStatus,
        child: DataTable(
          headingTextStyle: tableHeadingTextStyle,
          dataTextStyle: tableDataTextStyle,
          columns: const [
            DataColumn(
              label: Text('Assigned?'),
            ),
            DataColumn(
              label: Text(
                'Site Name',
              ),
            ),
          ],
          rows: state.unassignedUserSiteList
              .map(
                (unassignedUserSite) => DataRow(
                  cells: [
                    DataCell(
                      CustomSwitch(
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        switchValue: unassignedUserSite.isAssigned,
                        onChanged: (value) {
                          _assignSiteToUser(unassignedUserSite);
                        },
                      ),
                    ),
                    DataCell(
                      CustomDataCell(
                        data: unassignedUserSite.siteName,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildAssignedSitesTableView(
      AssignSiteToUserState state, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<AssignSiteToUserBloc, AssignSiteToUserState>(
        listener: (context, state) {
          if (state.assignStatus == EntityStatus.success) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification();
            _refetchUserSites(state.filterText);
          } else if (state.assignStatus == EntityStatus.failure) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        },
        listenWhen: (previous, current) =>
            previous.assignStatus != current.assignStatus,
        child: DataTable(
          headingTextStyle: tableHeadingTextStyle,
          dataTextStyle: tableDataTextStyle,
          columns: const [
            DataColumn(
              label: Text('Assigned?'),
            ),
            DataColumn(
              label: Text(
                'Site Name',
              ),
            ),
            DataColumn(
              label: Text(
                'Default',
              ),
            ),
          ],
          rows: List<UserSite>.from(state.assignedUserSiteList)
              .map(
                (assignedUserSite) => DataRow(
                  cells: [
                    DataCell(
                      CustomSwitch(
                        switchValue: assignedUserSite.isAssigned,
                        active: !assignedUserSite.isDefault,
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        onChanged: (value) =>
                            _unassignFromUser(assignedUserSite.id!),
                      ),
                    ),
                    DataCell(
                      CustomDataCell(
                        data: assignedUserSite.siteName,
                      ),
                    ),
                    DataCell(
                      CustomDataCell(
                        data: assignedUserSite.isDefault ? 'Yes' : '--',
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _assignSiteToUser(UserSite userSite) {
    addEditUserBloc.add(AssignSiteToUserSiteAssigned(
        userSiteAssignment: UserSiteAssignment(
            siteId: userSite.siteId, userId: widget.userId)));
  }

  void _unassignFromUser(String userSiteId) {
    CustomAlert(
      context: context,
      width: MediaQuery.of(context).size.width / 4,
      title: 'Confirm',
      description: 'Do you really want to remove this site from user?',
      btnOkText: 'Remove',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        addEditUserBloc.add(
            AssignSiteToUserSiteUnassigned(userSiteAssignmentId: userSiteId));
      },
      dialogType: DialogType.question,
    ).show();
  }

  Padding _buildFilterTextField(AssignSiteToUserState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FilterTextField(
        hintText: 'Filter unassigned sites by name.',
        label: 'sites',
        filterIconClick: (filtered) {
          if (filtered) {
            _onFilterApplied(state);
          } else {
            _cancelFilter();
          }
        },
        onChange: (filterText) => addEditUserBloc
            .add(AssignSiteToUserFilterTextChanged(filterText: filterText)),
      ),
    );
  }

  _onFilterApplied(AssignSiteToUserState state) {
    addEditUserBloc.add(AssignSiteToUserUnassignedUserSiteListLoaded(
      userId: widget.userId,
      name: state.filterText,
    ));
  }

  _cancelFilter() {
    addEditUserBloc
      ..add(AssignSiteToUserUnassignedUserSiteListLoaded(userId: widget.userId))
      ..add(const AssignSiteToUserFilterTextChanged(filterText: ''));
  }

  _refetchUserSites(String filterText) {
    addEditUserBloc
      ..add(AssignSiteToUserAssignedUserSiteListLoaded(userId: widget.userId))
      ..add(AssignSiteToUserUnassignedUserSiteListLoaded(
        userId: widget.userId,
        name: filterText,
      ));
  }
}
