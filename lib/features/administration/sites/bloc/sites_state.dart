// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sites_bloc.dart';

class SitesState extends Equatable {
  final List<Site> sites;
  final EntityStatus sitesRetrievedStatus;

  const SitesState({
    this.sites = const [],
    this.sitesRetrievedStatus = EntityStatus.initial,
  });

  @override
  List<Object> get props => [
        sites,
        sitesRetrievedStatus,
      ];

  SitesState copyWith({
    List<Site>? sites,
    EntityStatus? sitesRetrievedStatus,
  }) {
    return SitesState(
      sites: sites ?? this.sites,
      sitesRetrievedStatus: sitesRetrievedStatus ?? this.sitesRetrievedStatus,
    );
  }
}
