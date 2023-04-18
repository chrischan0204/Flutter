import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/constants/constants.dart';
import '/utils/custom_notification.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class ShowProjectView extends StatefulWidget {
  final String projectId;
  const ShowProjectView({
    super.key,
    required this.projectId,
  });

  @override
  State<ShowProjectView> createState() => _ShowProjectViewState();
}

class _ShowProjectViewState extends State<ShowProjectView> {
  late ProjectsBloc projectsBloc;

  static String pageTitle = 'Project';
  static String pageLabel = 'project';
  static String descriptionForDelete =
      'This item can not be deleted as it has companies assigned to it.';

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>()
      ..add(ProjectSelectedById(projectId: widget.projectId))
      ..add(AssignedCompanyProjectsRetrieved(
        projectId: widget.projectId,
      ));
    super.initState();
  }

  _deleteProject(ProjectsState state) {
    projectsBloc.add(ProjectDeleted(projectId: widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsBloc, ProjectsState>(
      listener: (context, state) => _checkDeleteProjectStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => _deleteProject(state),
          tabItems: _buildTabs(state),
          entity: state.selectedProject,
          crudStatus: state.projectCrudStatus,
          deletable: state.deletable,
          descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }

  Map<String, Widget> _buildTabs(ProjectsState state) {
    return {
      'Project Details': Container(),
      'Associated Companies': _buildAssociatedCompanies(state),
      '': Container(),
    };
  }

  Column _buildAssociatedCompanies(ProjectsState state) {
    var rows = state.assignedCompanyProjects
        .map(
          (projectCompany) => DataRow(
            cells: projectCompany
                .toTableDetailMap()
                .values
                .map(
                  (detail) => DataCell(
                    CustomDataCell(data: detail),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
    var columns = const [
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
      DataColumn(
        label: Text(
          'Added By',
        ),
      ),
      DataColumn(
        label: Text(
          'Added on',
        ),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        state.assignedCompanyProjects.isNotEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'The following companies are associated with this project. Edit project to associate/ remove companies from this project',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            : Container(),
        state.assignedCompanyProjects.isNotEmpty
            ? const CustomDivider()
            : Container(),
        Container(
          child: state.assignedCompanyProjects.isNotEmpty
              ? DataTable(
                  headingTextStyle: tableHeadingTextStyle,
                  dataTextStyle: tableDataTextStyle,
                  columns: columns,
                  rows: rows,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'This project has no companies assigned to it yet.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    CustomDivider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Companies can be assigned by editing the project and going to the companies tab to select from available companies',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    CustomDivider(),
                  ],
                ),
        ),
      ],
    );
  }

  void _checkDeleteProjectStatus(ProjectsState state, BuildContext context) {
    if (state.projectCrudStatus == EntityStatus.success) {
      projectsBloc.add(ProjectsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/projects');
    }
    if (state.projectCrudStatus == EntityStatus.failure) {
      projectsBloc.add(ProjectsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
