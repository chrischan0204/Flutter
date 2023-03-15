// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'regions_bloc.dart';

class RegionsState extends Equatable {
  final List<Region> regions;
  final List<String> worldRegions;
  final List<String> timeZones;
  final EntityStatus status;
  const RegionsState({
    this.regions = const [],
    this.status = EntityStatus.initial,
    this.worldRegions = const [],
    this.timeZones = const [],
  });

  @override
  List<Object> get props => [
        regions,
        status,
        worldRegions,
        timeZones,
      ];

  RegionsState copyWith({
    List<Region>? regions,
    List<String>? worldRegions,
    List<String>? timeZones,
    EntityStatus? status,
  }) {
    return RegionsState(
      regions: regions ?? this.regions,
      worldRegions: worldRegions ?? this.worldRegions,
      timeZones: timeZones ?? this.timeZones,
      status: status ?? this.status,
    );
  }
}
