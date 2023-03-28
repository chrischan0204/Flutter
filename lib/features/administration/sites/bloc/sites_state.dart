// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sites_bloc.dart';

class SitesState extends Equatable {
  final List<Site> sites;
  final Site? selectedSite;
  final EntityStatus sitesRetrievedStatus;

  const SitesState({
    this.sites = const [],
    this.selectedSite,
    this.sitesRetrievedStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        sites,
        selectedSite,
        sitesRetrievedStatus,
      ];

  SitesState copyWith({
    List<Site>? sites,
    Site? selectedSite,
    EntityStatus? sitesRetrievedStatus,
  }) {
    return SitesState(
      sites: sites ?? this.sites,
      selectedSite: selectedSite ?? this.selectedSite,
      sitesRetrievedStatus: sitesRetrievedStatus ?? this.sitesRetrievedStatus,
    );
  }
}
