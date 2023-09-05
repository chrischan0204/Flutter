import '/common_libraries.dart';

part 'show_site_event.dart';
part 'show_site_state.dart';

class ShowSiteBloc extends Bloc<ShowSiteEvent, ShowSiteState> {
  final SitesRepository sitesRepository;

  static String deleteErrorMessage = ErrorMessage('site').delete;
  ShowSiteBloc({
    required this.sitesRepository,
  }) : super(const ShowSiteState()) {
    on<ShowSiteLoaded>(_onShowSiteLoaded);
    on<ShowSiteAssignedAutitTemplateListLoaded>(
        _onShowSiteAssignedAutitTemplateListLoaded);
    on<ShowSiteAssignedAutitProjectListLoaded>(
        _onShowSiteAssignedAutitProjectListLoaded);
    on<ShowSiteAssignedAutitCompanyListLoaded>(
        _onShowSiteAssignedAutitCompanyListLoaded);
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
    emit(state.copyWith(listLoadStatus: EntityStatus.loading));

    try {
      final List<Template> auditTemplateList =
          await sitesRepository.getAuditTemlateList(event.id, true);

      emit(state.copyWith(
        listLoadStatus: EntityStatus.success,
        auditTemplateList: auditTemplateList,
      ));
    } catch (e) {
      emit(state.copyWith(listLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onShowSiteAssignedAutitProjectListLoaded(
    ShowSiteAssignedAutitProjectListLoaded event,
    Emitter<ShowSiteState> emit,
  ) async {
    emit(state.copyWith(listLoadStatus: EntityStatus.loading));

    try {
      final List<Project> projectList =
          await sitesRepository.getProjectListForSite(event.id);

      emit(state.copyWith(
        listLoadStatus: EntityStatus.success,
        projectList: projectList,
      ));
    } catch (e) {
      emit(state.copyWith(listLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onShowSiteAssignedAutitCompanyListLoaded(
    ShowSiteAssignedAutitCompanyListLoaded event,
    Emitter<ShowSiteState> emit,
  ) async {
    emit(state.copyWith(listLoadStatus: EntityStatus.loading));

    try {
      final List<CompanySite> companySiteList =
          await sitesRepository.getCompanyListForSite(event.id);

      emit(state.copyWith(
        listLoadStatus: EntityStatus.success,
        companyList: companySiteList
            .map((e) => Company(
                  id: e.companyId,
                  name: e.companyName,
                  createdByUserName: e.createdByUserName,
                  createdOn: e.createdOn,
                ))
            .toList(),
      ));
    } catch (e) {
      emit(state.copyWith(listLoadStatus: EntityStatus.failure));
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
