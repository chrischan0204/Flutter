// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'projects_bloc.dart';

class ProjectsState extends Equatable {
  final List<Project> projects;
  final Project? selectedProject;
  final EntityStatus projectsRetrievedStatus;
  final EntityStatus projectSelectedStatus;
  final EntityStatus projectCrudStatus;
  final String message;
  const ProjectsState({
    this.projects = const [],
    this.selectedProject,
    this.projectsRetrievedStatus = EntityStatus.initial,
    this.projectCrudStatus = EntityStatus.initial,
    this.projectSelectedStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        projects,
        selectedProject,
        projectsRetrievedStatus,
        projectCrudStatus,
        projectSelectedStatus,
        message,
      ];

  ProjectsState copyWith({
    List<Project>? projects,
    Project? selectedProject,
    EntityStatus? projectsRetrievedStatus,
    EntityStatus? projectSelectedStatus,
    EntityStatus? projectCrudStatus,
    String? message,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      projectsRetrievedStatus:
          projectsRetrievedStatus ?? this.projectsRetrievedStatus,
      projectSelectedStatus:
          projectSelectedStatus ?? this.projectSelectedStatus,
      projectCrudStatus: projectCrudStatus ?? this.projectCrudStatus,
      message: message ?? this.message,
    );
  }
}
