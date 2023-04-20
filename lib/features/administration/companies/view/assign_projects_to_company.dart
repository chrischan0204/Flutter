import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/constants/constants.dart';
import '/data/model/model.dart';
import '/utils/utils.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';
import 'widgets/filter_textfield.dart';

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
  TextEditingController filterController = TextEditingController(text: '');
  late String? selectedFilterSiteName = null;

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()
      ..add(const FilterTextChanged(filterText: ''))
      ..add(const FilterSiteIdChanged(siteId: ''))
      ..add(AssignedProjectCompaniesRetrieved(companyId: widget.companyId))
      ..add(UnassignedProjectCompaniesRetrieved(companyId: widget.companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: state.assignedCompanySites.isEmpty
              ? const SizedBox(
                  child: Text(
                      'Please assign site to assign project to this company.'),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAssignedProjectsView(state, context),
                        const SizedBox(
                          width: 150,
                        ),
                        _buildUnassignedProjectsView(state),
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
          _buildUnassignedProjectsTableViewHeader(),
          const CustomDivider(),
          _buildFilterProjectView(state),
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
          _buildAssignedProjectsTableViewHeader(),
          const CustomDivider(),
          _buildAssignedProjectsTableView(state, context),
        ],
      ),
    );
  }

  Text _buildUnassignedProjectsTableViewHeader() {
    return const Text(
      'Projects can be assigned to this company by selecting from the list below. Projects list can be filtered by name or by site.',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
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
          height: MediaQuery.of(context).size.height - 357,
          columns: tableColumns,
          rows: state.assignedProjectCompanies
              .map(
                (assignedprojectCompany) => DataRow(
                  cells: [
                    DataCell(
                      CustomSwitch(
                        switchValue: assignedprojectCompany.assigned,
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        onChanged: (value) => _unassignProjectFromCompany(
                            assignedprojectCompany.id),
                      ),
                    ),
                    DataCell(
                      CustomDataCell(
                        data: assignedprojectCompany.projectName,
                      ),
                    ),
                    DataCell(
                      CustomDataCell(
                        data: assignedprojectCompany.siteName,
                      ),
                    ),
                    DataCell(
                      CustomDataCell(
                        data: assignedprojectCompany.roleName,
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
            child: DataTable(
              headingTextStyle: tableHeadingTextStyle,
              dataTextStyle: tableDataTextStyle,
              columns: tableColumns,
              rows: state.unassignedProjectCompanies
                  .map(
                    (unassignedProjectCompany) => DataRow(
                      cells: [
                        DataCell(
                          CustomSwitch(
                            trueString: 'Yes',
                            falseString: 'No',
                            textColor: darkTeal,
                            switchValue: unassignedProjectCompany.assigned,
                            onChanged: (value) => _assignProjectToCompany(
                                unassignedProjectCompany),
                          ),
                        ),
                        DataCell(
                          CustomDataCell(
                              data: unassignedProjectCompany.projectName),
                        ),
                        DataCell(
                          CustomDataCell(
                              data: unassignedProjectCompany.siteName),
                        ),
                        DataCell(
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
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  List<DataColumn> get tableColumns {
    return const [
      DataColumn(
        label: Text('Assigned?'),
      ),
      DataColumn(
        label: Text(
          'Project Name',
        ),
      ),
      DataColumn(
        label: Text(
          'Site',
        ),
      ),
      DataColumn(
        label: Text(
          'Role',
        ),
      ),
    ];
  }

  Widget _buildFilterProjectView(CompaniesState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          _buildFilterProjectTextField(state),
          const SizedBox(
            width: 50,
          ),
          _buildSiteSelectField(state),
        ],
      ),
    );
  }

  Expanded _buildFilterProjectTextField(CompaniesState state) {
    return Expanded(
      flex: 2,
      child: FilterTextField(
        hintText: 'Filter unassigned projects by name.',
        label: 'sites',
        filterController: filterController,
        canFilter: state.filterSiteId.isNotEmpty,
        filterIconClick: (filtered) {
          if (filtered) {
            _applyFilter(state);
          } else {
            _cancelFilter();
          }
        },
        onChange: (value) =>
            companiesBloc.add(FilterTextChanged(filterText: value)),
      ),
    );
  }

  Widget _buildSiteSelectField(CompaniesState state) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return Expanded(
          child: CustomSingleSelect(
            items: {}..addEntries(state.unassignedProjectCompanies.map(
                (unassignedProjectCompany) => MapEntry(
                    unassignedProjectCompany.siteName,
                    unassignedProjectCompany.siteId))),
            hint: 'Filter by site',
            selectedValue: state.unassignedProjectCompanies.isNotEmpty
                ? selectedFilterSiteName
                : null,
            onChanged: (site) {
              companiesBloc.add(FilterSiteIdChanged(siteId: site.value));
              // filterSites = sites.map((site) => site as Site).toList();
              setState(() {
                selectedFilterSiteName = site.key;
              });
            },
          ),
        );
      },
    );
  }

  Padding _buildAssignedProjectsTableViewHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: 'OpenSans',
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Projects can be assigned to \' ${widget.companyName} \'',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
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

  _applyFilter(CompaniesState state) {
    companiesBloc.add(UnassignedProjectCompaniesRetrieved(
      companyId: widget.companyId,
      name: state.filterText,
      siteId: state.filterSiteId,
    ));
  }

  _cancelFilter() {
    companiesBloc
      ..add(UnassignedProjectCompaniesRetrieved(companyId: widget.companyId))
      ..add(const FilterTextChanged(filterText: ''))
      ..add(const FilterSiteIdChanged(siteId: ''));
    setState(() {
      selectedFilterSiteName = null;
    });
  }

  _refetchProjectCompanies(CompaniesState state) {
    companiesBloc
      ..add(AssignedProjectCompaniesRetrieved(companyId: widget.companyId))
      ..add(UnassignedProjectCompaniesRetrieved(
        companyId: widget.companyId,
        name: state.filterText,
        siteId: state.filterSiteId,
      ));
  }
}
