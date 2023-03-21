part of 'regions_bloc.dart';

class RegionsState extends Equatable {
  final List<Region> assignedRegions;
  final List<Region> unassignedRegions;

  final List<TimeZone> timeZones;

  final EntityStatus unassignedRegionsRetrievedStatus;
  final EntityStatus assignedRegionsRetrievedStatus;
  final EntityStatus timezonesRetrievedStatus;

  final Region? selectedRegion;

  // final String? selectedRegionId;
  // final String selectedRegionName;
  // final List<TimeZone> selectedTimezones;
  // final int selectedAssociatedSitesCount;
  // final bool selectedActive;
  final EntityStatus regionAddedStatus;
  final EntityStatus regionEditedStatus;
  final EntityStatus regionDeletedStatus;

  const RegionsState({
    this.assignedRegions = const [],
    this.unassignedRegionsRetrievedStatus = EntityStatus.initial,
    this.assignedRegionsRetrievedStatus = EntityStatus.initial,
    this.timezonesRetrievedStatus = EntityStatus.initial,
    this.regionAddedStatus = EntityStatus.initial,
    this.regionEditedStatus = EntityStatus.initial,
    this.regionDeletedStatus = EntityStatus.initial,
    this.selectedRegion,
    // this.selectedRegionName = '',
    // this.selectedTimezones = const [],
    this.unassignedRegions = const [],
    this.timeZones = const [],
    // this.selectedAssociatedSitesCount = 0,
    // this.selectedActive = true,
    // this.selectedRegionId,
  });

  @override
  List<Object?> get props => [
        assignedRegions,
        unassignedRegionsRetrievedStatus,
        assignedRegionsRetrievedStatus,
        timezonesRetrievedStatus,
        unassignedRegions,
        timeZones,
        regionAddedStatus,
        regionEditedStatus,
        regionDeletedStatus,
        selectedRegion,
        // selectedAssociatedSitesCount,
        // selectedActive,
        // selectedRegionId,
        // selectedRegionName,
        // selectedTimezones,
      ];

  RegionsState copyWith({
    List<Region>? assignedRegions,
    List<Region>? unassignedRegions,
    List<TimeZone>? timeZones,
    EntityStatus? unassignedRegionsRetrievedStatus,
    EntityStatus? assignedRegionsRetrievedStatus,
    EntityStatus? timezonesRetrievedStatus,
    String? selectedRegionName,
    List<TimeZone>? selectedTimezones,
    EntityStatus? regionAddedStatus,
    EntityStatus? regionEditedStatus,
    EntityStatus? regionDeletedStatus,
    int? selectedAssociatedSitesCount,
    bool? selectedActive,
    String? selectedRegionId,
    Region? selectedRegion,
  }) {
    return RegionsState(
      assignedRegions: assignedRegions ?? this.assignedRegions,
      unassignedRegions: unassignedRegions ?? this.unassignedRegions,
      timeZones: timeZones ?? this.timeZones,
      unassignedRegionsRetrievedStatus: unassignedRegionsRetrievedStatus ??
          this.unassignedRegionsRetrievedStatus,
      assignedRegionsRetrievedStatus:
          assignedRegionsRetrievedStatus ?? this.assignedRegionsRetrievedStatus,
      timezonesRetrievedStatus:
          timezonesRetrievedStatus ?? this.timezonesRetrievedStatus,
      // selectedRegionName: selectedRegionName ?? this.selectedRegionName,
      // selectedTimezones: selectedTimezones ?? this.selectedTimezones,
      // selectedAssociatedSitesCount:
      //     selectedAssociatedSitesCount ?? this.selectedAssociatedSitesCount,
      // selectedActive: selectedActive ?? this.selectedActive,
      // selectedRegionId: selectedRegionId ?? this.selectedRegionId,
      regionAddedStatus: regionAddedStatus ?? this.regionAddedStatus,
      regionEditedStatus: regionEditedStatus ?? this.regionEditedStatus,
      regionDeletedStatus: regionDeletedStatus ?? this.regionDeletedStatus,
      selectedRegion: selectedRegion ?? this.selectedRegion,
    );
  }
}
