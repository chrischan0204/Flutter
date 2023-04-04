part of 'projects_bloc.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];
}

class ProjectsRetrieved extends ProjectsEvent {}

class ProjectSelected extends ProjectsEvent {
  final Project? selectedProject;
  const ProjectSelected({
    required this.selectedProject,
  });
}

class ProjectSelectedById extends ProjectsEvent {
  final String projectId;
  const ProjectSelectedById({
    required this.projectId,
  });
}

class ProjectAdded extends ProjectsEvent {
  final Project project;
  const ProjectAdded({
    required this.project,
  });
}

class ProjectDeleted extends ProjectsEvent {
  final String projectId;
  const ProjectDeleted({
    required this.projectId,
  });
}

class ProjectsStatusInited extends ProjectsEvent {}
