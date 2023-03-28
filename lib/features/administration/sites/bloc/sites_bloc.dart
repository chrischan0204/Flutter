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
  }

  Future<void> _onSitesRetrieved(
    SitesRetrieved event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(sitesRetrievedStatus: EntityStatus.loading));
    try {
      List<Site> sites = await sitesRepository.getSites();
      emit(state.copyWith(
          sites: sites, sitesRetrievedStatus: EntityStatus.succuess));
    } catch (e) {
      emit(state.copyWith(sitesRetrievedStatus: EntityStatus.failure));
    }
  }
}
