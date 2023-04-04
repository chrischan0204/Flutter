import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/repository/repository.dart';
import '/data/model/model.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsRepository projectsRepository;
  ProjectsBloc({
    required this.projectsRepository,
  }) : super(const ProjectsState()) {
    on<ProjectsRetrieved>(_onProjectsRetrieved);
    on<ProjectSelected>(_onProjectSelected);
    on<ProjectSelectedById>(_onProjectSelectedById);
    // on<AuditTemplatesRetrieved>(_onAuditTemplatesRetrieved);
    // on<AuditTemplateAssignedToProject>(_onAuditTemplateAssignedToProject);
    on<ProjectAdded>(_onProjectAdded);
    on<ProjectDeleted>(_onProjectDeleted);
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
      print(e);
      emit(state.copyWith(projectsRetrievedStatus: EntityStatus.failure));
    }
  }

  void _onProjectSelected(ProjectSelected event, Emitter<ProjectsState> emit) {
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

  // Future<void> _onAuditTemplatesRetrieved(
  //   AuditTemplatesRetrieved event,
  //   Emitter<ProjectsState> emit,
  // ) async {
  //   List<AuditTemplate> templates = <AuditTemplate>[
  //     AuditTemplate(
  //         id: '1',
  //         name: 'Electric Wiring Audit',
  //         createdBy: 'Adam Drobot',
  //         lastRevisedOn: '3rd Oct 2022',
  //         templateDescription: ''),
  //     AuditTemplate(
  //         id: '2',
  //         name: 'Kitchen floor inspection',
  //         createdBy: 'Kenny Cross',
  //         lastRevisedOn: '23rd Apr 2020',
  //         templateDescription: ''),
  //     AuditTemplate(
  //         id: '3',
  //         name: 'Parking lot frozen',
  //         createdBy: 'Carl Adams',
  //         lastRevisedOn: '13th Feb 2022',
  //         templateDescription: ''),
  //     AuditTemplate(
  //         id: '4',
  //         name: 'AC unit leakage',
  //         createdBy: 'Peter Gittleman',
  //         lastRevisedOn: '19th Sep 2021',
  //         templateDescription: ''),
  //     AuditTemplate(
  //         id: '5',
  //         name: 'Cafeteria Gas Check',
  //         createdBy: 'Prince Bogotey',
  //         lastRevisedOn: '4th Oct 2021',
  //         templateDescription: ''),
  //   ];
  //   emit(state.copyWith(templates: templates));
  // }

  // void _onAuditTemplateAssignedToProject(
  //   AuditTemplateAssignedToProject event,
  //   Emitter<ProjectsState> emit,
  // ) {
  //   List<AuditTemplate> templates = List.from(state.templates);

  //   int index = templates
  //       .indexWhere((template) => template.id == event.auditTemplateId);
  //   templates.fillRange(index, index + 1,
  //       templates[index].copyWith(assigned: !templates[index].assigned));
  //   emit(state.copyWith(templates: templates));
  // }

  void _onProjectAdded(ProjectAdded event, Emitter<ProjectsState> emit) async {
    emit(state.copyWith(projectCrudStatus: EntityStatus.loading));
    try {
      String message = await projectsRepository.addProject(event.project);
      emit(state.copyWith(
        projectCrudStatus: EntityStatus.success,
        message: message,
      ));
    } catch (e) {
      emit(state.copyWith(
        projectCrudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onProjectDeleted(
      ProjectDeleted event, Emitter<ProjectsState> emit) async {
    emit(state.copyWith(projectCrudStatus: EntityStatus.loading));
    try {
      String message = await projectsRepository.deleteProject(event.projectId);
      emit(state.copyWith(
        projectCrudStatus: EntityStatus.success,
        selectedProject: null,
        message: message,
      ));
    } catch (e) {
      emit(state.copyWith(
        projectCrudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onProjectsStatusInited(
      ProjectsStatusInited event, Emitter<ProjectsState> emit) {
    emit(
      state.copyWith(
        projectCrudStatus: EntityStatus.initial,
        projectSelectedStatus: EntityStatus.initial,
        projectsRetrievedStatus: EntityStatus.initial,
        message: '',
      ),
    );
  }
}
