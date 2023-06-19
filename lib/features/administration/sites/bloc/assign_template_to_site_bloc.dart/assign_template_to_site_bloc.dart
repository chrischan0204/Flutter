import '/common_libraries.dart';

part 'assign_template_to_site_event.dart';
part 'assign_template_to_site_state.dart';

class AssignTemplateToSiteBloc
    extends Bloc<AssignTemplateToSiteEvent, AssignTemplateToSiteState> {
  SitesRepository sitesRepository;

  AssignTemplateToSiteBloc({
    required this.sitesRepository,
  }) : super(const AssignTemplateToSiteState()) {
    on<AssignTemplateToSiteAssignedAuditTemplateListLoaded>(
        _onAssignTemplateToSiteAssignedAuditTemplateListLoaded);
    on<AssignTemplateToSiteUnassignedAuditTemplateListLoaded>(
        _onAssignTemplateToSiteUnassignedAuditTemplateListLoaded);
    on<AssignTemplateToSiteToggleAssigned>(
        _onAssignTemplateToSiteToggleAssigned);
  }

  Future<void> _onAssignTemplateToSiteAssignedAuditTemplateListLoaded(
    AssignTemplateToSiteAssignedAuditTemplateListLoaded event,
    Emitter<AssignTemplateToSiteState> emit,
  ) async {
    try {
      final List<Template> assignedAuditTemplateList =
          await sitesRepository.getAuditTemlateList(event.id, true);

      emit(
          state.copyWith(assignedAuditTemplateList: assignedAuditTemplateList));
    } catch (e) {}
  }

  Future<void> _onAssignTemplateToSiteUnassignedAuditTemplateListLoaded(
    AssignTemplateToSiteUnassignedAuditTemplateListLoaded event,
    Emitter<AssignTemplateToSiteState> emit,
  ) async {
    try {
      final List<Template> unassignedAuditTemplateList =
          await sitesRepository.getAuditTemlateList(event.id, false);

      emit(state.copyWith(
        unassignedAuditTemplateList: unassignedAuditTemplateList,
      ));
    } catch (e) {}
  }

  Future<void> _onAssignTemplateToSiteToggleAssigned(
    AssignTemplateToSiteToggleAssigned event,
    Emitter<AssignTemplateToSiteState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      EntityResponse response = await sitesRepository
          .toggleAssignTemplateToSite(event.templateSiteAssignment);
      emit(state.copyWith(
        message: response.message,
        status: response.isSuccess.toEntityStatusCode(),
      ));
    } catch (e) {
      emit(state.copyWith(
        message: 'Something went wrong',
        status: EntityStatus.failure,
      ));
    }
  }
}
