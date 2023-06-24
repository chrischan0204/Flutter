import '/common_libraries.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsRepository projectsRepository;

  static String deleteErrorMessage = ErrorMessage('project').delete;
  static String assignCompanyToProjectErrorMessage =
      ErrorMessage('project').assign('company');
  ProjectsBloc({
    required this.projectsRepository,
  }) : super(const ProjectsState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<ProjectsRetrieved>(_onProjectsRetrieved);
    on<ProjectListFiltered>(_onProjectListFiltered);
    on<ProjectSelected>(_onProjectSelected);
    on<ProjectSelectedById>(_onProjectSelectedById);
    on<ProjectDeleted>(_onProjectDeleted);
    on<ProjectsSorted>(_onProjectsSorted);
    on<AssignedCompanyProjectsRetrieved>(_onAssignedCompanyProjectsRetrieved);
    on<UnassignedCompanyProjectsRetrieved>(
        _onUnassignedCompanyProjectsRetrieved);
    on<ProjectsStatusInited>(_onProjectsStatusInited);
    on<FilterTextForUnassignedCompanyChanged>(
        _onFilterTextForUnassignedCompanyChanged);
    on<FilterTextForAssignedCompanyChanged>(
        _onFilterTextForAssignedCompanyChanged);
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
      List<Project> projects = await projectsRepository.getProjectList();
      emit(state.copyWith(
        projects: projects,
        projectsRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(projectsRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onProjectListFiltered(
    ProjectListFiltered event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(projectsRetrievedStatus: EntityStatus.loading));

    try {
      FilteredProjectData data =
          await projectsRepository.getFilteredProjectList(event.option);
      final List<String> columns =
          List.from(data.headers.where((e) => !e.isHidden).map((e) => e.title));
      emit(state.copyWith(
        totalRows: data.totalRows,
        projects: data.data
            .map((e) => e.toProject().copyWith(columns: columns))
            .toList(),
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
          .getCompanyListForProject(event.projectId, true, event.name);
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
          .getCompanyListForProject(event.projectId, false, event.name);
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
    emit(state.copyWith(projects: event.projects));
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

    final result = state.unassignedCompanyProjects.firstWhere(
      (unassignedCompanyProject) =>
          unassignedCompanyProject.companyId ==
              event.projectCompanyAssignment.companyId &&
          unassignedCompanyProject.roleId ==
              event.projectCompanyAssignment.roleId,
    );

    try {
      result.assigned = true;
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
        result.assigned = false;
      }
    } catch (e) {
      emit(state.copyWith(
        companyToProjectAssignedStatus: EntityStatus.failure,
        message: assignCompanyToProjectErrorMessage,
      ));
      result.assigned = false;
    }
  }

  Future<void> _onCompanyFromProjectUnassigned(
    CompanyFromProjectUnassigned event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(
        companyFromProjectUnassignedStatus: EntityStatus.loading));
    final result = state.assignedCompanyProjects.firstWhere(
        (assignedCompanyProject) =>
            assignedCompanyProject.id == event.projectCompanyAssignmentId);

    try {
      result.assigned = false;
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
        result.assigned = true;
      }
    } catch (e) {
      emit(state.copyWith(
          companyFromProjectUnassignedStatus: EntityStatus.failure));
      result.assigned = true;
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

  void _onFilterTextForUnassignedCompanyChanged(
    FilterTextForUnassignedCompanyChanged event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(filterTextForUnassignedCompany: event.filterText));
  }

  void _onFilterTextForAssignedCompanyChanged(
    FilterTextForAssignedCompanyChanged event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(filterTextForAssignedCompany: event.filterText));
  }
}
