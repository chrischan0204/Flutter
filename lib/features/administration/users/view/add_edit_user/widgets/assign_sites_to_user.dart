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

    context.read<FormDirtyBloc>().add(const FormDirtyChanged(isDirty: false));
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
                children: [
                  Expanded(child: _buildAssignedSitesTableViewHeader()),
                  const SizedBox(width: 100),
                  Expanded(child: _buildUnassignedSitesTableHeaderView()),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUnassignedSitesView(state),
                  const SizedBox(width: 100),
                  _buildAssignedSitesView(state, context),
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
          const CustomDivider(),
          _buildFilterTextFieldForUnassigned(state),
          const CustomDivider(),
          _buildUnassignedSitesTableView(state),
        ],
      ),
    );
  }

  Padding _buildUnassignedSitesTableHeaderView() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Sites can be assigned to this user by selecting from the list below.',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Expanded _buildAssignedSitesView(
      AssignSiteToUserState state, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDivider(),
          _buildFilterTextFieldForAssigned(state),
          const CustomDivider(),
          _buildAssignedSitesTableView(state, context),
        ],
      ),
    );
  }

  Padding _buildAssignedSitesTableViewHeader() {
    return Padding(
      padding: insetx20,
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
                  'Sites can be assigned from list on left. Once assigned they will show here in this list.',
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
            _refetchUserSites(state);
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
        child: TableView(
          height: MediaQuery.of(context).size.height - 460,
          columns: const ['Site Name', 'Assigned?'],
          rows: state.unassignedUserSiteList
              .map((unassignedUserSite) => [
                    CustomDataCell(
                      data: unassignedUserSite.siteName,
                    ),
                    CustomSwitch(
                      trueString: 'Yes',
                      falseString: 'No',
                      textColor: darkTeal,
                      switchValue: unassignedUserSite.isAssigned,
                      onChanged: (value) {
                        _assignSiteToUser(unassignedUserSite);
                      },
                    ),
                  ])
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
            _refetchUserSites(state);
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
        child: TableView(
          height: MediaQuery.of(context).size.height - 460,
          columns: const ['Site Name', 'Default', 'Assigned?'],
          rows: List<UserSite>.from(state.assignedUserSiteList)
              .map((assignedUserSite) => [
                    CustomDataCell(
                      data: assignedUserSite.siteName,
                    ),
                    CustomDataCell(
                      data: assignedUserSite.isDefault ? 'Yes' : '--',
                    ),
                    CustomSwitch(
                      switchValue: assignedUserSite.isAssigned,
                      active: !assignedUserSite.isDefault,
                      trueString: 'Yes',
                      falseString: 'No',
                      textColor: darkTeal,
                      onChanged: (value) =>
                          _unassignFromUser(assignedUserSite.id!),
                    ),
                  ])
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

  Padding _buildFilterTextFieldForUnassigned(AssignSiteToUserState state) {
    return Padding(
      padding: insetx20,
      child: FilterTextField(
        hintText: 'Filter unassigned sites by name.',
        label: 'sites',
        applyFilter: () {
          addEditUserBloc.add(AssignSiteToUserUnassignedUserSiteListLoaded(
            userId: widget.userId,
            name: state.filterTextForUnassigned,
          ));
        },
        clearFilter: () {
          addEditUserBloc
            ..add(AssignSiteToUserUnassignedUserSiteListLoaded(
                userId: widget.userId))
            ..add(const AssignSiteToUserFilterTextForUnassignedChanged(
                filterText: ''));
        },
        onChange: (filterText) => addEditUserBloc.add(
            AssignSiteToUserFilterTextForUnassignedChanged(
                filterText: filterText)),
      ),
    );
  }

  Padding _buildFilterTextFieldForAssigned(AssignSiteToUserState state) {
    return Padding(
      padding: insetx20,
      child: FilterTextField(
        hintText: 'Filter assigned sites by name.',
        label: 'sites',
        applyFilter: () {
          addEditUserBloc.add(AssignSiteToUserAssignedUserSiteListLoaded(
            userId: widget.userId,
            name: state.filterTextForAssigned,
          ));
        },
        clearFilter: () {
          addEditUserBloc
            ..add(AssignSiteToUserAssignedUserSiteListLoaded(
                userId: widget.userId))
            ..add(const AssignSiteToUserFilterTextForAssignedChanged(
                filterText: ''));
        },
        onChange: (filterText) => addEditUserBloc.add(
            AssignSiteToUserFilterTextForAssignedChanged(
                filterText: filterText)),
      ),
    );
  }

  _refetchUserSites(AssignSiteToUserState state) {
    addEditUserBloc
      ..add(AssignSiteToUserAssignedUserSiteListLoaded(
        userId: widget.userId,
        name: state.filterTextForAssigned,
      ))
      ..add(AssignSiteToUserUnassignedUserSiteListLoaded(
        userId: widget.userId,
        name: state.filterTextForUnassigned,
      ));
  }
}
