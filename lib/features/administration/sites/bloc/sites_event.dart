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
