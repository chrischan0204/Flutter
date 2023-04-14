import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/repository/repository.dart';
import '/data/model/model.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsRepository projectsRepository;

  static String addErrorMessage =
      'There was an error while adding project. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing project. Our team has been notified. Please wait a few minutes and try again.';
  static String deleteErrorMessage =
      'There was an error while deleting project. Our team has been notified. Please wait a few minutes and try again.';
  ProjectsBloc({
    required this.projectsRepository,
  }) : super(const ProjectsState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<ProjectsRetrieved>(_onProjectsRetrieved);
    on<ProjectSelected>(_onProjectSelected);
    on<ProjectSelectedById>(_onProjectSelectedById);
    on<ProjectAdded>(_onProjectAdded);
    on<ProjectEdited>(_onProjectEdited);
    on<ProjectDeleted>(_onProjectDeleted);
    on<ProjectsSorted>(_onProjectsSorted);
    on<AssignedCompanyProjectsRetrieved>(_onAssignedCompanyProjectsRetrieved);
    on<UnassignedCompanyProjectsRetrieved>(
        _onUnassignedCompanyProjectsRetrieved);
    on<ProjectsStatusInited>(_onProjectsStatusInited);
    on<FilterTextForCompanyChanged>(_onFilterTextForCompanyChanged);
    on<CompanyToProjectAssigned>(_onCompanyToProjectAssigned);
    on<CompanyFromProjectUnassigned>(_onCompanyFromProjectUnassigned);
    on<UnAssignedCompanyProjectRoleSelected>(
        _onUnAssignedCompanyProjectRoleSelected);
  }

  Future<void> _onProjectsRetrieved(
    ProjectsRetrieved event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(projectsRetrievedStatus: EntityStatus.loading));
    try {
      List<Project> projects = await projectsRepository.getProjects();
      emit(state.copyWith(
        projects: projects,
        projectsRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(projectsRetrievedStatus: EntityStatus.failure));
    }
  }

  void _onProjectSelected(
    ProjectSelected event,
    Emitter<ProjectsState> emit,
  ) {
    emit(state.copyWith(selectedProject: event.selectedProject));
  }

  Future<void> _onProjectSelectedById(
    ProjectSelectedById event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(
      projectSelectedStatus: EntityStatus.loading,
    ));
    try {
      Project selectedProject =
          await projectsRepository.getProjectById(event.projectId);
      emit(state.copyWith(
        projectSelectedStatus: EntityStatus.success,
        selectedProject: selectedProject,
      ));
    } catch (e) {
      emit(state.copyWith(
        projectSelectedStatus: EntityStatus.failure,
        selectedProject: null,
      ));
    }
  }

  Future<void> _onProjectAdded(
    ProjectAdded event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(projectCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response =
          await projectsRepository.addProject(event.project);
      if (response.isSuccess) {
        emit(state.copyWith(
          projectCrudStatus: EntityStatus.success,
          message: response.message,
          selectedProject:
              state.selectedProject!.copyWith(id: response.data!.id),
        ));
      } else {
        emit(state.copyWith(
          projectCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        projectCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  Future<void> _onProjectEdited(
    ProjectEdited event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(projectCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response =
          await projectsRepository.editProject(event.project);
      if (response.isSuccess) {
        emit(state.copyWith(
          projectCrudStatus: EntityStatus.success,
          message: response.message,
          selectedProject:
              state.selectedProject!.copyWith(id: response.data!.id),
        ));
      } else {
        emit(state.copyWith(
          projectCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        projectCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  Future<void> _onProjectDeleted(
    ProjectDeleted event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(projectCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response =
          await projectsRepository.deleteProject(event.projectId);
      if (response.isSuccess) {
        emit(state.copyWith(
          projectCrudStatus: EntityStatus.success,
          selectedProject: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          projectCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        projectCrudStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  void _onAssignedCompanyProjectsRetrieved(
    AssignedCompanyProjectsRetrieved event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(
        assignedCompanyProjectsRetrievedStatus: EntityStatus.loading));
    try {
      List<ProjectCompany> assignedCompanyProjects = await projectsRepository
          .getCompaniesForProject(event.projectId, true, event.name);
      emit(state.copyWith(
        assignedCompanyProjects: assignedCompanyProjects,
        assignedCompanyProjectsRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          assignedCompanyProjectsRetrievedStatus: EntityStatus.failure));
    }
  }

  void _onUnassignedCompanyProjectsRetrieved(
    UnassignedCompanyProjectsRetrieved event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(
        unassignedCompanyProjectsRetrievedStatus: EntityStatus.loading));
    try {
      List<ProjectCompany> unassignedCompanyProjects = await projectsRepository
          .getCompaniesForProject(event.projectId, false, event.name);
      emit(state.copyWith(
        unassignedCompanyProjects: unassignedCompanyProjects,
        unassignedCompanyProjectsRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          unassignedCompanyProjectsRetrievedStatus: EntityStatus.failure));
    }
  }

  void _onProjectsSorted(
    ProjectsSorted event,
    Emitter<ProjectsState> emit,
  ) {
    List<Project> projects = List.from(state.projects);

    projects.sort(
      (a, b) {
        return (event.sortType ? 1 : -1) *
            (a.tableItemsToMap()[event.column].toString())
                .compareTo(b.tableItemsToMap()[event.column].toString());
      },
    );
    emit(state.copyWith(projects: projects));
  }

  void _onProjectsStatusInited(
      ProjectsStatusInited event, Emitter<ProjectsState> emit) {
    emit(
      state.copyWith(
        projectCrudStatus: EntityStatus.initial,
        projectSelectedStatus: EntityStatus.initial,
        projectsRetrievedStatus: EntityStatus.initial,
      ),
    );
  }

  Future<void> _onCompanyToProjectAssigned(
    CompanyToProjectAssigned event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(companyToProjectAssignedStatus: EntityStatus.loading));
    try {
      EntityResponse response = await projectsRepository
          .assignCompanyToProject(event.projectCompanyAssignment);
      if (response.isSuccess) {
        emit(state.copyWith(
          companyToProjectAssignedStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          companyToProjectAssignedStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(
          state.copyWith(companyToProjectAssignedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onCompanyFromProjectUnassigned(
    CompanyFromProjectUnassigned event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(
        companyFromProjectUnassignedStatus: EntityStatus.loading));
    try {
      EntityResponse response = await projectsRepository
          .unassignCompanyFromProject(event.projectCompanyAssignmentId);
      if (response.isSuccess) {
        emit(state.copyWith(
          companyFromProjectUnassignedStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          companyFromProjectUnassignedStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          companyFromProjectUnassignedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUnAssignedCompanyProjectRoleSelected(
    UnAssignedCompanyProjectRoleSelected event,
    Emitter<ProjectsState> emit,
  ) async {
    List<ProjectCompany> unassignedCompanyProjects =
        List.from(state.unassignedCompanyProjects);
    int index = event.projectCompanyIndex;
    unassignedCompanyProjects.replaceRange(index, index + 1, [
      unassignedCompanyProjects[index].copyWith(
        roleId: event.role.id,
        roleName: event.role.name,
      )
    ]);
    emit(state.copyWith(unassignedCompanyProjects: unassignedCompanyProjects));
  }

  void _onFilterTextForCompanyChanged(
    FilterTextForCompanyChanged event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(filterText: event.filterText));
  }
}
