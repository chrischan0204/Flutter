part of 'projects_bloc.dart';

class ProjectsState extends Equatable {
  final List<Project> projects;
  final List<ProjectCompany> projectCompanies;
  final EntityStatus projectCompaniesRetrievedStatus;
  final Project? selectedProject;
  final EntityStatus projectsRetrievedStatus;
  final EntityStatus projectSelectedStatus;
  final EntityStatus projectCrudStatus;
  final String message;
  const ProjectsState({
    this.projects = const [],
    this.projectCompanies = const [],
    this.selectedProject,
    this.projectsRetrievedStatus = EntityStatus.initial,
    this.projectCrudStatus = EntityStatus.initial,
    this.projectSelectedStatus = EntityStatus.initial,
    this.projectCompaniesRetrievedStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        projects,
        projectCompanies,
        selectedProject,
        projectsRetrievedStatus,
        projectCrudStatus,
        projectSelectedStatus,
        projectCompaniesRetrievedStatus,
        message,
      ];

  ProjectsState copyWith({
    List<Project>? projects,
    List<ProjectCompany>? projectCompanies,
    Project? selectedProject,
    EntityStatus? projectsRetrievedStatus,
    EntityStatus? projectSelectedStatus,
    EntityStatus? projectCrudStatus,
    EntityStatus? projectCompaniesRetrievedStatus,
    String? message,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      projectCompanies: projectCompanies ?? this.projectCompanies,
      selectedProject: selectedProject ?? this.selectedProject,
      projectsRetrievedStatus:
          projectsRetrievedStatus ?? this.projectsRetrievedStatus,
      projectSelectedStatus:
          projectSelectedStatus ?? this.projectSelectedStatus,
      projectCrudStatus: projectCrudStatus ?? this.projectCrudStatus,
      projectCompaniesRetrievedStatus: projectCompaniesRetrievedStatus ??
          this.projectCompaniesRetrievedStatus,
      message: message ?? this.message,
    );
  }
}
