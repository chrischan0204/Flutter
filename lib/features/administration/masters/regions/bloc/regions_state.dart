// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'regions_bloc.dart';

class RegionsState extends Equatable {
  final List<Region> assignedRegions;
  final List<Region> unassignedRegions;
  final List<TimeZone> timeZones;
  final Region? selectedRegion;

  final EntityStatus assignedRegionsRetrievedStatus;
  final EntityStatus unassignedRegionsRetrievedStatus;
  final EntityStatus timeZonesRetrievedStatus;
  final EntityStatus regionSelectedStatus;
  final EntityStatus regionAddedStatus;
  final EntityStatus regionEditedStatus;
  final EntityStatus regionDeletedStatus;
  const RegionsState({
    this.assignedRegions = const [],
    this.unassignedRegions = const [],
    this.timeZones = const [],
    this.selectedRegion,
    this.assignedRegionsRetrievedStatus = EntityStatus.initial,
    this.unassignedRegionsRetrievedStatus = EntityStatus.initial,
    this.timeZonesRetrievedStatus = EntityStatus.initial,
    this.regionSelectedStatus = EntityStatus.initial,
    this.regionAddedStatus = EntityStatus.initial,
    this.regionEditedStatus = EntityStatus.initial,
    this.regionDeletedStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        assignedRegions,
        unassignedRegions,
        timeZones,
        selectedRegion,
        assignedRegionsRetrievedStatus,
        unassignedRegionsRetrievedStatus,
        timeZonesRetrievedStatus,
        regionSelectedStatus,
        regionAddedStatus,
        regionEditedStatus,
        regionDeletedStatus,
      ];

  RegionsState copyWith({
    List<Region>? assignedRegions,
    List<Region>? unassignedRegions,
    List<TimeZone>? timeZones,
    Region? selectedRegion,
    EntityStatus? assignedRegionsRetrievedStatus,
    EntityStatus? unassignedRegionsRetrievedStatus,
    EntityStatus? timeZonesRetrievedStatus,
    EntityStatus? regionSelectedStatus,
    EntityStatus? regionAddedStatus,
    EntityStatus? regionEditedStatus,
    EntityStatus? regionDeletedStatus,
  }) {
    return RegionsState(
      assignedRegions: assignedRegions ?? this.assignedRegions,
      unassignedRegions: unassignedRegions ?? this.unassignedRegions,
      timeZones: timeZones ?? this.timeZones,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      assignedRegionsRetrievedStatus:
          assignedRegionsRetrievedStatus ?? this.assignedRegionsRetrievedStatus,
      unassignedRegionsRetrievedStatus: unassignedRegionsRetrievedStatus ??
          this.unassignedRegionsRetrievedStatus,
      timeZonesRetrievedStatus:
          timeZonesRetrievedStatus ?? this.timeZonesRetrievedStatus,
      regionSelectedStatus: regionSelectedStatus ?? this.regionSelectedStatus,
      regionAddedStatus: regionAddedStatus ?? this.regionAddedStatus,
      regionEditedStatus: regionEditedStatus ?? this.regionEditedStatus,
      regionDeletedStatus: regionDeletedStatus ?? this.regionDeletedStatus,
    );
  }
}
