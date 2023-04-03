import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/model/model.dart';
import '/data/repository/repository.dart';

part 'sites_event.dart';
part 'sites_state.dart';

class SitesBloc extends Bloc<SitesEvent, SitesState> {
  final SitesRepository sitesRepository;
  SitesBloc({
    required this.sitesRepository,
  }) : super(const SitesState()) {
    on<SitesRetrieved>(_onSitesRetrieved);
    on<SiteSelected>(_onSiteSelected);
    on<SiteSelectedById>(_onSiteSelectedById);
  }

  Future<void> _onSitesRetrieved(
    SitesRetrieved event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(sitesRetrievedStatus: EntityStatus.loading));
    try {
      List<Site> sites = await sitesRepository.getSites();
      emit(state.copyWith(
        sites: sites,
        sitesRetrievedStatus: EntityStatus.succuess,
      ));
    } catch (e) {
      emit(state.copyWith(sitesRetrievedStatus: EntityStatus.failure));
    }
  }

  void _onSiteSelected(SiteSelected event, Emitter<SitesState> emit) {
    emit(state.copyWith(selectedSite: event.selectedSite));
  }

  Future<void> _onSiteSelectedById(
    SiteSelectedById event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(
      siteSelectedStatus: EntityStatus.loading,
      selectedSite: null,
    ));
    try {
      Site selectedSite = await sitesRepository.getSiteById(event.siteId);
      emit(state.copyWith(
        siteSelectedStatus: EntityStatus.loading,
        selectedSite: selectedSite,
      ));
    } catch (e) {
      emit(state.copyWith(
        siteSelectedStatus: EntityStatus.failure,
        selectedSite: null,
      ));
    }
  }
}
