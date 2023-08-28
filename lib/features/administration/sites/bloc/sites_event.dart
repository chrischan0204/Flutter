part of 'sites_bloc.dart';

abstract class SitesEvent extends Equatable {
  const SitesEvent();

  @override
  List<Object?> get props => [];
}

/// event to load site list
class SitesLoaded extends SitesEvent {}

class SiteListFiltered extends SitesEvent {
  final FilteredTableParameter option;
  const SiteListFiltered({required this.option});

  @override
  List<Object?> get props => [option];
}

/// event to select site for side detail
class SiteSelected extends SitesEvent {
  final Site? selectedSite;
  const SiteSelected({
    required this.selectedSite,
  });
}

/// event to load site detail by id
class SiteSelectedById extends SitesEvent {
  final String siteId;
  const SiteSelectedById({
    required this.siteId,
  });
}

/// event to add new site
class SiteAdded extends SitesEvent {
  final Site site;
  const SiteAdded({
    required this.site,
  });
}

/// event to edit site 
class SiteEdited extends SitesEvent {
  final Site site;
  const SiteEdited({
    required this.site,
  });
}

/// event to delete site by id
class SiteDeleted extends SitesEvent {
  final String siteId;
  const SiteDeleted({
    required this.siteId,
  });
}
/// event to init status of site
class SitesStatusInited extends SitesEvent {}

/// event to load template list
class AuditTemplatesLoaded extends SitesEvent {}

/// event to assign template to site
class AuditTemplateAssignedToSite extends SitesEvent {
  final String auditTemplateId;
  const AuditTemplateAssignedToSite({
    required this.auditTemplateId,
  });
}
