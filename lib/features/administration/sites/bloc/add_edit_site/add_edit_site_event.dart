// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_site_bloc.dart';

abstract class AddEditSiteEvent extends Equatable {
  const AddEditSiteEvent();

  @override
  List<Object> get props => [];
}

/// event to add site
class AddEditSiteAdded extends AddEditSiteEvent {}

/// event to edit site
class AddEditSiteEdited extends AddEditSiteEvent {
  /// site id to edit
  final String id;
  const AddEditSiteEdited({required this.id});

  @override
  List<Object> get props => [id];
}

/// event to load the site by id
class AddEditSiteLoaded extends AddEditSiteEvent {
  /// site id to load
  final String id;
  const AddEditSiteLoaded({required this.id});

  @override
  List<Object> get props => [id];
}

/// event to load the region list
class AddEditSiteRegionListLoaded extends AddEditSiteEvent {}

/// event to load time zone list by region id
class AddEditTimeZoneListLoaded extends AddEditSiteEvent {
  final String regionId;
  const AddEditTimeZoneListLoaded({required this.regionId});

  @override
  List<Object> get props => [regionId];
}

/// event to change the site name
class AddEditSiteNameChanged extends AddEditSiteEvent {
  /// site name to change
  final String name;
  const AddEditSiteNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

/// event to change the region
class AddEditSiteRegionChanged extends AddEditSiteEvent {
  /// region to change
  final Region region;
  const AddEditSiteRegionChanged({required this.region});

  @override
  List<Object> get props => [region];
}

/// event to change the time zone
class AddEditSiteTimeZoneChanged extends AddEditSiteEvent {
  /// time zone to change
  final TimeZone timeZone;
  const AddEditSiteTimeZoneChanged({required this.timeZone});

  @override
  List<Object> get props => [timeZone];
}

/// event to change the site type
class AddEditSiteTypeChanged extends AddEditSiteEvent {
  /// site type to change
  final String siteType;
  const AddEditSiteTypeChanged({required this.siteType});

  @override
  List<Object> get props => [siteType];
}

/// event to change the site code
class AddEditSiteCodeChanged extends AddEditSiteEvent {
  /// site code to change
  final String siteCode;
  const AddEditSiteCodeChanged({required this.siteCode});

  @override
  List<Object> get props => [siteCode];
}

/// event to change the reference name
class AddEditSiteReferenceCodeChanged extends AddEditSiteEvent {
  /// reference code to change
  final String referenceCode;
  const AddEditSiteReferenceCodeChanged({required this.referenceCode});

  @override
  List<Object> get props => [referenceCode];
}
