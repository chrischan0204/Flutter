// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'regions_bloc.dart';

abstract class RegionsEvent extends Equatable {
  const RegionsEvent();

  @override
  List<Object> get props => [];
}

class RegionsRetrieved extends RegionsEvent {}

class RegionNamesRetrieved extends RegionsEvent {}

class TimeZonesRetrievedByRegion extends RegionsEvent {
  final String region;
  const TimeZonesRetrievedByRegion({
    required this.region,
  });
  @override
  List<Object> get props => [
        region,
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

class SelectedRegionNameChanged extends RegionsEvent {
  final String selectedRegionName;
  const SelectedRegionNameChanged({
    required this.selectedRegionName,
  });
  @override
  List<Object> get props => [
        selectedRegionName,
      ];
}

class SelectedTimezonesChanged extends RegionsEvent {
  final List<String> selectedTimezones;
  const SelectedTimezonesChanged({
    required this.selectedTimezones,
  });
  @override
  List<Object> get props => [
        selectedTimezones,
      ];
}

class SelectedAssociatedSitesCountChanged extends RegionsEvent {
  final int selectedAssociatedSitesCount;
  const SelectedAssociatedSitesCountChanged({
    required this.selectedAssociatedSitesCount,
  });
  @override
  List<Object> get props => [
        selectedAssociatedSitesCount,
      ];
}

class SelectedIsActiveChanged extends RegionsEvent {
  final bool selectedIsActive;
  const SelectedIsActiveChanged({
    required this.selectedIsActive,
  });
  @override
  List<Object> get props => [
        selectedIsActive,
      ];
}

class SelectedRegionIdChanged extends RegionsEvent {
  final String selectedRegionId;
  const SelectedRegionIdChanged({
    required this.selectedRegionId,
  });
  @override
  List<Object> get props => [
        selectedRegionId,
      ];
}

class RegionsStateInited extends RegionsEvent {}

class RegionsCrudStateInited extends RegionsEvent {}
