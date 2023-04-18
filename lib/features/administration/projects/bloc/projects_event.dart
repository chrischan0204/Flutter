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

class AssignedCompanyProjectsRetrieved extends ProjectsEvent {
  final String projectId;
  final String? name;
  const AssignedCompanyProjectsRetrieved({
    required this.projectId,
    this.name,
  });
}

class UnassignedCompanyProjectsRetrieved extends ProjectsEvent {
  final String projectId;
  final String? name;
  const UnassignedCompanyProjectsRetrieved({
    required this.projectId,
    this.name,
  });
}

class ProjectsStatusInited extends ProjectsEvent {}

class FilterTextForCompanyChanged extends ProjectsEvent {
  final String filterText;
  const FilterTextForCompanyChanged({
    required this.filterText,
  });

  @override
  List<Object?> get props => [
        filterText,
      ];
}

class CompanyToProjectAssigned extends ProjectsEvent {
  final ProjectCompanyAssignment projectCompanyAssignment;
  const CompanyToProjectAssigned({
    required this.projectCompanyAssignment,
  });
  @override
  List<Object?> get props => [
        projectCompanyAssignment,
      ];
}

class CompanyFromProjectUnassigned extends ProjectsEvent {
  final String projectCompanyAssignmentId;
  const CompanyFromProjectUnassigned({
    required this.projectCompanyAssignmentId,
  });
  @override
  List<Object?> get props => [
        projectCompanyAssignmentId,
      ];
}

class UnAssignedCompanyProjectRoleSelected extends ProjectsEvent {
  final Role role;
  final int projectCompanyIndex;
  const UnAssignedCompanyProjectRoleSelected({
    required this.role,
    required this.projectCompanyIndex,
  });

  @override
  List<Object?> get props => [
        role,
        projectCompanyIndex,
      ];
}
