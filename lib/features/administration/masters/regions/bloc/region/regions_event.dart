// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'regions_bloc.dart';

abstract class RegionsEvent extends Equatable {
  const RegionsEvent();

  @override
  List<Object?> get props => [];
}

/// event to load region list
class AssignedRegionsLoaded extends RegionsEvent {}

/// event to load region detail by id
class UnassignedRegionsLoaded extends RegionsEvent {}

class TimeZonesLoadedForRegion extends RegionsEvent {
  final String regionId;
  const TimeZonesLoadedForRegion({
    required this.regionId,
  });
  @override
  List<Object> get props => [
        regionId,
      ];
}

/// event to select region for side detail
class RegionSelected extends RegionsEvent {
  final Region? region;
  const RegionSelected({
    this.region,
  });
  @override
  List<Object?> get props => [
        region,
      ];
}

/// event to load region detail by id
class RegionSelectedById extends RegionsEvent {
  final String regionId;
  const RegionSelectedById({
    required this.regionId,
  });
  @override
  List<Object> get props => [
        regionId,
      ];
}

/// event to  add new region
class RegionAdded extends RegionsEvent {
  final Region region;
  const RegionAdded({
    required this.region,
  });

  @override
  List<Object> get props => [
        region,
      ];
}

/// event to edit region
class RegionEdited extends RegionsEvent {
  final Region region;
  const RegionEdited({
    required this.region,
  });

  @override
  List<Object> get props => [
        region,
      ];
}

/// event to delete region by id
class RegionDeleted extends RegionsEvent {
  final String regionId;
  const RegionDeleted({
    required this.regionId,
  });

  @override
  List<Object> get props => [
        regionId,
      ];
}

/// event to init status of region
class RegionsStatusInited extends RegionsEvent {
  const RegionsStatusInited();
}

/// event to init time zone
class RegionsTimeZonesInited extends RegionsEvent {}
