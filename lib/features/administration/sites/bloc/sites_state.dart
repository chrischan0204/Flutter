// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sites_bloc.dart';

class SitesState extends Equatable {
  final List<Site> sites;
  final Site? selectedSite;
  final List<AuditTemplate> templates;
  final EntityStatus sitesRetrievedStatus;
  final EntityStatus siteSelectedStatus;
  final EntityStatus siteCrudStatus;
  final String message;
  final int totalRows;

  const SitesState({
    this.sites = const [],
    this.totalRows = 0,
    this.selectedSite,
    this.message = '',
    this.templates = const [],
    this.sitesRetrievedStatus = EntityStatus.initial,
    this.siteSelectedStatus = EntityStatus.initial,
    this.siteCrudStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        sites,
        selectedSite,
        message,
        templates,
        sitesRetrievedStatus,
        siteSelectedStatus,
        siteCrudStatus,
        totalRows,
      ];

  SitesState copyWith({
    List<Site>? sites,
    Site? selectedSite,
    String? message,
    List<AuditTemplate>? templates,
    EntityStatus? sitesRetrievedStatus,
    EntityStatus? siteSelectedStatus,
    EntityStatus? siteCrudStatus,
    int? totalRows,
  }) {
    return SitesState(
      sites: sites ?? this.sites,
      selectedSite: selectedSite ?? this.selectedSite,
      message: message ?? this.message,
      templates: templates ?? this.templates,
      sitesRetrievedStatus: sitesRetrievedStatus ?? this.sitesRetrievedStatus,
      siteSelectedStatus: siteSelectedStatus ?? this.siteSelectedStatus,
      siteCrudStatus: siteCrudStatus ?? this.siteCrudStatus,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
