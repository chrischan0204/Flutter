// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'regions_bloc.dart';

abstract class RegionsEvent extends Equatable {
  const RegionsEvent();

  @override
  List<Object> get props => [];
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
  final Region region;
  const RegionDeleted({
    required this.region,
  });

  @override
  List<Object> get props => [
        region,
      ];
}

// class SelectedRegionNameChanged extends RegionsEvent {
//   final String selectedRegionName;
//   const SelectedRegionNameChanged({
//     required this.selectedRegionName,
//   });
//   @override
//   List<Object> get props => [
//         selectedRegionName,
//       ];
// }

// class SelectedTimezonesChanged extends RegionsEvent {
//   final List<TimeZone> selectedTimezones;
//   const SelectedTimezonesChanged({
//     required this.selectedTimezones,
//   });
//   @override
//   List<Object> get props => [
//         selectedTimezones,
//       ];
// }

// class SelectedAssociatedSitesCountChanged extends RegionsEvent {
//   final int selectedAssociatedSitesCount;
//   const SelectedAssociatedSitesCountChanged({
//     required this.selectedAssociatedSitesCount,
//   });
//   @override
//   List<Object> get props => [
//         selectedAssociatedSitesCount,
//       ];
// }

// class SelectedActiveChanged extends RegionsEvent {
//   final bool selectedActive;
//   const SelectedActiveChanged({
//     required this.selectedActive,
//   });
//   @override
//   List<Object> get props => [
//         selectedActive,
//       ];
// }

// class SelectedRegionIdChanged extends RegionsEvent {
//   final String selectedRegionId;
//   const SelectedRegionIdChanged({
//     required this.selectedRegionId,
//   });
//   @override
//   List<Object> get props => [
//         selectedRegionId,
//       ];
// }

class RegionsStateInited extends RegionsEvent {}

class SelectedRegionChanged extends RegionsEvent {
  final Region? selectedRegion;
  const SelectedRegionChanged({
    this.selectedRegion,
  });
}

class RegionsCrudStateInited extends RegionsEvent {}
