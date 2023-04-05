part of 'sites_bloc.dart';

abstract class SitesEvent extends Equatable {
  const SitesEvent();

  @override
  List<Object> get props => [];
}

class SitesRetrieved extends SitesEvent {}

class SiteSelected extends SitesEvent {
  final Site? selectedSite;
  const SiteSelected({
    required this.selectedSite,
  });
}

class SiteSelectedById extends SitesEvent {
  final String siteId;
  const SiteSelectedById({
    required this.siteId,
  });
}

class SiteAdded extends SitesEvent {
  final Site site;
  const SiteAdded({
    required this.site,
  });
}

class SiteEdited extends SitesEvent {
  final Site site;
  const SiteEdited({
    required this.site,
  });
}

class SiteDeleted extends SitesEvent {
  final String siteId;
  const SiteDeleted({
    required this.siteId,
  });
}

class SitesStatusInited extends SitesEvent {}

class AuditTemplatesRetrieved extends SitesEvent {}

class AuditTemplateAssignedToSite extends SitesEvent {
  final String auditTemplateId;
  const AuditTemplateAssignedToSite({
    required this.auditTemplateId,
  });
}
