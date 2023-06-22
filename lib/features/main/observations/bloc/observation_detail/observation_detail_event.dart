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

class ObservationDetailObservationCategoryListLoaded
    extends ObservationDetailEvent {}

class ObservationDetailSiteListLoaded extends ObservationDetailEvent {}

class ObservationDetailObservationTypeListLoaded
    extends ObservationDetailEvent {}

class ObservationDetailCompanyListLoaded extends ObservationDetailEvent {}

class ObservationDetailProjectListLoaded extends ObservationDetailEvent {}

class ObservationDetailPriorityLevelListLoaded extends ObservationDetailEvent {}

class ObservationDetailUserListLoaded extends ObservationDetailEvent {}
