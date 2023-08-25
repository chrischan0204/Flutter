import '/common_libraries.dart';

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
      ..add(AssignedCompanyProjectsLoaded(
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
      'Associated Companies': _buildAssociatedCompanies(state),
    };
  }

  Widget _buildAssociatedCompanies(ProjectsState state) {
    var rows = state.assignedCompanyProjects
        .map(
          (projectCompany) => projectCompany
              .toTableDetailMap()
              .values
              .map(
                (detail) => CustomDataCell(data: detail),
              )
              .toList(),
        )
        .toList();
    var columns = const ['Company Name', 'Role', 'Added By', 'Added on'];
    return state.assignedCompanyProjectsLoadedStatus == EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: Center(child: Loader()),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.assignedCompanyProjects.isNotEmpty
                  ? Padding(
                      padding: insetx20,
                      child: const Text(
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
                    ? TableView(
                        height: MediaQuery.of(context).size.height - 460,
                        columns: columns,
                        rows: rows,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: insetx20,
                            child: const Text(
                              'This project has no companies assigned to it yet.',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const CustomDivider(),
                          Padding(
                            padding: insetx20,
                            child: const Text(
                              'Companies can be assigned by editing the project and going to the companies tab to select from available companies',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const CustomDivider(),
                        ],
                      ),
              ),
            ],
          );
  }

  void _checkDeleteProjectStatus(ProjectsState state, BuildContext context) {
    if (state.projectCrudStatus.isSuccess) {
      projectsBloc.add(ProjectsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/projects');
    }
    if (state.projectCrudStatus.isFailure) {
      projectsBloc.add(ProjectsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
