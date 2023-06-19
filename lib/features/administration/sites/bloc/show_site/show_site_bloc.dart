import '/common_libraries.dart';

part 'show_site_event.dart';
part 'show_site_state.dart';

class ShowSiteBloc extends Bloc<ShowSiteEvent, ShowSiteState> {
  final SitesRepository sitesRepository;

  static String deleteErrorMessage =
      'There was an error while deleting site. Our team has been notified. Please wait a few minutes and try again.';
  ShowSiteBloc({
    required this.sitesRepository,
  }) : super(const ShowSiteState()) {
    on<ShowSiteLoaded>(_onShowSiteLoaded);
    on<ShowSiteAssignedAutitTemplateListLoaded>(
        _onShowSiteAssignedAutitTemplateListLoaded);
    on<ShowSiteDeleted>(_onShowSiteDeleted);
  }

  Future<void> _onShowSiteLoaded(
    ShowSiteLoaded event,
    Emitter<ShowSiteState> emit,
  ) async {
    emit(state.copyWith(siteLoadStatus: EntityStatus.loading));

    try {
      final Site site = await sitesRepository.getSiteById(event.id);

      emit(state.copyWith(
        siteLoadStatus: EntityStatus.success,
        site: site,
      ));
    } catch (e) {
      emit(state.copyWith(siteLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onShowSiteAssignedAutitTemplateListLoaded(
    ShowSiteAssignedAutitTemplateListLoaded event,
    Emitter<ShowSiteState> emit,
  ) async {
    emit(state.copyWith(auditTemplateListLoadStatus: EntityStatus.loading));

    try {
      final List<Template> auditTemplateList =
          await sitesRepository.getAuditTemlateList(event.id, true);

      emit(state.copyWith(
        auditTemplateListLoadStatus: EntityStatus.success,
        auditTemplateList: auditTemplateList,
      ));
    } catch (e) {
      emit(state.copyWith(auditTemplateListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onShowSiteDeleted(
    ShowSiteDeleted event,
    Emitter<ShowSiteState> emit,
  ) async {
    emit(state.copyWith(deleteStatus: EntityStatus.loading));
    try {
      EntityResponse response = await sitesRepository.deleteSite(event.id);
      if (response.isSuccess) {
        emit(state.copyWith(
          deleteStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          deleteStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        deleteStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }
}
