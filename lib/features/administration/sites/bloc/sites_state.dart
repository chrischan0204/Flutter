part of 'sites_bloc.dart';

class SitesState extends Equatable {
  final List<Site> sites;
  final Site? selectedSite;
  final List<AuditTemplate> templates;
  final EntityStatus sitesLoadedStatus;
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
    this.sitesLoadedStatus = EntityStatus.initial,
    this.siteSelectedStatus = EntityStatus.initial,
    this.siteCrudStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        sites,
        selectedSite,
        message,
        templates,
        sitesLoadedStatus,
        siteSelectedStatus,
        siteCrudStatus,
        totalRows,
      ];

  SitesState copyWith({
    List<Site>? sites,
    Site? selectedSite,
    String? message,
    List<AuditTemplate>? templates,
    EntityStatus? sitesLoadedStatus,
    EntityStatus? siteSelectedStatus,
    EntityStatus? siteCrudStatus,
    int? totalRows,
  }) {
    return SitesState(
      sites: sites ?? this.sites,
      selectedSite: selectedSite ?? this.selectedSite,
      message: message ?? this.message,
      templates: templates ?? this.templates,
      sitesLoadedStatus: sitesLoadedStatus ?? this.sitesLoadedStatus,
      siteSelectedStatus: siteSelectedStatus ?? this.siteSelectedStatus,
      siteCrudStatus: siteCrudStatus ?? this.siteCrudStatus,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
