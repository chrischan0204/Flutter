import '/common_libraries.dart';

class AssignProjectsToCompanyView extends StatefulWidget {
  final String companyId;
  final String companyName;
  final String? view;
  const AssignProjectsToCompanyView({
    super.key,
    required this.companyId,
    required this.companyName,
    this.view,
  });

  @override
  State<AssignProjectsToCompanyView> createState() =>
      _AssignProjectsToCompanyViewState();
}

class _AssignProjectsToCompanyViewState
    extends State<AssignProjectsToCompanyView> {
  late CompaniesBloc companiesBloc;
  late String? selectedFilterSiteNameForUnassign = null;
  late String? selectedFilterSiteNameForAssign = null;

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()
      ..add(const FilterTextForAssignedChanged(filterText: ''))
      ..add(const FilterSiteIdForAssignedChanged(siteId: ''))
      ..add(const FilterTextForUnassignedChanged(filterText: ''))
      ..add(const FilterSiteIdForUnassignedChanged(siteId: ''))
      ..add(AssignedProjectCompaniesRetrieved(
          companyId: widget.companyId, forFilter: true))
      ..add(UnassignedProjectCompaniesRetrieved(
          companyId: widget.companyId, forFilter: true));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return Padding(
          padding: inset10,
          child: state.assignedCompanySites.isEmpty
              ? const SizedBox(
                  child: Text(
                      'Please assign site to assign project to this company.'),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: _buildUnassignedProjectsTableViewHeader()),
                        const SizedBox(width: 100),
                        Expanded(
                            child: _buildAssignedProjectsTableViewHeader()),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUnassignedProjectsView(state),
                        const SizedBox(
                          width: 100,
                        ),
                        _buildAssignedProjectsView(state, context),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }

  Expanded _buildUnassignedProjectsView(CompaniesState state) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDivider(),
          _buildFilterProjectViewForUnassigned(state),
          const CustomDivider(),
          _buildUnassignedProjectsTableView(state),
        ],
      ),
    );
  }

  Expanded _buildAssignedProjectsView(
      CompaniesState state, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDivider(),
          _buildFilterProjectViewForAssigned(state),
          const CustomDivider(),
          _buildAssignedProjectsTableView(state, context),
        ],
      ),
    );
  }

  Padding _buildUnassignedProjectsTableViewHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Projects can be assigned to this company by selecting from the list below. Projects list can be filtered by name or by site.',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildAssignedProjectsTableView(
      CompaniesState state, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<CompaniesBloc, CompaniesState>(
        listener: (context, state) {
          if (state.projectFromCompanyUnassignedStatus ==
              EntityStatus.success) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification();
            _refetchProjectCompanies(state);
          } else if (state.projectFromCompanyUnassignedStatus ==
              EntityStatus.failure) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        },
        listenWhen: (previous, current) =>
            previous.projectFromCompanyUnassignedStatus !=
            current.projectFromCompanyUnassignedStatus,
        child: TableView(
          height: MediaQuery.of(context).size.height - 460,
          columns: tableColumns,
          rows: state.assignedProjectCompanies
              .map(
                (assignedprojectCompany) => [
                  CustomDataCell(
                    data: assignedprojectCompany.projectName,
                  ),
                  CustomDataCell(
                    data: assignedprojectCompany.siteName,
                  ),
                  CustomDataCell(
                    data: assignedprojectCompany.roleName,
                  ),
                  CustomSwitch(
                    switchValue: assignedprojectCompany.assigned,
                    trueString: 'Yes',
                    falseString: 'No',
                    textColor: darkTeal,
                    onChanged: (value) =>
                        _unassignProjectFromCompany(assignedprojectCompany.id),
                  ),
                ],
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildUnassignedProjectsTableView(CompaniesState state) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, rolesState) {
          return BlocListener<CompaniesBloc, CompaniesState>(
            listener: (context, state) {
              if (state.projectToCompanyAssignedStatus ==
                  EntityStatus.success) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.success,
                  content: state.message,
                ).showNotification();
                _refetchProjectCompanies(state);
              } else if (state.projectToCompanyAssignedStatus ==
                  EntityStatus.failure) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.error,
                  content: state.message,
                ).showNotification();
              }
            },
            listenWhen: (previous, current) =>
                previous.projectToCompanyAssignedStatus !=
                current.projectToCompanyAssignedStatus,
            child: TableView(
              height: MediaQuery.of(context).size.height - 460,
              columns: tableColumns,
              rows: state.unassignedProjectCompanies
                  .map(
                    (unassignedProjectCompany) => [
                      CustomDataCell(
                          data: unassignedProjectCompany.projectName),
                      CustomDataCell(data: unassignedProjectCompany.siteName),
                      CustomSingleSelect(
                        items: {}..addEntries(rolesState.roles
                            .map((role) => MapEntry(role.name, role))),
                        hint: 'Select Role',
                        selectedValue: rolesState.roles.isNotEmpty
                            ? unassignedProjectCompany.roleName.isNotEmpty
                                ? unassignedProjectCompany.roleName
                                : null
                            : null,
                        onChanged: (role) => companiesBloc.add(
                          UnAssignedProjectCompanyRoleSelected(
                            role: role.value,
                            projectCompanyIndex: state
                                .unassignedProjectCompanies
                                .indexOf(unassignedProjectCompany),
                          ),
                        ),
                      ),
                      CustomSwitch(
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        switchValue: unassignedProjectCompany.assigned,
                        onChanged: (value) =>
                            _assignProjectToCompany(unassignedProjectCompany),
                      ),
                    ],
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  List<String> get tableColumns {
    return const [
      'Project Name',
      'Site',
      'Role',
      'Assigned?',
    ];
  }

  Widget _buildFilterProjectViewForUnassigned(CompaniesState state) {
    return Padding(
      padding: insetx20,
      child: Row(
        children: [
          _buildSiteSelectFieldForUnassigned(state),
          spacer30,
          _buildFilterProjectTextFieldForUnassigned(state),
        ],
      ),
    );
  }

  Expanded _buildFilterProjectTextFieldForUnassigned(CompaniesState state) {
    return Expanded(
      flex: 2,
      child: FilterTextField(
        hintText: 'Filter unassigned projects by name.',
        label: 'sites',
        canFilter: state.filterSiteIdForUnassigned.isNotEmpty,
        applyFilter: () {
          companiesBloc.add(UnassignedProjectCompaniesRetrieved(
            companyId: widget.companyId,
            name: state.filterTextForUnassigned,
            siteId: state.filterSiteIdForUnassigned,
            // forFilter: true,
          ));
        },
        clearFilter: () {
          companiesBloc
            ..add(UnassignedProjectCompaniesRetrieved(
              companyId: widget.companyId,
              siteId: state.filterSiteIdForUnassigned,
              // forFilter: true,
            ))
            ..add(const FilterTextForUnassignedChanged(filterText: ''));
        },
        onChange: (value) => companiesBloc
            .add(FilterTextForUnassignedChanged(filterText: value)),
      ),
    );
  }

  Widget _buildSiteSelectFieldForUnassigned(CompaniesState state) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: CustomSingleSelect(
                  items: {}..addEntries(state
                      .unassignedProjectCompaniesForFilter
                      .map((unassignedProjectCompany) => MapEntry(
                          unassignedProjectCompany.siteName,
                          unassignedProjectCompany.siteId))),
                  hint: 'Filter by site',
                  selectedValue: state.unassignedProjectCompanies.isNotEmpty
                      ? selectedFilterSiteNameForUnassign
                      : null,
                  onChanged: (site) {
                    companiesBloc.add(
                        FilterSiteIdForUnassignedChanged(siteId: site.value));
                    companiesBloc.add(UnassignedProjectCompaniesRetrieved(
                      companyId: widget.companyId,
                      name: state.filterTextForUnassigned,
                      siteId: site.value,
                    ));
                    setState(() {
                      selectedFilterSiteNameForUnassign = site.key;
                    });
                  },
                ),
              ),
              spacer12,
              InkWell(
                onTap: () {
                  setState(() {
                    selectedFilterSiteNameForUnassign = null;
                  });

                  companiesBloc
                      .add(const FilterSiteIdForUnassignedChanged(siteId: ''));

                  companiesBloc.add(UnassignedProjectCompaniesRetrieved(
                    companyId: widget.companyId,
                    name: state.filterTextForUnassigned,
                  ));
                },
                child: Icon(
                  PhosphorIcons.regular.arrowCounterClockwise,
                  color: Colors.red,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterProjectViewForAssigned(CompaniesState state) {
    return Padding(
      padding: insetx20,
      child: Row(
        children: [
          _buildSiteSelectFieldForAssigned(state),
          spacer30,
          _buildFilterProjectTextFieldForAssigned(state),
        ],
      ),
    );
  }

  Expanded _buildFilterProjectTextFieldForAssigned(CompaniesState state) {
    return Expanded(
      flex: 2,
      child: FilterTextField(
        hintText: 'Filter assigned projects by name.',
        label: 'sites',
        canFilter: state.filterSiteIdForAssigned.isNotEmpty,
        applyFilter: () {
          companiesBloc.add(AssignedProjectCompaniesRetrieved(
            companyId: widget.companyId,
            name: state.filterTextForAssigned,
            siteId: state.filterSiteIdForAssigned,
            // forFilter: true,
          ));
        },
        clearFilter: () {
          companiesBloc
            ..add(AssignedProjectCompaniesRetrieved(
              companyId: widget.companyId,
              siteId: state.filterSiteIdForAssigned,
              // forFilter: true,
            ))
            ..add(const FilterTextForAssignedChanged(filterText: ''));
        },
        onChange: (value) =>
            companiesBloc.add(FilterTextForAssignedChanged(filterText: value)),
      ),
    );
  }

  Widget _buildSiteSelectFieldForAssigned(CompaniesState state) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: CustomSingleSelect(
                  items: {}..addEntries(state.assignedProjectCompaniesForFilter.map(
                      (assignedProjectCompany) => MapEntry(
                          assignedProjectCompany.siteName,
                          assignedProjectCompany.siteId))),
                  hint: 'Filter by site',
                  selectedValue: state.assignedProjectCompanies.isNotEmpty
                      ? selectedFilterSiteNameForAssign
                      : null,
                  onChanged: (site) {
                    companiesBloc.add(
                        FilterSiteIdForAssignedChanged(siteId: site.value));
                    companiesBloc.add(AssignedProjectCompaniesRetrieved(
                      companyId: widget.companyId,
                      name: state.filterTextForAssigned,
                      siteId: site.value,
                    ));
                    setState(() {
                      selectedFilterSiteNameForAssign = site.key;
                    });
                  },
                ),
              ),
              spacer12,
              InkWell(
                onTap: () {
                  setState(() {
                    selectedFilterSiteNameForAssign = null;
                  });

                  companiesBloc
                      .add(const FilterSiteIdForAssignedChanged(siteId: ''));

                  companiesBloc.add(AssignedProjectCompaniesRetrieved(
                    companyId: widget.companyId,
                    name: state.filterTextForAssigned,
                  ));
                },
                child: Icon(
                  PhosphorIcons.regular.arrowCounterClockwise,
                  color: Colors.red,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Padding _buildAssignedProjectsTableViewHeader() {
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
                  '  Projects are listed as per the sites assigned to this company.',
            ),
          ],
        ),
      ),
    );
  }

  void _assignProjectToCompany(ProjectCompany projectCompany) {
    if (projectCompany.roleId.contains('00000000')) {
      CustomAlert(
        context: context,
        width: MediaQuery.of(context).size.width / 4,
        title: 'Notification',
        description: 'Please select a role for the company first.',
        btnOkText: 'OK',
        btnOkOnPress: () {},
        dialogType: DialogType.warning,
      ).show();
    } else {
      companiesBloc.add(ProjectToCompanyAssigned(
          projectCompanyAssignment: projectCompany
              .copyWith(companyId: widget.companyId)
              .toProjectCompanyAssignment()));
    }
  }

  void _unassignProjectFromCompany(String projectCompanyId) {
    CustomAlert(
      context: context,
      width: MediaQuery.of(context).size.width / 4,
      title: 'Confirm',
      description: 'Do you really want to remove this project from company?',
      btnOkText: 'Remove',
      btnOkOnPress: () {
        companiesBloc.add(ProjectFromCompanyUnassigned(
            projectCompanyAssignmentId: projectCompanyId));
      },
      btnCancelOnPress: () {},
      dialogType: DialogType.question,
    ).show();
  }

  _refetchProjectCompanies(CompaniesState state) {
    companiesBloc
      ..add(AssignedProjectCompaniesRetrieved(
        companyId: widget.companyId,
        name: state.filterTextForAssigned,
        siteId: state.filterSiteIdForAssigned,
        forFilter: true,
      ))
      ..add(UnassignedProjectCompaniesRetrieved(
        companyId: widget.companyId,
        name: state.filterTextForUnassigned,
        siteId: state.filterSiteIdForUnassigned,
        forFilter: true,
      ));
  }
}
