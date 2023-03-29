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
  final EntityStatus regionCrudStatus;

  final String message;
  const RegionsState({
    this.assignedRegions = const [],
    this.unassignedRegions = const [],
    this.timeZones = const [],
    this.selectedRegion,
    this.assignedRegionsRetrievedStatus = EntityStatus.initial,
    this.unassignedRegionsRetrievedStatus = EntityStatus.initial,
    this.timeZonesRetrievedStatus = EntityStatus.initial,
    this.regionSelectedStatus = EntityStatus.initial,
    this.regionCrudStatus = EntityStatus.initial,
    this.message = '',
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
        regionCrudStatus,
        message,
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
    EntityStatus? regionCrudStatus,
    String? message,
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
      regionCrudStatus: regionCrudStatus ?? this.regionCrudStatus,
      message: message ?? this.message,
    );
  }
}
