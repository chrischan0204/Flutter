// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_detail_bloc.dart';

abstract class ObservationDetailEvent extends Equatable {
  const ObservationDetailEvent();

  @override
  List<Object> get props => [];
}

/// event to load the observation detail
class ObservationDetailLoaded extends ObservationDetailEvent {
  /// observation id to load
  final String observationId;
  const ObservationDetailLoaded({
    required this.observationId,
  });

  @override
  List<Object> get props => [observationId];
}

/// event to delete observation
class ObservationDetailObservationDeleted extends ObservationDetailEvent {
  /// observation id to delete
  final String observationId;
  const ObservationDetailObservationDeleted({
    required this.observationId,
  });

  @override
  List<Object> get props => [observationId];
}

/// event to load awarness category list
class ObservationDetailAwarenessCategoryListLoaded
    extends ObservationDetailEvent {}

/// event to load site list
class ObservationDetailSiteListLoaded extends ObservationDetailEvent {}

/// event to load observation type list
class ObservationDetailObservationTypeListLoaded
    extends ObservationDetailEvent {}

/// event to load company list
class ObservationDetailCompanyListLoaded extends ObservationDetailEvent {
  /// site id to load company list associated with it
  final String siteId;

  const ObservationDetailCompanyListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

/// event to load project list
class ObservationDetailProjectListLoaded extends ObservationDetailEvent {
  /// site id to load project list associated with it
  final String siteId;

  const ObservationDetailProjectListLoaded({required this.siteId});

  @override
  List<Object> get props => [siteId];
}

/// event to load priority level list
class ObservationDetailPriorityLevelListLoaded extends ObservationDetailEvent {}

/// event to load user list
class ObservationDetailUserListLoaded extends ObservationDetailEvent {}

/// event to load image list
class ObservationDetailImageListLoaded extends ObservationDetailEvent {}
