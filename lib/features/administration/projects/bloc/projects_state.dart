part of 'projects_bloc.dart';

class ProjectsState extends Equatable {
  final List<Project> projects;
  final List<ProjectCompany> unassignedCompanyProjects;
  final List<ProjectCompany> assignedCompanyProjects;
  final EntityStatus assignedCompanyProjectsRetrievedStatus;
  final EntityStatus unassignedCompanyProjectsRetrievedStatus;
  final EntityStatus companyToProjectAssignedStatus;
  final EntityStatus companyFromProjectUnassignedStatus;
  final Project? selectedProject;
  final EntityStatus projectsRetrievedStatus;
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
    this.projectsRetrievedStatus = EntityStatus.initial,
    this.projectCrudStatus = EntityStatus.initial,
    this.projectSelectedStatus = EntityStatus.initial,
    this.companyToProjectAssignedStatus = EntityStatus.initial,
    this.companyFromProjectUnassignedStatus = EntityStatus.initial,
    this.assignedCompanyProjectsRetrievedStatus = EntityStatus.initial,
    this.unassignedCompanyProjectsRetrievedStatus = EntityStatus.initial,
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
        projectsRetrievedStatus,
        projectCrudStatus,
        projectSelectedStatus,
        assignedCompanyProjectsRetrievedStatus,
        unassignedCompanyProjectsRetrievedStatus,
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
    EntityStatus? projectsRetrievedStatus,
    EntityStatus? projectSelectedStatus,
    EntityStatus? projectCrudStatus,
    EntityStatus? assignedCompanyProjectsRetrievedStatus,
    EntityStatus? unassignedCompanyProjectsRetrievedStatus,
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
      projectsRetrievedStatus:
          projectsRetrievedStatus ?? this.projectsRetrievedStatus,
      projectSelectedStatus:
          projectSelectedStatus ?? this.projectSelectedStatus,
      projectCrudStatus: projectCrudStatus ?? this.projectCrudStatus,
      assignedCompanyProjectsRetrievedStatus:
          assignedCompanyProjectsRetrievedStatus ??
              this.assignedCompanyProjectsRetrievedStatus,
      unassignedCompanyProjectsRetrievedStatus:
          unassignedCompanyProjectsRetrievedStatus ??
              this.unassignedCompanyProjectsRetrievedStatus,
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
