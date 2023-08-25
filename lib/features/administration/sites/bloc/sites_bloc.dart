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
    _triggerEvents();
  }

  void _triggerEvents() {
    on<SitesLoaded>(_onSitesLoaded);
    on<SiteListFiltered>(_onSiteListFiltered);
    on<SiteSelected>(_onSiteSelected);
    on<SiteSelectedById>(_onSiteSelectedById);
    on<AuditTemplatesLoaded>(_onAuditTemplatesLoaded);
    on<AuditTemplateAssignedToSite>(_onAuditTemplateAssignedToSite);

    on<SitesStatusInited>(_onSitesStatusInited);
  }

  Future<void> _onSitesLoaded(
    SitesLoaded event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(sitesLoadedStatus: EntityStatus.loading));
    try {
      List<Site> sites = await sitesRepository.getSiteList();
      emit(state.copyWith(
        sites: sites,
        sitesLoadedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(sitesLoadedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onSiteListFiltered(
    SiteListFiltered event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(sitesLoadedStatus: EntityStatus.loading));

    try {
      FilteredSiteData data =
          await sitesRepository.getFilteredSiteList(event.option);
      final List<String> columns =
          List.from(data.headers.where((e) => !e.isHidden).map((e) => e.title));

      emit(state.copyWith(
        totalRows: data.totalRows,
        sites: (data.data)
            .map((e) => e.toSite().copyWith(columns: columns))
            .toList(),
        sitesLoadedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(sitesLoadedStatus: EntityStatus.failure));
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
    ));
    try {
      Site selectedSite = await sitesRepository.getSiteById(event.siteId);
      emit(state.copyWith(
        siteSelectedStatus: EntityStatus.success,
        selectedSite: selectedSite.copyWith(id: event.siteId),
      ));
    } catch (e) {
      emit(state.copyWith(
        siteSelectedStatus: EntityStatus.failure,
        selectedSite: null,
      ));
    }
  }

  Future<void> _onAuditTemplatesLoaded(
    AuditTemplatesLoaded event,
    Emitter<SitesState> emit,
  ) async {
    List<AuditTemplate> templates = <AuditTemplate>[
      const AuditTemplate(
          id: '1',
          name: 'Electric Wiring Audit',
          createdBy: 'Adam Drobot',
          lastRevisedOn: '3rd Oct 2022',
          templateDescription: ''),
      const AuditTemplate(
          id: '2',
          name: 'Kitchen floor inspection',
          createdBy: 'Kenny Cross',
          lastRevisedOn: '23rd Apr 2020',
          templateDescription: ''),
      const AuditTemplate(
          id: '3',
          name: 'Parking lot frozen',
          createdBy: 'Carl Adams',
          lastRevisedOn: '13th Feb 2022',
          templateDescription: ''),
      const AuditTemplate(
          id: '4',
          name: 'AC unit leakage',
          createdBy: 'Peter Gittleman',
          lastRevisedOn: '19th Sep 2021',
          templateDescription: ''),
      const AuditTemplate(
          id: '5',
          name: 'Cafeteria Gas Check',
          createdBy: 'Prince Bogotey',
          lastRevisedOn: '4th Oct 2021',
          templateDescription: ''),
    ];
    emit(state.copyWith(templates: templates));
  }

  void _onAuditTemplateAssignedToSite(
    AuditTemplateAssignedToSite event,
    Emitter<SitesState> emit,
  ) {
    List<AuditTemplate> templates = List.from(state.templates);

    int index = templates
        .indexWhere((template) => template.id == event.auditTemplateId);
    templates.fillRange(index, index + 1,
        templates[index].copyWith(assigned: !templates[index].assigned));
    emit(state.copyWith(templates: templates));
  }

  void _onSitesStatusInited(SitesStatusInited event, Emitter<SitesState> emit) {
    emit(
      state.copyWith(
        siteCrudStatus: EntityStatus.initial,
        siteSelectedStatus: EntityStatus.initial,
        sitesLoadedStatus: EntityStatus.initial,
        message: '',
      ),
    );
  }
}
