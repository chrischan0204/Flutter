// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'projects_bloc.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object?> get props => [];
}

class ProjectsRetrieved extends ProjectsEvent {}

class ProjectSelected extends ProjectsEvent {
  final Project? selectedProject;
  const ProjectSelected({
    required this.selectedProject,
  });
  @override
  List<Object?> get props => [
        selectedProject,
      ];
}

class ProjectSelectedById extends ProjectsEvent {
  final String projectId;
  const ProjectSelectedById({
    required this.projectId,
  });
  @override
  List<Object?> get props => [
        projectId,
      ];
}

class ProjectAdded extends ProjectsEvent {
  final Project project;
  const ProjectAdded({
    required this.project,
  });
  @override
  List<Object?> get props => [
        project,
      ];
}

class ProjectEdited extends ProjectsEvent {
  final Project project;
  const ProjectEdited({
    required this.project,
  });
  @override
  List<Object?> get props => [
        project,
      ];
}

class ProjectDeleted extends ProjectsEvent {
  final String projectId;
  const ProjectDeleted({
    required this.projectId,
  });
  @override
  List<Object?> get props => [
        projectId,
      ];
}

class ProjectsSorted extends ProjectsEvent {
  final String column;
  final bool sortType;
  const ProjectsSorted({
    required this.column,
    required this.sortType,
  });

  @override
  List<Object?> get props => [
        column,
        sortType,
      ];
}

class ProjectsStatusInited extends ProjectsEvent {}
