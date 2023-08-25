part of 'regions_bloc.dart';

class RegionsState extends Equatable {
  final List<Region> assignedRegions;
  final List<Region> unassignedRegions;
  final List<TimeZone> timeZones;
  final Region? selectedRegion;

  final EntityStatus assignedRegionsLoadedStatus;
  final EntityStatus unassignedRegionsLoadedStatus;
  final EntityStatus timeZonesLoadedStatus;
  final EntityStatus regionSelectedStatus;
  final EntityStatus regionCrudStatus;

  final String message;
  const RegionsState({
    this.assignedRegions = const [],
    this.unassignedRegions = const [],
    this.timeZones = const [],
    this.selectedRegion,
    this.assignedRegionsLoadedStatus = EntityStatus.initial,
    this.unassignedRegionsLoadedStatus = EntityStatus.initial,
    this.timeZonesLoadedStatus = EntityStatus.initial,
    this.regionSelectedStatus = EntityStatus.initial,
    this.regionCrudStatus = EntityStatus.initial,
    this.message = '',
  });

  // set fields for equality of region
  @override
  List<Object?> get props => [
        assignedRegions,
        unassignedRegions,
        timeZones,
        selectedRegion,
        assignedRegionsLoadedStatus,
        unassignedRegionsLoadedStatus,
        timeZonesLoadedStatus,
        regionSelectedStatus,
        regionCrudStatus,
        message,
      ];

  // return new region with updated fields
  RegionsState copyWith({
    List<Region>? assignedRegions,
    List<Region>? unassignedRegions,
    List<TimeZone>? timeZones,
    Region? selectedRegion,
    EntityStatus? assignedRegionsLoadedStatus,
    EntityStatus? unassignedRegionsLoadedStatus,
    EntityStatus? timeZonesLoadedStatus,
    EntityStatus? regionSelectedStatus,
    EntityStatus? regionCrudStatus,
    String? message,
  }) {
    return RegionsState(
      assignedRegions: assignedRegions ?? this.assignedRegions,
      unassignedRegions: unassignedRegions ?? this.unassignedRegions,
      timeZones: timeZones ?? this.timeZones,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      assignedRegionsLoadedStatus:
          assignedRegionsLoadedStatus ?? this.assignedRegionsLoadedStatus,
      unassignedRegionsLoadedStatus:
          unassignedRegionsLoadedStatus ?? this.unassignedRegionsLoadedStatus,
      timeZonesLoadedStatus:
          timeZonesLoadedStatus ?? this.timeZonesLoadedStatus,
      regionSelectedStatus: regionSelectedStatus ?? this.regionSelectedStatus,
      regionCrudStatus: regionCrudStatus ?? this.regionCrudStatus,
      message: message ?? this.message,
    );
  }
}
