part of 'projects_bloc.dart';

class ProjectsState extends Equatable {
  final List<Project> projects;
  final List<ProjectCompany> unassignedCompanyProjects;
  final List<ProjectCompany> assignedCompanyProjects;
  final EntityStatus assignedCompanyProjectsLoadedStatus;
  final EntityStatus unassignedCompanyProjectsLoadedStatus;
  final EntityStatus companyToProjectAssignedStatus;
  final EntityStatus companyFromProjectUnassignedStatus;
  final Project? selectedProject;
  final EntityStatus projectsLoadedStatus;
  final EntityStatus projectSelectedStatus;
  final EntityStatus projectCrudStatus;
  final String message;
  final String filterTextForAssignedCompany;
  final String filterTextForUnassignedCompany;
  final int totalRows;
  const ProjectsState({
    this.projects = const [],
    this.unassignedCompanyProjects = const [],
    this.assignedCompanyProjects = const [],
    this.selectedProject,
    this.projectsLoadedStatus = EntityStatus.initial,
    this.projectCrudStatus = EntityStatus.initial,
    this.projectSelectedStatus = EntityStatus.initial,
    this.companyToProjectAssignedStatus = EntityStatus.initial,
    this.companyFromProjectUnassignedStatus = EntityStatus.initial,
    this.assignedCompanyProjectsLoadedStatus = EntityStatus.initial,
    this.unassignedCompanyProjectsLoadedStatus = EntityStatus.initial,
    this.message = '',
    this.filterTextForAssignedCompany = '',
    this.filterTextForUnassignedCompany = '',
    this.totalRows = 0,
  });

  @override
  List<Object?> get props => [
        projects,
        assignedCompanyProjects,
        unassignedCompanyProjects,
        selectedProject,
        projectsLoadedStatus,
        projectCrudStatus,
        projectSelectedStatus,
        assignedCompanyProjectsLoadedStatus,
        unassignedCompanyProjectsLoadedStatus,
        companyToProjectAssignedStatus,
        companyFromProjectUnassignedStatus,
        message,
        filterTextForAssignedCompany,
        filterTextForUnassignedCompany,
        totalRows,
      ];

  bool get deletable => assignedCompanyProjects.isEmpty;

  ProjectsState copyWith({
    List<Project>? projects,
    List<ProjectCompany>? assignedCompanyProjects,
    List<ProjectCompany>? unassignedCompanyProjects,
    Project? selectedProject,
    EntityStatus? projectsLoadedStatus,
    EntityStatus? projectSelectedStatus,
    EntityStatus? projectCrudStatus,
    EntityStatus? assignedCompanyProjectsLoadedStatus,
    EntityStatus? unassignedCompanyProjectsLoadedStatus,
    EntityStatus? companyToProjectAssignedStatus,
    EntityStatus? companyFromProjectUnassignedStatus,
    String? message,
    String? filterTextForAssignedCompany,
    String? filterTextForUnassignedCompany,
    int? totalRows,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      assignedCompanyProjects:
          assignedCompanyProjects ?? this.assignedCompanyProjects,
      unassignedCompanyProjects:
          unassignedCompanyProjects ?? this.unassignedCompanyProjects,
      selectedProject: selectedProject ?? this.selectedProject,
      projectsLoadedStatus: projectsLoadedStatus ?? this.projectsLoadedStatus,
      projectSelectedStatus:
          projectSelectedStatus ?? this.projectSelectedStatus,
      projectCrudStatus: projectCrudStatus ?? this.projectCrudStatus,
      assignedCompanyProjectsLoadedStatus:
          assignedCompanyProjectsLoadedStatus ??
              this.assignedCompanyProjectsLoadedStatus,
      unassignedCompanyProjectsLoadedStatus:
          unassignedCompanyProjectsLoadedStatus ??
              this.unassignedCompanyProjectsLoadedStatus,
      companyToProjectAssignedStatus:
          companyToProjectAssignedStatus ?? this.companyToProjectAssignedStatus,
      companyFromProjectUnassignedStatus: companyFromProjectUnassignedStatus ??
          this.companyFromProjectUnassignedStatus,
      message: message ?? this.message,
      filterTextForAssignedCompany:
          filterTextForAssignedCompany ?? this.filterTextForAssignedCompany,
      filterTextForUnassignedCompany:
          filterTextForUnassignedCompany ?? this.filterTextForUnassignedCompany,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
