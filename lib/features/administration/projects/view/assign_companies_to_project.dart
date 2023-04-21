import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../global_widgets/entities_list_template/widgets/filter_textfield.dart';
import '/utils/utils.dart';
import '/constants/constants.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';
import '/global_widgets/global_widget.dart';

class AssignCompaniesToProjectView extends StatefulWidget {
  final String projectId;
  final String projectName;
  final String? view;
  const AssignCompaniesToProjectView({
    super.key,
    required this.projectId,
    required this.projectName,
    this.view,
  });

  @override
  State<AssignCompaniesToProjectView> createState() =>
      _AssignCompaniesToProjectViewState();
}

class _AssignCompaniesToProjectViewState
    extends State<AssignCompaniesToProjectView> {
  late ProjectsBloc projectsBloc;
  TextEditingController filterController = TextEditingController(text: '');

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>()
      ..add(const FilterTextForCompanyChanged(filterText: ''))
      ..add(AssignedCompanyProjectsRetrieved(projectId: widget.projectId))
      ..add(UnassignedCompanyProjectsRetrieved(projectId: widget.projectId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAssignedCompaniesTableViewHeader(state),
                        const CustomDivider(),
                        _buildAssignedCompaniesTableView(state, context),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sites can be assigned to this company by selecting from the list below.',
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
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildAssignedCompaniesTableViewHeader(ProjectsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            TextSpan(
              text:
                  'The project \'${widget.projectName}\' has been ${widget.view == 'created' ? 'created' : 'updated'}.',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text:
                  ' Companies can be assigned from list on right. Once assigned they will show here in this list below.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnassignedSitesTableView(ProjectsState state) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, rolesState) {
          return BlocListener<ProjectsBloc, ProjectsState>(
            listener: (context, state) {
              if (state.companyFromProjectUnassignedStatus ==
                  EntityStatus.success) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.success,
                  content: state.message,
                ).showNotification();
                _refetchProjectCompanies(state.filterText);
              } else if (state.companyFromProjectUnassignedStatus ==
                  EntityStatus.failure) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.error,
                  content: state.message,
                ).showNotification();
              }
            },
            listenWhen: (previous, current) =>
                previous.companyFromProjectUnassignedStatus !=
                current.companyFromProjectUnassignedStatus,
            child: TableView(
              height: MediaQuery.of(context).size.height - 417,
              columns: tableColumns,
              rows: state.unassignedCompanyProjects
                  .map(
                    (unassignedProjectCompany) => DataRow(
                      cells: [
                        DataCell(
                          CustomSwitch(
                            trueString: 'Yes',
                            falseString: 'No',
                            textColor: darkTeal,
                            switchValue: unassignedProjectCompany.assigned,
                            onChanged: (value) => _assignCompanyToProject(
                                unassignedProjectCompany),
                          ),
                        ),
                        DataCell(
                          CustomDataCell(
                            data: unassignedProjectCompany.companyName,
                          ),
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
                            onChanged: (role) => projectsBloc.add(
                              UnAssignedCompanyProjectRoleSelected(
                                role: role.value,
                                projectCompanyIndex: state
                                    .unassignedCompanyProjects
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

  List<DataColumn> get tableColumns => const [
        DataColumn(
          label: Text('Assigned?'),
        ),
        DataColumn(
          label: Text(
            'Company Name',
          ),
        ),
        DataColumn(
          label: Text(
            'Role',
          ),
        ),
      ];

  Widget _buildAssignedCompaniesTableView(
      ProjectsState state, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<ProjectsBloc, ProjectsState>(
          listener: (context, state) {
            if (state.companyToProjectAssignedStatus == EntityStatus.success) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.success,
                content: state.message,
              ).showNotification();
              _refetchProjectCompanies(state.filterText);
            } else if (state.companyToProjectAssignedStatus ==
                EntityStatus.failure) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.error,
                content: state.message,
              ).showNotification();
            }
          },
          listenWhen: (previous, current) =>
              previous.companyToProjectAssignedStatus !=
              current.companyToProjectAssignedStatus,
          child: TableView(
            height: MediaQuery.of(context).size.height - 369,
            columns: tableColumns,
            rows: state.assignedCompanyProjects
                .map(
                  (assignedProjectCompany) => DataRow(
                    cells: [
                      DataCell(
                        CustomSwitch(
                          switchValue: assignedProjectCompany.assigned,
                          trueString: 'Yes',
                          falseString: 'No',
                          textColor: darkTeal,
                          onChanged: (value) =>
                              _unassignFromCompany(assignedProjectCompany.id),
                        ),
                      ),
                      DataCell(
                        CustomDataCell(
                          data: assignedProjectCompany.companyName,
                        ),
                      ),
                      DataCell(
                        CustomDataCell(
                          data: assignedProjectCompany.roleName,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          )),
    );
  }

  void _assignCompanyToProject(ProjectCompany companySite) {
    if (companySite.roleId.contains('00000000')) {
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
      projectsBloc.add(CompanyToProjectAssigned(
          projectCompanyAssignment: companySite
              .copyWith(projectId: widget.projectId)
              .toProjectCompanyAssignment()));
    }
  }

  void _unassignFromCompany(String projectCompanyAssignmentId) {
    CustomAlert(
      context: context,
      width: MediaQuery.of(context).size.width / 4,
      title: 'Confirm',
      description: 'Do you really want to remove this company from project?',
      btnOkText: 'Remove',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        projectsBloc.add(CompanyFromProjectUnassigned(
            projectCompanyAssignmentId: projectCompanyAssignmentId));
      },
      dialogType: DialogType.question,
    ).show();
  }

  Padding _buildFilterTextField(ProjectsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FilterTextField(
        hintText: 'Filter unassigned companies by name.',
        label: 'sites',
        filterController: filterController,
        filterIconClick: (filtered) {
          if (filtered) {
            _applyFilter(state);
          } else {
            _cancelFilter();
          }
        },
        onChange: (value) =>
            projectsBloc.add(FilterTextForCompanyChanged(filterText: value)),
      ),
    );
  }

  _applyFilter(ProjectsState state) {
    projectsBloc.add(UnassignedCompanyProjectsRetrieved(
      projectId: widget.projectId,
      name: state.filterText,
    ));
  }

  _cancelFilter() {
    projectsBloc
      ..add(UnassignedCompanyProjectsRetrieved(projectId: widget.projectId))
      ..add(const FilterTextForCompanyChanged(filterText: ''));
  }

  _refetchProjectCompanies(String filterText) {
    projectsBloc
      ..add(AssignedCompanyProjectsRetrieved(projectId: widget.projectId))
      ..add(UnassignedCompanyProjectsRetrieved(
        projectId: widget.projectId,
        name: filterText,
      ));
  }
}
