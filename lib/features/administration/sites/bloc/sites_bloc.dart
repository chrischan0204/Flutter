import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/model/model.dart';
import '/data/repository/repository.dart';

part 'sites_event.dart';
part 'sites_state.dart';

class SitesBloc extends Bloc<SitesEvent, SitesState> {
  final SitesRepository sitesRepository;

  static String addErrorMessage =
      'There was an error while adding site. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing site. Our team has been notified. Please wait a few minutes and try again.';
  
  SitesBloc({
    required this.sitesRepository,
  }) : super(const SitesState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<SitesRetrieved>(_onSitesRetrieved);
    on<SiteListFiltered>(_onSiteListFiltered);
    on<SiteSelected>(_onSiteSelected);
    on<SiteSelectedById>(_onSiteSelectedById);
    on<AuditTemplatesRetrieved>(_onAuditTemplatesRetrieved);
    on<AuditTemplateAssignedToSite>(_onAuditTemplateAssignedToSite);
    on<SiteAdded>(_onSiteAdded);
    on<SiteEdited>(_onSiteEdited);
    
    on<SitesStatusInited>(_onSitesStatusInited);
  }

  Future<void> _onSitesRetrieved(
    SitesRetrieved event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(sitesRetrievedStatus: EntityStatus.loading));
    try {
      List<Site> sites = await sitesRepository.getSiteList();
      emit(state.copyWith(
        sites: sites,
        sitesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(sitesRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onSiteListFiltered(
    SiteListFiltered event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(sitesRetrievedStatus: EntityStatus.loading));

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
      EntityResponse response = await sitesRepository.addSite(event.site);
      if (response.isSuccess) {
        emit(state.copyWith(
          siteCrudStatus: EntityStatus.success,
          message: response.message,
          selectedSite: state.selectedSite!.copyWith(id: response.data!.id),
        ));
      } else {
        emit(state.copyWith(
          siteCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        siteCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  void _onSiteEdited(SiteEdited event, Emitter<SitesState> emit) async {
    emit(state.copyWith(siteCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response = await sitesRepository.editSite(event.site);
      if (response.isSuccess) {
        emit(state.copyWith(
          siteCrudStatus: EntityStatus.success,
          message: response.message,
          selectedSite: state.selectedSite!.copyWith(id: response.data!.id),
        ));
      } else {
        emit(state.copyWith(
          siteCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        siteCrudStatus: EntityStatus.failure,
        message: editErrorMessage,
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
