part of 'projects_bloc.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object?> get props => [];
}

/// event to load project list
class ProjectsLoaded extends ProjectsEvent {}

class ProjectListFiltered extends ProjectsEvent {
  final FilteredTableParameter option;
  const ProjectListFiltered({required this.option});

  @override
  List<Object?> get props => [option];
}

/// event to select project
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

/// event to load project for detail
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

/// event to delete project by id
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

/// event to sort project list
class ProjectsSorted extends ProjectsEvent {
  final List<Project> projects;
  const ProjectsSorted({
    required this.projects,
  });

  @override
  List<Object?> get props => [
        projects,
      ];
}

/// event to load assigned company list for project
class AssignedCompanyProjectsLoaded extends ProjectsEvent {
  final String projectId;
  final String? name;
  const AssignedCompanyProjectsLoaded({
    required this.projectId,
    this.name,
  });
}

/// event to load unassigned company list for project
class UnassignedCompanyProjectsLoaded extends ProjectsEvent {
  final String projectId;
  final String? name;
  const UnassignedCompanyProjectsLoaded({
    required this.projectId,
    this.name,
  });
}

/// event to init status of project
class ProjectsStatusInited extends ProjectsEvent {}

/// event to change filter text to filter unassigned company list
class FilterTextForUnassignedCompanyChanged extends ProjectsEvent {
  final String filterText;
  const FilterTextForUnassignedCompanyChanged({
    required this.filterText,
  });

  @override
  List<Object?> get props => [
        filterText,
      ];
}
/// event to change filter text to filter assigned company list
class FilterTextForAssignedCompanyChanged extends ProjectsEvent {
  final String filterText;
  const FilterTextForAssignedCompanyChanged({
    required this.filterText,
  });

  @override
  List<Object?> get props => [
        filterText,
      ];
}

/// event to assign company to project
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

/// event to unassign company from project
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

/// event to select role to assign company to project
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
