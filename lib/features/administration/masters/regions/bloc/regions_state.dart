part of 'regions_bloc.dart';

class RegionsState extends Equatable {
  final List<Region> regions;
  final List<String> regionNames;
  final List<String> timeZones;
  final EntityStatus regionsRetrievedStatus;
  final EntityStatus regionNamesRetrievedStatus;
  final EntityStatus timezonesRetrievedStatus;
  final String selectedRegionId;
  final String selectedRegionName;
  final List<String> selectedTimezones;
  final int selectedAssociatedSitesCount;
  final bool selectedIsActive;
  final EntityStatus regionAddedStatus;
  final EntityStatus regionEditedStatus;
  final EntityStatus regionDeletedStatus;

  const RegionsState({
    this.regions = const [],
    this.regionsRetrievedStatus = EntityStatus.initial,
    this.regionNamesRetrievedStatus = EntityStatus.initial,
    this.timezonesRetrievedStatus = EntityStatus.initial,
    this.regionAddedStatus = EntityStatus.initial,
    this.regionEditedStatus = EntityStatus.initial,
    this.regionDeletedStatus = EntityStatus.initial,
    this.selectedRegionName = '',
    this.selectedTimezones = const [],
    this.regionNames = const [],
    this.timeZones = const [],
    this.selectedAssociatedSitesCount = 0,
    this.selectedIsActive = true,
    this.selectedRegionId = '',
  });

  @override
  List<Object> get props => [
        regions,
        regionsRetrievedStatus,
        regionNamesRetrievedStatus,
        timezonesRetrievedStatus,
        regionNames,
        selectedRegionName,
        selectedTimezones,
        timeZones,
        regionAddedStatus,
        regionEditedStatus,
        regionDeletedStatus,
        selectedAssociatedSitesCount,
        selectedIsActive,
        selectedRegionId,
      ];

  RegionsState copyWith({
    List<Region>? regions,
    List<String>? regionNames,
    List<String>? timeZones,
    EntityStatus? regionsRetrievedStatus,
    EntityStatus? regionNamesRetrievedStatus,
    EntityStatus? timezonesRetrievedStatus,
    String? selectedRegionName,
    List<String>? selectedTimezones,
    EntityStatus? regionAddedStatus,
    EntityStatus? regionEditedStatus,
    EntityStatus? regionDeletedStatus,
    int? selectedAssociatedSitesCount,
    bool? selectedIsActive,
    String? selectedRegionId,
  }) {
    return RegionsState(
      regions: regions ?? this.regions,
      regionNames: regionNames ?? this.regionNames,
      timeZones: timeZones ?? this.timeZones,
      regionsRetrievedStatus:
          regionsRetrievedStatus ?? this.regionsRetrievedStatus,
      regionNamesRetrievedStatus:
          regionNamesRetrievedStatus ?? this.regionNamesRetrievedStatus,
      timezonesRetrievedStatus:
          timezonesRetrievedStatus ?? this.timezonesRetrievedStatus,
      selectedRegionName: selectedRegionName ?? this.selectedRegionName,
      selectedTimezones: selectedTimezones ?? this.selectedTimezones,
      regionAddedStatus: regionAddedStatus ?? this.regionAddedStatus,
      regionEditedStatus: regionEditedStatus ?? this.regionEditedStatus,
      regionDeletedStatus: regionDeletedStatus ?? this.regionDeletedStatus,
      selectedAssociatedSitesCount:
          selectedAssociatedSitesCount ?? this.selectedAssociatedSitesCount,
      selectedIsActive: selectedIsActive ?? this.selectedIsActive,
      selectedRegionId: selectedRegionId ?? this.selectedRegionId,
    );
  }
}
