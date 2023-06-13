import 'package:flutter/material.dart';

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

  List<String> get tableColumns => const ['Company Name', 'Role', 'Assigned?'];

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>()
      ..add(const FilterTextForUnassignedCompanyChanged(filterText: ''))
      ..add(AssignedCompanyProjectsRetrieved(projectId: widget.projectId))
      ..add(UnassignedCompanyProjectsRetrieved(projectId: widget.projectId));

    context.read<FormDirtyBloc>().add(const FormDirtyChanged(isDirty: false));
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
                children: [
                  Expanded(child: _buildUnassignedCompaniesTableViewHeader()),
                  const SizedBox(width: 100),
                  Expanded(child: _buildAssignedCompaniesTableViewHeader()),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomDivider(),
                        _buildFilterTextFieldForUnassignedCompany(state),
                        const CustomDivider(),
                        _buildUnassignedSitesTableView(state),
                      ],
                    ),
                  ),
                  const SizedBox(width: 100),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomDivider(),
                        _buildFilterTextFieldForAssignedCompany(state),
                        const CustomDivider(),
                        _buildAssignedCompaniesTableView(state, context),
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

  Padding _buildUnassignedCompaniesTableViewHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Sites can be assigned to this company by selecting from the list below.',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Padding _buildAssignedCompaniesTableViewHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            TextSpan(
              text:
                  'Companies can be assigned from list on left. Once assigned they will show here in this list below.',
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
                _refetchProjectCompanies(state);
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
              height: MediaQuery.of(context).size.height - 460,
              columns: tableColumns,
              rows: state.unassignedCompanyProjects
                  .map(
                    (unassignedProjectCompany) => [
                      CustomDataCell(
                        data: unassignedProjectCompany.companyName,
                      ),
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
                            projectCompanyIndex: state.unassignedCompanyProjects
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
                            _assignCompanyToProject(unassignedProjectCompany),
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
              _refetchProjectCompanies(state);
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
            height: MediaQuery.of(context).size.height - 460,
            columns: tableColumns,
            rows: state.assignedCompanyProjects
                .map(
                  (assignedProjectCompany) => [
                    CustomDataCell(
                      data: assignedProjectCompany.companyName,
                    ),
                    CustomDataCell(
                      data: assignedProjectCompany.roleName,
                    ),
                    CustomSwitch(
                      switchValue: assignedProjectCompany.assigned,
                      trueString: 'Yes',
                      falseString: 'No',
                      textColor: darkTeal,
                      onChanged: (value) =>
                          _unassignFromCompany(assignedProjectCompany.id),
                    ),
                  ],
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

  Padding _buildFilterTextFieldForUnassignedCompany(ProjectsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FilterTextField(
        hintText: 'Filter unassigned companies by name.',
        label: 'sites',
        filterIconClick: (filtered) {
          if (filtered) {
            projectsBloc.add(UnassignedCompanyProjectsRetrieved(
              projectId: widget.projectId,
              name: state.filterTextForUnassignedCompany,
            ));
          } else {
            projectsBloc
              ..add(UnassignedCompanyProjectsRetrieved(
                  projectId: widget.projectId))
              ..add(
                  const FilterTextForUnassignedCompanyChanged(filterText: ''));
          }
        },
        onChange: (value) => projectsBloc
            .add(FilterTextForUnassignedCompanyChanged(filterText: value)),
      ),
    );
  }

  Padding _buildFilterTextFieldForAssignedCompany(ProjectsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FilterTextField(
        hintText: 'Filter assigned companies by name.',
        label: 'sites',
        filterIconClick: (filtered) {
          if (filtered) {
            projectsBloc.add(AssignedCompanyProjectsRetrieved(
              projectId: widget.projectId,
              name: state.filterTextForAssignedCompany,
            ));
          } else {
            projectsBloc
              ..add(
                  AssignedCompanyProjectsRetrieved(projectId: widget.projectId))
              ..add(const FilterTextForAssignedCompanyChanged(filterText: ''));
          }
        },
        onChange: (value) => projectsBloc
            .add(FilterTextForAssignedCompanyChanged(filterText: value)),
      ),
    );
  }

  _refetchProjectCompanies(ProjectsState state) {
    projectsBloc
      ..add(AssignedCompanyProjectsRetrieved(
        projectId: widget.projectId,
        name: state.filterTextForAssignedCompany,
      ))
      ..add(UnassignedCompanyProjectsRetrieved(
        projectId: widget.projectId,
        name: state.filterTextForUnassignedCompany,
      ));
  }
}
