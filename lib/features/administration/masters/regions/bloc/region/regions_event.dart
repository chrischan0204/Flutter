// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'regions_bloc.dart';

abstract class RegionsEvent extends Equatable {
  const RegionsEvent();

  @override
  List<Object?> get props => [];
}

class AssignedRegionsRetrieved extends RegionsEvent {}

class UnassignedRegionsRetrieved extends RegionsEvent {}

class TimeZonesRetrievedForRegion extends RegionsEvent {
  final String regionId;
  const TimeZonesRetrievedForRegion({
    required this.regionId,
  });
  @override
  List<Object> get props => [
        regionId,
      ];
}

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

class RegionsStatusInited extends RegionsEvent {
  const RegionsStatusInited();
}

class RegionsTimeZonesInited extends RegionsEvent {}
