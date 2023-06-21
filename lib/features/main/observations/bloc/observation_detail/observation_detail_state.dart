part of 'observation_detail_bloc.dart';

class ObservationDetailState extends Equatable {
  /// observation for detail
  final Observation? observation;
  final EntityStatus observationLoadStatus;
  final EntityStatus observationDeleteStatus;

  // /// awareness category list
  // final List<AwarenessCategory> awarenessCategoryList;

  // /// priority level list
  // final List<PriorityLevel> priorityLevelList;

  // /// company list
  // final List<Company> companyList;

  // /// project list
  // final List<Project> projectList;

  // /// site list
  // final List<Site> siteList;

  final String message;
  const ObservationDetailState({
    this.observation,
    this.observationLoadStatus = EntityStatus.initial,
    this.observationDeleteStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        observation,
        observationLoadStatus,
        observationDeleteStatus,
        message,
      ];

  ObservationDetailState copyWith({
    Observation? observation,
    EntityStatus? observationLoadStatus,
    EntityStatus? observationDeleteStatus,
    String? message,
  }) {
    return ObservationDetailState(
      observation: observation ?? this.observation,
      observationLoadStatus:
          observationLoadStatus ?? this.observationLoadStatus,
      observationDeleteStatus:
          observationDeleteStatus ?? this.observationDeleteStatus,
      message: message ?? this.message,
    );
  }
}
