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
    on<AssignTemplateToSiteAssigned>(_onAssignTemplateToSiteAssigned);
    on<AssignTemplateFromSiteUnassigned>(_onAssignTemplateFromSiteUnassigned);
  }

  /// load assigned template list
  Future<void> _onAssignTemplateToSiteAssignedAuditTemplateListLoaded(
    AssignTemplateToSiteAssignedAuditTemplateListLoaded event,
    Emitter<AssignTemplateToSiteState> emit,
  ) async {
    try {
      final List<Template> assignedAuditTemplateList =
          await sitesRepository.getAuditTemlateList(event.id, true);

      emit(state.copyWith(
        assignedAuditTemplateList: assignedAuditTemplateList
            .map((e) => e.copyWith(assigned: true))
            .toList(),
      ));
    } catch (e) {}
  }

  /// load unassigned template list
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

  /// assign template to site
  Future<void> _onAssignTemplateToSiteAssigned(
    AssignTemplateToSiteAssigned event,
    Emitter<AssignTemplateToSiteState> emit,
  ) async {
    emit(state.copyWith(
      status: EntityStatus.loading,
      unassignedAuditTemplateList: state.unassignedAuditTemplateList
          .map((e) => e.id == event.templateId ? e.copyWith(assigned: true) : e)
          .toList(),
    ));

    try {
      EntityResponse response = await sitesRepository
          .toggleAssignTemplateToSite(TemplateSiteAssignment(
        siteId: event.siteId,
        templateId: event.templateId,
        assigned: true,
      ));

      if (!response.isSuccess) {
        emit(state.copyWith(
          message: response.message,
          status: EntityStatus.failure,
          unassignedAuditTemplateList: state.unassignedAuditTemplateList
              .map((e) =>
                  e.id == event.templateId ? e.copyWith(assigned: false) : e)
              .toList(),
        ));
      } else {
        emit(state.copyWith(
          message: response.message,
          status: EntityStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        message: 'Something went wrong',
        status: EntityStatus.failure,
      ));
    }
  }

  /// unassign template from site
  Future<void> _onAssignTemplateFromSiteUnassigned(
    AssignTemplateFromSiteUnassigned event,
    Emitter<AssignTemplateToSiteState> emit,
  ) async {
    emit(state.copyWith(
      status: EntityStatus.loading,
      assignedAuditTemplateList: state.assignedAuditTemplateList
          .map(
              (e) => e.id == event.templateId ? e.copyWith(assigned: false) : e)
          .toList(),
    ));

    try {
      EntityResponse response = await sitesRepository
          .toggleAssignTemplateToSite(TemplateSiteAssignment(
        siteId: event.siteId,
        templateId: event.templateId,
        assigned: false,
      ));

      if (!response.isSuccess) {
        emit(state.copyWith(
          message: response.message,
          status: EntityStatus.failure,
          assignedAuditTemplateList: state.assignedAuditTemplateList
              .map((e) =>
                  e.id == event.templateId ? e.copyWith(assigned: true) : e)
              .toList(),
        ));
      } else {
        emit(state.copyWith(
          message: response.message,
          status: EntityStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        message: 'Something went wrong',
        status: EntityStatus.failure,
      ));
    }
  }
}
