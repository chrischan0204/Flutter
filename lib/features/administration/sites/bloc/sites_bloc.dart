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
    on<AuditTemplatesRetrieved>(_onAuditTemplatesRetrieved);
    on<AuditTemplateAssignedToSite>(_onAuditTemplateAssignedToSite);
    on<SiteAdded>(_onSiteAdded);
    on<SiteEdited>(_onSiteEdited);
    on<SiteDeleted>(_onSiteDeleted);
    on<SitesStatusInited>(_onSitesStatusInited);
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
        sitesRetrievedStatus: EntityStatus.success,
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

  Future<void> _onAuditTemplatesRetrieved(
    AuditTemplatesRetrieved event,
    Emitter<SitesState> emit,
  ) async {
    List<AuditTemplate> templates = <AuditTemplate>[
      AuditTemplate(
          id: '1',
          name: 'Electric Wiring Audit',
          createdBy: 'Adam Drobot',
          lastRevisedOn: '3rd Oct 2022',
          templateDescription: ''),
      AuditTemplate(
          id: '2',
          name: 'Kitchen floor inspection',
          createdBy: 'Kenny Cross',
          lastRevisedOn: '23rd Apr 2020',
          templateDescription: ''),
      AuditTemplate(
          id: '3',
          name: 'Parking lot frozen',
          createdBy: 'Carl Adams',
          lastRevisedOn: '13th Feb 2022',
          templateDescription: ''),
      AuditTemplate(
          id: '4',
          name: 'AC unit leakage',
          createdBy: 'Peter Gittleman',
          lastRevisedOn: '19th Sep 2021',
          templateDescription: ''),
      AuditTemplate(
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

  void _onSiteAdded(SiteAdded event, Emitter<SitesState> emit) async {
    emit(state.copyWith(siteCrudStatus: EntityStatus.loading));
    try {
      String message = await sitesRepository.addSite(event.site);
      emit(state.copyWith(
        siteCrudStatus: EntityStatus.success,
        message: message,
        selectedSite: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        siteCrudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onSiteEdited(SiteEdited event, Emitter<SitesState> emit) async {
    emit(state.copyWith(siteCrudStatus: EntityStatus.loading));
    try {
      String message = await sitesRepository.editSite(event.site);
      emit(state.copyWith(
        siteCrudStatus: EntityStatus.success,
        message: message,
      ));
    } catch (e) {
      emit(state.copyWith(
        siteCrudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onSiteDeleted(SiteDeleted event, Emitter<SitesState> emit) async {
    emit(state.copyWith(siteCrudStatus: EntityStatus.loading));
    try {
      String message = await sitesRepository.deleteSite(event.siteId);
      emit(state.copyWith(
        siteCrudStatus: EntityStatus.success,
        selectedSite: null,
        message: message,
      ));
    } catch (e) {
      emit(state.copyWith(
        siteCrudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onSitesStatusInited(SitesStatusInited event, Emitter<SitesState> emit) {
    emit(
      state.copyWith(
        siteCrudStatus: EntityStatus.initial,
        siteSelectedStatus: EntityStatus.initial,
        sitesRetrievedStatus: EntityStatus.initial,
        message: '',
      ),
    );
  }
}
