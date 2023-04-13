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
    on<ProjectCompanyRetrieved>(_onProjectCompaniesRetrieved);
    on<ProjectsStatusInited>(_onProjectsStatusInited);
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

  void _onProjectCompaniesRetrieved(
    ProjectCompanyRetrieved event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(projectCompaniesRetrievedStatus: EntityStatus.loading));
    try {
      List<ProjectCompany> projectCompanies = await projectsRepository
          .getCompaniesForProject(event.projectId, event.assigned, event.name);
      emit(state.copyWith(
        projectCompanies: projectCompanies,
        projectCompaniesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(
          projectCompaniesRetrievedStatus: EntityStatus.failure));
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
}
