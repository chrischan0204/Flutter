import '/common_libraries.dart';

class ProjectsListView extends StatefulWidget {
  const ProjectsListView({super.key});

  @override
  State<ProjectsListView> createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  late ProjectsBloc projectsBloc;

  static String pageTitle = 'Projects';
  static String pageLabel = 'project';
  static String emptyMessage =
      'There are no projects. Please click on New Project to add new project';

  @override
  void initState() {
    projectsBloc = context.read<ProjectsBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, filterSettingState) =>
          BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (context, state) {
          return EntityListTemplate(
            title: pageTitle,
            label: pageLabel,
            viewName: pageLabel,
            entities: state.projects,
            showTableHeaderButtons: true,
            onRowClick: (selectedProject) => _selectProject(selectedProject),
            emptyMessage: emptyMessage,
            entityListLoadStatusLoading:
                filterSettingState.filterSettingLoading ||
                    state.projectsRetrievedStatus.isLoading,
            selectedEntity: state.selectedProject,
            onTableSorted: (sortedProjects) => _sortProjects(sortedProjects),
            onViewSettingApplied: () => _filterProjects(),
            onIncludeDeletedChanged: (value) => _filterProjects(null, value),
            onFilterSaved: _filterProjects,
            onFilterApplied: _filterProjects,
          );
        },
      ),
    );
  }

  void _sortProjects(List<Entity> sortedProjects) {
    projectsBloc.add(ProjectsSorted(
        projects: sortedProjects
            .map((sortedProject) => sortedProject as Project)
            .toList()));
  }

  void _selectProject(Entity selectedProject) {
    projectsBloc.add(ProjectSelectedById(projectId: selectedProject.id!));
  }

  void _filterProjects([
    String? filterId,
    bool? includeDeleted,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    projectsBloc.add(ProjectListFiltered(
      filterId: filterId ??
          filterSettingBloc.state.selectedUserFilterSetting?.id ??
          emptyGuid,
      includeDeleted: includeDeleted ?? filterSettingBloc.state.includeDeleted,
    ));
  }
}
